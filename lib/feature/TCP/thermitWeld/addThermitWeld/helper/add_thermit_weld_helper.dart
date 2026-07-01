

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

class AddThermitWeldHelper{
  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
        required String date,
        required String reportNumber,
        required String activityRemark,
        required WeatherModel weatherData,
        required LoginDataModel userData,
        required String testStationLocation,
        required String testStationType,
        required String spacingBetweenConnection,
        required String cableToPipeContactResistance,
        required String cableSize,
        required String cableLength,
        required VisualChecksModel continuityCheck,
        required VisualChecksModel restorationCheck,
        required VisualChecksModel pinBrazzing,
        required String epoxyHardningFilling,
        required TlpTypeModel tlpTypeId,
        required String chainage,
        required String area,
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

      String url = APIs.addThermitWeldInsertApi;
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
        "alignment_sheet_id":alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "test_station_location": testStationLocation.toString(),
        "test_station_type": testStationType.toString(),
        "spacing_between_connection": spacingBetweenConnection.toString(),
        "cable_to_pipe_contact_resistance": cableToPipeContactResistance.toString(),
        "cable_size": cableSize.toString(),
        "cable_length": cableLength.toString(),
        "continuity_check": continuityCheck.id != null ? continuityCheck.id.toString() :"",
        "restoration_check":restorationCheck.id != null ? restorationCheck.id.toString() : "",
        "pin_brazzing": pinBrazzing.id != null ? pinBrazzing.id.toString() : "",
        "epoxy_hardning_filling": epoxyHardningFilling.toString(),
        "tlp_type_id":tlpTypeId.id != null ? tlpTypeId.id.toString() : "",
        "area": area.toString(),
        "chainage": chainage.toString(),
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