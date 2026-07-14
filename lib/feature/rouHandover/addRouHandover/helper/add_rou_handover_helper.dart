import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddRouHandover {
  static Future<dynamic> textFiledValidation({required BuildContext context,
         required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
      required String reportNumber,
      required String date,
      required String typeofGround,
      required String tpIpNOS,
      required String tpIpRemark,
      required String bearing,
      required String terrain,
      required String activityRemark}) async {
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
      } else if (typeofGround.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please Type Of Ground");
        return false;
      } else if (tpIpNOS.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter tp ip number");
        return false;
      } else if (tpIpRemark.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter tp ip remark");
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

  static Future<dynamic> submitData({
    required BuildContext context,
     required AlignmentModel alignmentData,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String tenderNo,
    required String date,
    required String typeofGround,
    required String tpIpNOS,
    required String tpIpRemark,
    required String bearing,
    required String terrain,
    required String activityRemark,
    required LoginDataModel userData,
    required File file,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String chainageTo,
    required String totalLength,
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
      String url = APIs.addRouHandoverinsertApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "total_length": totalLength,
        "report_no": reportNumber.toString(),
        "tender_no": tenderNo.toString(),
        "activity_date": date.toString(),
        "type_of_ground": typeofGround.toString(),
        "ip_tp_no": tpIpNOS.toString(),
        "other_details": tpIpRemark.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        // "alignment_sheet_id": alignmentData.id.toString(),
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
      };
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
            .show(message: res['data']);
        return null;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 400 &&
          res['data'] != null) {
        String response = res['data'].toString();
        SnackBarErrorWidget(!context.mounted ? context : context).show(
            message: response.replaceAll("{", "").toString()
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
