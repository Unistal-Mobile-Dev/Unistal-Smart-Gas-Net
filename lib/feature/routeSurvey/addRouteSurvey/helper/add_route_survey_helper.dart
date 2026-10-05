import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:path/path.dart' as p;

class AddRouteSurveyHelper {
  static final client = AppConfig.instanceInit()!.client;

  // ===========================================================================
  // VALIDATION
  // ===========================================================================

  static Future<dynamic> textFiledValidation({
    required BuildContext context,
    required AlignmentModel alignmentData,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required String tpIpChainage,
    required String tpIpNOS,
    required String tpIpRemark,
    required String bearing,
    required String terrain,
    required String activityRemark,
  }) async {
    try {
      if (date.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select date");
        return false;
      } else if (alignmentData.id == null || multipleAlignmentData.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select alignment");
        return false;
      } else if (reportNumber.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter report number");
        return false;
      } else if (tpIpChainage.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter TP IP Chainage");
        return false;
      } else if (tpIpNOS.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter tp ip number");
        return false;
      } else if (tpIpRemark.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter tp ip remark");
        return false;
      } else if (bearing.isEmpty &&
          (client == Client.vppl || client == Client.urjagati)) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter bearing angle");
        return false;
      } else if (terrain.isEmpty &&
          (client == Client.vppl || client == Client.urjagati)) {
        SnackBarErrorWidget(context).show(message: "Please enter terrain");
        return false;
      } else if (activityRemark.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter activity remark");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // ===========================================================================
  // MASTER DATA
  // ===========================================================================

  static Future<List<GroundTypeModel>> fetchGroundTypeData() async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = "${APIs.getGroundTypeApi}?schema=${userData!.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null && res['success'] == 200 && res['data'] != null) {
        final List<GroundTypeModel> groundTypeList = groundTypeListResponse(res['data']);
        if (HiveDataBase.groundTypeBox != null && HiveDataBase.groundTypeBox!.isOpen && groundTypeList.isNotEmpty) {
          await HiveDataBase.groundTypeBox!.clear();
          await HiveDataBase.groundTypeBox!.addAll(groundTypeList);
        }
        return groundTypeList;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<dynamic> fetchAlignmentData() async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getAlignmentSheetApi;
      var param = {
        "schema": userData!.schema,
        "spread_id": userData.spreadId,
        "section_id": userData.sectionId,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null && res['success'] == 200 && res['data'] != null) {
        final List<AlignmentModel> alignmentList =
        alignmentResponseList(res['data']);
        if (HiveDataBase.alignmentBox != null &&
            HiveDataBase.alignmentBox!.isOpen &&
            alignmentList.isNotEmpty) {
          await HiveDataBase.alignmentBox!.clear();
          await HiveDataBase.alignmentBox!.addAll(alignmentList);
        }
        return alignmentList;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ===========================================================================
  // SUBMIT
  //  - Internet hai      -> direct API, Hive me NAHI
  //  - Internet nahi     -> Hive me save (auto-sync baad me bhejega)
  //  - Beech me net gaya -> Hive me save
  //  - Server reject     -> error dikhao, save mat karo
  // ===========================================================================

  // static Future<dynamic> submitData({
  //   required BuildContext context,
  //   required AlignmentModel alignmentData,
  //   required List<AlignmentModel> multipleAlignmentData,
  //   required String reportNumber,
  //   required String date,
  //   required String tpIpChainage,
  //   required String tpIpNOS,
  //   required String detail,
  //   required String detailStructure,
  //   required String chainage,
  //   required String bearing,
  //   required String terrain,
  //   required String activityRemark,
  //   required LoginDataModel userData,
  //   required File file,
  //   required String chainageFrom,
  //   required String chainageTo,
  //   required String totalLength,
  //   required WeatherModel weatherData,
  //   required GroundTypeModel groundTypeData,
  // }) async {
  //   try {
  //     // 1. Location (GPS offline bhi kaam karta hai)
  //     final location = await LocationHelper.getLocation(context: context);
  //     if (location == null) {
  //       if (context.mounted) {
  //         SnackBarErrorWidget(context)
  //             .show(message: "Unable to get location. Please enable GPS.");
  //       }
  //       return null;
  //     }
  //
  //     // 2. Model ek baar banao — API aur Hive dono ke liye
  //     final routeSurveyModel = RouteSurveyModel(
  //       chainage: chainage,
  //       chainageFrom: chainageFrom,
  //       chainageTo: chainageTo,
  //       totalLength: totalLength,
  //       reportNo: reportNumber,
  //       activityDate: date,
  //       tpIpChainage: tpIpChainage,
  //       tpIpNos: tpIpNOS,
  //       tpRemarks: detail,
  //       detailStructure: detailStructure,
  //       bearingAngle: bearing,
  //       terrain: terrain,
  //       activityRemarks: activityRemark,
  //       latitude: location.lat.toString(),
  //       longitude: location.long.toString(),
  //       alignmentSheetId: multipleAlignmentData.map((e) => e.id).join(","),
  //       weather: weatherData.id?.toString() ?? "",
  //       groundTypeId: groundTypeData.id?.toString() ?? "",
  //       filePath: file.path,
  //     );
  //
  //     // 3. Online -> direct server
  //     if (await ConnectivityHelper.checkInterNetConnect()) {
  //       final res = await RecordHelper.submitRouteSurveyData(
  //         model: routeSurveyModel,
  //         userData: userData,
  //         context : context,
  //       );
  //
  //       if (res.isSuccess) {
  //         if (context.mounted) {
  //           SnackBarSuccessWidget(context).show(message: res.message);
  //         }
  //         return true; // Hive me save NAHI
  //       }
  //
  //       if (!res.isNetworkError) {
  //         // Server ne reject kiya -> error dikhao, save mat karo
  //         if (context.mounted) {
  //           SnackBarErrorWidget(context).show(message: res.message);
  //         }
  //         return null;
  //       }
  //
  //       // Network beech me gaya -> neeche offline save
  //       if (kDebugMode) print("Upload failed, saving offline: ${res.message}");
  //     }
  //
  //     // 4. Offline -> Hive me save
  //     routeSurveyModel.filePath =
  //     await _persistFile(routeSurveyModel.filePath ?? "");
  //     await HiveDataBase.routeSurveyBox!.add(routeSurveyModel);
  //
  //     if (context.mounted) {
  //       SnackBarSuccessWidget(context).show(
  //           message: "No internet. Survey saved offline and will upload "
  //               "automatically when internet is available.");
  //     }
  //     return true;
  //   } catch (e) {
  //     if (context.mounted) {
  //       SnackBarErrorWidget(context).show(message: e.toString());
  //     }
  //     return null;
  //   }
  // }

  /// Temp file ko permanent app storage me copy karo.
  static Future<String> _persistFile(String path) async {
    if (path.isEmpty) return "";
    final file = File(path);
    if (!await file.exists()) return "";
    final docs = await getApplicationDocumentsDirectory();
    final folder = Directory(p.join(docs.path, 'route_survey_files'));
    await folder.create(recursive: true);
    final newPath = p.join(folder.path,
        '${DateTime.now().millisecondsSinceEpoch}${p.extension(path)}');
    return (await file.copy(newPath)).path;
  }

  // ===========================================================================
  // SYNC — RouteSurveySyncService handle karta hai (purane callers ke liye wrapper)
  // ===========================================================================

  // static Future<int> syncPendingRouteSurveys({BuildContext? context}) async {
  //   final summary = await RouteSurveySyncService.instance.syncPending();
  //   return summary.uploaded;
  // }
  //
  // static int get pendingCount => RouteSurveySyncService.instance.pendingCount;

  // ===========================================================================
  // PICKERS
  // ===========================================================================

  static Future<dynamic> imagePiker({required BuildContext context}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 60,
          maxHeight: 1200,
          maxWidth: 950,
          preferredCameraDevice: CameraDevice.rear);
      return photo != null ? File(photo.path) : null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> filePiker({required BuildContext context}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc'],
      );
      if (result == null || result.paths.first == null) return null;

      final file = File(result.paths.first!);
      final ext = file.path.split('.').last.toLowerCase();
      if (['jpg', 'jpeg', 'png', 'pdf', 'doc'].contains(ext)) return file;

      if (context.mounted) {
        SnackBarErrorWidget(context)
            .show(message: "Only PNG, JPG, JPEG, DOC, PDF files are allowed.");
      }
      return null;
    } catch (e) {
      return null;
    }
  }

}