import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/data/model/offline_record_model.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

// Ek record upload ka result
class SubmitResult {
  final bool isSuccess;
  final bool isNetworkError;
  final String message;

  SubmitResult(this.isSuccess, this.message, {this.isNetworkError = false});
}

// Bahut saare records upload ka result
class UploadSummary {
  final int uploaded;
  final String? error;

  UploadSummary(this.uploaded, this.error);
}

class RecordHelper {
  static Box<OfflineRecordModel> get box => HiveDataBase.offlineRecordBox!;

  static int get pendingCount => HiveDataBase.offlineRecordBox?.length ?? 0;

  // ###########################################################################
  //                         PART A: COMMON CODE
  //              (saari activities yahi use karti hain)
  // ###########################################################################

  // ===========================================================================
  // A1. EK RECORD SERVER KO BHEJO
  // ===========================================================================
  static Future<SubmitResult> uploadRecord(OfflineRecordModel record) async {
    try {
      List<ImageRequestObject> files = [];
      String path = record.filePath ?? "";
      if (path.isNotEmpty && File(path).existsSync()) {
        files.add(ImageRequestObject(key: "attach_file", path: path));
      }

      var res = await ServerRequest.postDataWithFile(
        urlEndPoint: record.url ?? "",
        body: Map<String, dynamic>.from(record.body ?? {}),
        imageRequestObject: files,
        throwOnNetworkError: true, // Net gaya to DioException aayegi
      );

      // JSON nahi aaya = server ki problem
      if (res is! Map) {
        return SubmitResult(false, "Internal Server Error");
      }

      // Success
      if (res['success'] == 200) {
        return SubmitResult(true, res['data']?.toString() ?? "Uploaded");
      }

      // Server ne mana kiya (400 / 415 / ...)
      String error = res['data']?.toString() ?? "Internal Server Error";
      error = error.replaceAll("{", "").replaceAll("}", "");
      return SubmitResult(false, error);
    } on DioException {
      return SubmitResult(false, "No internet", isNetworkError: true);
    } catch (e) {
      return SubmitResult(false, e.toString());
    }
  }

  // ===========================================================================
  // A2. FORM SUBMIT: net hai to server, nahi to Hive
  // true  = kaam ho gaya (screen band karo)
  // false = galti hai (screen par hi raho)
  // ===========================================================================
  static Future<bool> submitOrSaveOffline({
    required BuildContext context,
    required String activityName,
    required String url,
    required Map<String, String> body,
    required String filePath,
  }) async {
    try {
      // Model banao
      OfflineRecordModel record = OfflineRecordModel(
        activityName: activityName,
        url: url,
        body: body,
        filePath: filePath,
        reportNo: body["report_no"] ?? "",
        activityDate: body["activity_date"] ?? "",
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      // Net hai -> seedha server
      if (await ConnectivityHelper.checkInterNetConnect()) {
        SubmitResult res = await uploadRecord(record);

        if (res.isSuccess) {
          if (context.mounted) {
            SnackBarSuccessWidget(context).show(message: res.message);
          }
          return true; // Hive me save NAHI
        }

        if (!res.isNetworkError) {
          if (context.mounted) {
            SnackBarErrorWidget(context).show(message: res.message);
          }
          return false; // Galat data, save NAHI
        }
        // Net beech me gaya -> neeche Hive me save
      }

      // Hive me save
      record.filePath = await _copyFileToSafeFolder(filePath);
      await box.add(record);

      if (context.mounted) {
        SnackBarSuccessWidget(context).show(
          message: "No internet. $activityName saved offline and will "
              "upload automatically when internet is available.",
        );
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        SnackBarErrorWidget(context).show(message: e.toString());
      }
      return false;
    }
  }

  // ===========================================================================
  // A3. BAHUT SAARE RECORDS BHEJO (Record screen + auto sync)
  // ===========================================================================

  /// Upload chal raha hai ya nahi (screen ise sun kar loader dikhati hai)
  static final ValueNotifier<bool> isSyncingNotifier = ValueNotifier(false);

  /// Abhi KAUNSA record upload ho raha hai (us row par loader dikhane ke liye)
  static final ValueNotifier<dynamic> uploadingKeyNotifier = ValueNotifier(null);

  /// Ek time pe ek hi upload
  static bool get isUploading => isSyncingNotifier.value;

  static Future<UploadSummary> uploadRecords({required List keys}) async {
    if (isUploading) return UploadSummary(0, "Upload already running");
    isSyncingNotifier.value = true;

    int uploaded = 0;
    String? error;

    try {
      for (var key in keys) {
        OfflineRecordModel? record = box.get(key);
        if (record == null) continue;

        uploadingKeyNotifier.value = key; // is row par loader

        SubmitResult res = await uploadRecord(record);

        if (res.isSuccess) {
          String path = record.filePath ?? "";
          await box.delete(key); // Key se delete, index se nahi
          _deleteSavedFile(path);
          uploaded++;
        } else {
          error = res.message;
          if (res.isNetworkError) break; // Net gaya, baaki baad me

          // Server ne mana kiya -> error record me save karo
          record.lastError = res.message;
          await record.save();
        }
      }
    } finally {
      uploadingKeyNotifier.value = null;
      isSyncingNotifier.value = false;
    }

    return UploadSummary(uploaded, error);
  }

  // ===========================================================================
  // A3.1 DELETE (Record screen se)
  // ===========================================================================

  /// Ek record delete (Hive + copy ki hui file)
  static Future<void> deleteRecord(dynamic key) async {
    OfflineRecordModel? record = box.get(key);
    if (record == null) return;
    String path = record.filePath ?? "";
    await box.delete(key);
    _deleteSavedFile(path);
  }

  /// Bahut saare records delete
  static Future<void> deleteRecords(List keys) async {
    for (var key in keys) {
      await deleteRecord(key);
    }
  }

  // ===========================================================================
  // A4. CHHOTE HELPER FUNCTIONS
  // ===========================================================================

  /// Location lo, na mile to error dikhao
  static Future<LocationModel?> _getLocation(BuildContext context) async {
    var location = await LocationHelper.getLocation(context: context);
    if (location == null && context.mounted) {
      SnackBarErrorWidget(context)
          .show(message: "Unable to get location. Please enable GPS.");
    }
    return location;
  }

  /// [1, 2, 3] -> "1,2,3"
  static String _alignmentIds(List<AlignmentModel> list) {
    return list.map((e) => e.id).join(",");
  }

  /// Photo ko permanent folder me copy karo (cache wali delete ho sakti hai)
  static Future<String> _copyFileToSafeFolder(String path) async {
    if (path.isEmpty) return "";
    File file = File(path);
    if (!file.existsSync()) return "";

    Directory docs = await getApplicationDocumentsDirectory();
    Directory folder = Directory(p.join(docs.path, 'offline_files'));
    await folder.create(recursive: true);

    String newPath = p.join(folder.path,
        "${DateTime.now().millisecondsSinceEpoch}${p.extension(path)}");
    return (await file.copy(newPath)).path;
  }

  /// Upload ke baad copy ki hui file delete karo
  static void _deleteSavedFile(String path) {
    if (path.isEmpty || !path.contains('offline_files')) return;
    try {
      File file = File(path);
      if (file.existsSync()) file.deleteSync();
    } catch (_) {}
  }

  // ###########################################################################
  //                         PART B: ACTIVITIES
  //     Har activity sirf 3 kaam karti hai: location, body, submitOrSaveOffline
  // ###########################################################################

  // ===========================================================================
  // B1. ROUTE SURVEY
  // ===========================================================================
  static Future<bool> submitRouteSurvey({
    required BuildContext context,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required String tpIpChainage,
    required String tpIpNOS,
    required String detail,
    required String detailStructure,
    required String chainage,
    required String bearing,
    required String terrain,
    required String activityRemark,
    required LoginDataModel userData,
    required File file,
    required String chainageFrom,
    required String chainageTo,
    required String totalLength,
    required WeatherModel weatherData,
    required GroundTypeModel groundTypeData,
  }) async {
    final location = await _getLocation(context);
    if (location == null) return false;

    Map<String, String> body = {
      "schema": userData.schema.toString(),
      "spread_id": userData.spreadId.toString(),
      "section_id": userData.sectionId.toString(),
      "user_id": userData.userId.toString(),
      "chainage": chainage,
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
      "total_length": totalLength,
      "report_no": reportNumber,
      "activity_date": date,
      "tp_ip_chainage": tpIpChainage,
      "tp_ip_nos": tpIpNOS,
      "tp_remarks": detail,
      "detail_structure": detailStructure,
      "bearing_angle": bearing,
      "terrain": terrain,
      "activity_remarks": activityRemark,
      "latitude": location.lat.toString(),
      "longitude": location.long.toString(),
      "alignment_sheet_id": _alignmentIds(multipleAlignmentData),
      "weather": weatherData.id?.toString() ?? "",
      "ground_type_id": groundTypeData.id?.toString() ?? "",
    };

    if (!context.mounted) return false;
    return submitOrSaveOffline(
      context: context,
      activityName: OfflineActivity.routeSurvey,
      url: APIs.addRouteSurveyApi,
      body: body,
      filePath: file.path,
    );
  }

  // ===========================================================================
  // B2. ROU HANDOVER
  // ===========================================================================
  static Future<bool> submitRouHandover({
    required BuildContext context,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String tenderNo,
    required String date,
    required String typeofGround,
    required String tpIpNOS,
    required String tpIpRemark,
    required String activityRemark,
    required LoginDataModel userData,
    required File file,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String chainageTo,
    required String totalLength,
  }) async {
    final location = await _getLocation(context);
    if (location == null) return false;

    Map<String, String> body = {
      "schema": userData.schema.toString(),
      "spread_id": userData.spreadId.toString(),
      "section_id": userData.sectionId.toString(),
      "user_id": userData.userId.toString(),
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
      "total_length": totalLength,
      "report_no": reportNumber,
      "tender_no": tenderNo,
      "activity_date": date,
      "type_of_ground": typeofGround,
      "ip_tp_no": tpIpNOS,
      "other_details": tpIpRemark,
      "activity_remarks": activityRemark,
      "latitude": location.lat.toString(),
      "longitude": location.long.toString(),
      "alignment_sheet_id": _alignmentIds(multipleAlignmentData),
      "weather": weatherData.id?.toString() ?? "",
    };

    if (!context.mounted) return false;
    return submitOrSaveOffline(
      context: context,
      activityName: OfflineActivity.rouHandover,
      url: APIs.addRouHandoverinsertApi,
      body: body,
      filePath: file.path,
    );
  }

  // ===========================================================================
  // B3. CLEAR & GRADE
  // ===========================================================================
  static Future<bool> submitClearGrade({
    required BuildContext context,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required String tpIpChainage,
    required String ipNumber,
    required String ipNumberFrom,
    required String tpIpNOS,
    required String structureDetail,
    required String boundaryLocation,
    required String activityRemark,
    required LoginDataModel userData,
    required File file,
    required String groundType,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String chainageTo,
    required String chainage,
    required String machiney,
    required String details,
    required String manpower,
    required TerrainTypeModel terrainTypeData,
    required String gapLength,
    required String gapDescription,
  }) async {
    final location = await _getLocation(context);
    if (location == null) return false;

    Map<String, String> body = {
      "schema": userData.schema.toString(),
      "spread_id": userData.spreadId.toString(),
      "section_id": userData.sectionId.toString(),
      "user_id": userData.userId.toString(),
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
      "chainage": chainage,
      "report_no": reportNumber,
      "activity_date": date,
      "tp_ip_from": tpIpChainage,
      "tp_ip_to": tpIpNOS,
      "ip_no_from": ipNumber,
      "ip_no_to": ipNumberFrom,
      "ground_type": groundType,
      "structure_detail": structureDetail,
      "boundary_location": boundaryLocation,
      "gap_length": gapLength,
      "gap_description": gapDescription,
      "activity_remarks": activityRemark,
      "latitude": location.lat.toString(),
      "longitude": location.long.toString(),
      "alignment_sheet_id": _alignmentIds(multipleAlignmentData),
      "weather": weatherData.id?.toString() ?? "",
      "terrain_id": terrainTypeData.id?.toString() ?? "",
      "machiney": machiney,
      "manpower": manpower,
      "details": details,
    };

    if (!context.mounted) return false;
    return submitOrSaveOffline(
      context: context,
      activityName: OfflineActivity.clearGrade,
      url: APIs.addCGinsertApi,
      body: body,
      filePath: file.path,
    );
  }

  // ===========================================================================
  // B4. TRENCHING
  // ===========================================================================
  static Future<bool> submitTrenching({
    required BuildContext context,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required JointNumberModel jointNumberFromModel,
    required JointNumberModel jointNumberToModel,
    required String trenchingDepth,
    required String terrainType,
    required String activityRemark,
    required File file,
    required LoginDataModel userData,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String chainageTo,
    required String toWidth,
    required String bottomWidth,
    required String ipFrom,
    required String ipTo,
    required String detailsOfStructure,
    required String availabilityOfMimimumCover,
    required String separationOfArableSoil,
    required String suitabilityOfTrenchProfileForBends,
    required String provisionOfWarningSignsSafetySigns,
    required String verificationOfMinimumDepth,
    required String seismicZoneAndCover,
    required String chainageFromSingle,
    required String chainageToSingle,
  }) async {
    final location = await _getLocation(context);
    if (location == null) return false;

    Map<String, String> body = {
      "schema": userData.schema.toString(),
      "spread_id": userData.spreadId.toString(),
      "section_id": userData.sectionId.toString(),
      "user_id": userData.userId.toString(),
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
      "report_no": reportNumber,
      "activity_date": date,
      "activity_remarks": activityRemark,
      "top_width": toWidth,
      "bottom_width": bottomWidth,
      "ip_from": ipFrom.isNotEmpty ? ipFrom : "0",
      "ip_to": ipTo.isNotEmpty ? ipTo : "0",
      "details_of_structure": detailsOfStructure,
      "availability_of_mimimum_cover": availabilityOfMimimumCover,
      "separation_of_arable_soil": separationOfArableSoil,
      "suitability_of_trench_profile_for_bends":
      suitabilityOfTrenchProfileForBends,
      "provision_of_warning_signs_safety_signs":
      provisionOfWarningSignsSafetySigns,
      "verification_of_minimum_depth": verificationOfMinimumDepth,
      "seismic_zone_and_cover_requirements": seismicZoneAndCover,
      "chainage_from_single": chainageFromSingle,
      "chainage_to_single": chainageToSingle,
      "from_joint_id": jointNumberFromModel.id?.toString() ?? "",
      "to_joint_id": jointNumberToModel.id?.toString() ?? "",
      "trenching_depth": trenchingDepth,
      "terrain_type": terrainType.isNotEmpty ? terrainType : "0",
      "latitude": location.lat.toString(),
      "longitude": location.long.toString(),
      "alignment_sheet_id": _alignmentIds(multipleAlignmentData),
      "weather": weatherData.id?.toString() ?? "",
    };

    if (!context.mounted) return false;
    return submitOrSaveOffline(
      context: context,
      activityName: OfflineActivity.trenching,
      url: APIs.trenchinginsertApi,
      body: body,
      filePath: file.path,
    );
  }

  // ===========================================================================
  // B5. BACK FILLING
  // ===========================================================================
  static Future<bool> submitBackFilling({
    required BuildContext context,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required VisualChecksModel plasticGrating,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointNumberModel fromJointData,
    required JointNumberModel toJointData,
    required JointTypeModel jointTypeData,
    required String chainageFrom,
    required String chainageTo,
    required String warningMat,
    required String slopeBreaker,
    required String postPadding,
    required String antiBuoyancy,
    required String locationString,
    required String cover,
    required String hdpeDuct,
    required String plastiGrating,
    required File file,
    required PipeDiaModel pipeDiaData,
    required ThicknessModel thicknessData,
  }) async {
    final location = await _getLocation(context);
    if (location == null) return false;

    Map<String, String> body = {
      "schema": userData.schema.toString(),
      "spread_id": userData.spreadId.toString(),
      "section_id": userData.sectionId.toString(),
      "user_id": userData.userId.toString(),
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
      "report_no": reportNumber,
      "activity_date": date,
      "activity_remarks": activityRemark,
      "latitude": location.lat.toString(),
      "longitude": location.long.toString(),
      "alignment_sheet_id": _alignmentIds(multipleAlignmentData),
      "plastic_grating": plasticGrating.id?.toString() ??
          (plastiGrating.isNotEmpty ? plastiGrating : "0"),
      "joint_id": jointTypeData.id?.toString() ?? "0",
      "from_joint_id": fromJointData.id?.toString() ?? "",
      "to_joint_id": toJointData.id?.toString() ?? "",
      "post_padding": postPadding,
      "slope_breaker": slopeBreaker,
      "warning_mat": warningMat,
      "anti_buoyancy": antiBuoyancy,
      "location": locationString,
      "cover": cover,
      "hdpe_duct": hdpeDuct,
      "weather": weatherData.id?.toString() ?? "",
      "pipe_dia_id": pipeDiaData.id?.toString() ?? "0",
      "pipe_thickness_id": thicknessData.id?.toString() ?? "0",
    };

    if (!context.mounted) return false;
    return submitOrSaveOffline(
      context: context,
      activityName: OfflineActivity.backFilling,
      url: APIs.addBackFillingApi,
      body: body,
      filePath: file.path,
    );
  }
}