import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/apis.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/server_request.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_error_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/enums.dart';

class AddPolarisation{
  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
        required String date,
        required String reportNumber,
        required String activityRemark,
        required WeatherModel weatherData,
        required LoginDataModel userData,
        required String testStationChainage,
        required VisualChecksModel corrisionCoupan,
        required String digitalMultimeter,
        required VisualChecksModel cableTermination,
        required String pspMeasurement,
        required String voltage,
        required String coupanInstantOffPotential,
        required String properFittingCheck,
        required String modelNo,
        required TlpTypeModel tlpTypeId,
        required String chainage,
        required String make,
        required String area,
        required String calibarationDate,
        required File file
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

      String url = APIs.addPolerisationCoupanInsertApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        // "alignment_sheet_id": alignmentData.id.toString(),
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "test_station_chainage": testStationChainage.toString(),
        "corrision_coupan": corrisionCoupan.id != null ? corrisionCoupan.id.toString() : "",
        "cable_termination": cableTermination.id != null ? cableTermination.id.toString() : "",
        "properfitting_check": properFittingCheck.toString(),
        "psp_measurement": pspMeasurement.toString(),
        "coupan_instant_off_potential": coupanInstantOffPotential.toString(),
        "digital_multimeter": digitalMultimeter.toString(),
        "model_no": modelNo.toString(),
        "tlp_type_id": tlpTypeId.id != null ? tlpTypeId.id.toString() : "",
        "chainage":chainage.toString(),
        "make":make.toString(),
        "area":area.toString(),
        "calibaration_date":calibarationDate.toString(),
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
            .show(message: res['data'].toString());
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