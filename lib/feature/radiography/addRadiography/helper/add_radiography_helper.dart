import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_source_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddRadiographyHelper {

  static Future<dynamic> fetchFilmTypeData() async {
    try {
      String url = APIs.getConstantApi + "?key=filmtype";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null && res is Map<String, dynamic>) {
        // Take first entry from map
        final entry = res.entries.first;
        return TerrainTypeModel(
          id: entry.key,
          name: entry.value,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchDensityData() async {
    try {
      String url = APIs.getConstantApi + "?key=rtdensity";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null && res is Map<String, dynamic>) {
        // Take first entry from map
        final entry = res.entries.first;
        return TerrainTypeModel(
          id: entry.key,
          name: entry.value,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchSensitivityData() async {
    try {
      String url = APIs.getConstantApi + "?key=RTSensitivity";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null && res is Map<String, dynamic>) {
        // Take first entry from map
        final entry = res.entries.first;
        return TerrainTypeModel(
          id: entry.key,
          name: entry.value,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchInspectionTechnique() async {
    try {
      String url = APIs.getConstantApi + "?key=inspectiontechnique";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null && res is Map<String, dynamic>) {
        return res.entries.map((entry) {
          return TerrainTypeModel(
            id: entry.key,
            name: entry.value,
          );
        }).toList();
      }
      return [];
    } catch (e) {
      return null;
    }
  }


  static Future<dynamic> fetchPenetrameterData() async {
    try {
      String url = APIs.getConstantApi + "?key=Penetrameter";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null && res is Map<String, dynamic>) {
        // Take first entry from map
        final entry = res.entries.first;
        return TerrainTypeModel(
          id: entry.key,
          name: entry.value,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  static Future<dynamic> submitData({
    required BuildContext context,
     required AlignmentModel alignmentData,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required NdtStatusModel ndtAgencyData,
    required NdtStatusModel dSPPLAgencyData,
    required NdtStatusModel meconPbgplData,
    required String locationDefect,
    required List<SegmentModel> selectedSegmentList,
    required NdtSourceModel ndtSourceData,
    required File file,
    required String chainage,
    required String filmType,
    required TerrainTypeModel inspectTechnique,
    required String sensivity,
    required String density,
    required String equipment,
  }) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      List<SegmentModel> data = [];
      for (var segmentData in selectedSegmentList) {
        if (segmentData.toJson().isNotEmpty) {
          data.add(segmentData..toJson());
        }
      }
      if (kDebugMode) {
        print(data);
      }

      List<dynamic> alignmentIdList = [];
      for (var alignmentId in multipleAlignmentData) {
        alignmentIdList.add(alignmentId.id);
      }

      String url = APIs.addRadiographyApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        // "alignment_sheet_id": alignmentData.id.toString(),
        "alignment_sheet_id":alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "joint_type_id":
            jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "joint_id":
            jointNumberData.id != null ? jointNumberData.id.toString() : "",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "ndt_agency_status":
            ndtAgencyData.id != null ? ndtAgencyData.id.toString() : "",
        "contractor_agency_status":
            dSPPLAgencyData.id != null ? dSPPLAgencyData.id.toString() : "",
        "pmc_agency_status":
            meconPbgplData.id != null ? meconPbgplData.id.toString() : "",
        "rt_source":
            ndtSourceData.id != null ? ndtSourceData.id.toString() : "",
        "segments": jsonEncode(data),
        "defects": locationDefect,
        "flaw_detector_type": filmType,
        "inspection_technique":  inspectTechnique.id != null ? inspectTechnique.id.toString() : "",
        "sensivity": sensivity,
        "density": density,
        "chainage": chainage,
        "equipment": equipment,
      };
      print("json--->${json}");
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
        imageRequestObject: [ImageRequestObject(key: "attach_file",path: file.path.toString())],
      );
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        SnackBarSuccessWidget(!context.mounted ? context : context)
            .show(message: res['data']);
        return res;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 415 &&
          res['data'] != null) {
        SnackBarErrorWidget(!context.mounted ? context : context)
            .show(message: res['data'].toString());
        return null;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 400 &&
          res['data'] != null) {
        String resPonse = res['data'].toString();
        SnackBarErrorWidget(!context.mounted ? context : context).show(
            message: resPonse.replaceAll("{", "").toString()
              ..replaceAll("}", ""));
        return null;
      }
      return null;
    } catch (e) {
      SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: e.toString());
      return null;
    }
  }

  static Future<dynamic> fetchSegmentData(
      {required BuildContext context,
      required LoginDataModel userData,
      required List<WelderModel> welderList}) async {
    try {
      String url = APIs.getSegmentApi;
      var param = {
        "schema": userData.schema,
      };

      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['segment'] != null) {
        List<SegmentModel> segmentList =
            segmentListResponse(res['segment'], welderList);
        return segmentList;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
