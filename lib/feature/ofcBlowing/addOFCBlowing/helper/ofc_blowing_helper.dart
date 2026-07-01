import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddOFCBlowingHelper {
  static Future<dynamic> textFiledValidation({
    required BuildContext context,
      required AlignmentModel alignmentData,
      required List<AlignmentModel> multipleAlignmentData,
      required String reportNumber,
      required String date,
      required String tpIpChainage,
      required String tpIpNOS,
      required String tpIpRemark,
      required String ipNumber,
      required String ipNumberFrom,
      required String structureDetail,
      required String boundaryLocation,
      required String activityRemark,
      required String groundType}) async {
    try {
      if (date.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select date");
        return false;
      } else if (alignmentData.id == null || multipleAlignmentData.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select alignment");
        return false;
      }
      if (reportNumber.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter report number");
        return false;
      } else if (tpIpChainage.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter TP IP From");
        return false;
      } else if (tpIpNOS.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter tp ip number");
        return false;
      } else if (groundType.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter ground type");
        return false;
      } else if (ipNumberFrom.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter ip number from");
        return false;
      } else if (ipNumber.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter ip number");
        return false;
      } else if (structureDetail.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter structure detail");
        return false;
      } else if (boundaryLocation.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter boundary location");
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

  static Future<dynamic> fetchTerrainData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getTerrianApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return terrainListResponse(res['data']);
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
    required JointNumberModel fromJointData,
    required JointNumberModel toJointData,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required String ofcDrumNo,
    required String ofDrumLength,
    required String ofcSMM,
    required String pitCableLength,
    required String pitLoop,
    required String blowingPitLocationNo,
    required String activityRemark,
    required LoginDataModel userData,
    required File file,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String chainageTo,


  }) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      List<dynamic> alignmentIdList = [];
      for (var alignmentId in multipleAlignmentData) {
        alignmentIdList.add(alignmentId.id);
      }

      String url = APIs.addOfcBlowingInsertApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom.isNotEmpty ? chainageFrom : "0",
        "chainage_to": chainageTo.isNotEmpty ? chainageTo: "0",
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "joint_id": "0",
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "from_joint_id": fromJointData.id != null ? fromJointData.id.toString() : "",
        "to_joint_id": toJointData.id != null ? toJointData.id.toString() : "",
        "ofc_drum_no": ofcDrumNo.toString(),
        "ofc_drum_length": ofDrumLength.toString(),
        "ofc_sequential_meter_marker": ofcSMM.toString(),
        "pit_cable_length": pitCableLength.toString(),
        "pit_loop": pitLoop.toString(),
        "blowing_pit_location_no": blowingPitLocationNo.toString(),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",

      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
        imageRequestObject: [ImageRequestObject("attach_file", file.path.toString())],
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
            .show(message: res['data']);
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
      } else {
        SnackBarErrorWidget(!context.mounted ? context : context)
            .show(message: "Internal Server Error");
        return null;
      }
    } catch (e) {
      SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: e.toString());
      return null;
    }
  }
}
