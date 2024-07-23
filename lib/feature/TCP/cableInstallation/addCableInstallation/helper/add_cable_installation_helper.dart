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
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_error_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddCableInstallationHelper{


  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required String date,
        required String reportNumber,
        required String activityRemark,
        required WeatherModel weatherData,
        required LoginDataModel userData,
        required String cableSize,
        required VisualChecksModel cableTrench,
        required String depthLaying,
        required VisualChecksModel sandBrickSpreading,
        required VisualChecksModel warningMatPlacement,
        required VisualChecksModel backfillingRestoration,
        required VisualChecksModel taggingFerruling,
        required String cableValue,
        required String cableLengthA2,
        required String cableLengthA3,
        required VisualChecksModel earthingResistance,
        required VisualChecksModel routeMarking,
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
      String url = APIs.addCableLayingInsertApi;
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
        "alignment_sheet_id": alignmentData.id != null ? alignmentData.id.toString() : "",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "cable_size": cableSize.toString(),
        "cable_trench": cableTrench.toString(),
        "depth_laying": depthLaying.toString(),
        "sand_brick_spreading": sandBrickSpreading.id != null ? sandBrickSpreading.id.toString() : "",
        "warning_mat_placement": warningMatPlacement.id != null ?   warningMatPlacement.id.toString() : "" ,
        "backfilling_restoration": backfillingRestoration.id != null ? backfillingRestoration.id.toString() : "",
        "tagging_ferruling":taggingFerruling.id != null ? taggingFerruling.id.toString() : "",
        "route_marking": routeMarking.id != null ? routeMarking.id.toString() : "",
        "cable_value": cableValue.toString(),
        "tlp_type_id":tlpTypeId.id != null ? tlpTypeId.id.toString() : "",
        "area": area.toString(),
        "chainage": chainage.toString(),

      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
          context: !context.mounted ? context : context,
          keyWord: "attach_file",
          filePath: file.path.toString());
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