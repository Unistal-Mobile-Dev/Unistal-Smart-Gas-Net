import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
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

class AddZnGroundingAnodeHelper{


  static Future<dynamic> submitData(
    {required BuildContext context,
      required AlignmentModel alignmentData,
      required List<AlignmentModel> multipleAlignmentData,
      required String date,
      required String reportNumber,
      required String activityRemark,
      required WeatherModel weatherData,
      required LoginDataModel userData,
      required String weightHeight,
      required String cableLengthA1,
      required String cableLengthA2,
      required String cableLengthA3,
      required String earthingResistance,
      required String anodeCondition,
      required TlpTypeModel anodeId,
      required String chainage,
      required String area,
      required String beforePspConnection,
      required String anodeLocationChainage,
      required String depthAuger,
      required String distancePipeline,
      required String anodeNoSpace,
      required String anodeOpenCircuitA1,
      required String anodeOpenCircuitA2,
      required String anodeOpenCircuitA3,
      required String anodeOpenCircuitA4,
      required String afterPspConnectionAc,
      required String beforePspConnectionDc,
      required String afterConnectionAnodeDc,
      required String afterInstallationConnectionAc,
      required String installationType,
      required String checkWaterFilling,
      required TlpTypeModel tlpTypeId,

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


    String url = APIs.addZnGroundInsertApi;
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
      "alignment_sheet_id":  AppConfig.instanceInit()!.client == Client.vppl
          ? alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", "") :alignmentData.id.toString(),
      "weather": weatherData.id != null ? weatherData.id.toString() : "",
      "anode_id": anodeId.id != null ? anodeId.id.toString() : "",
      "weight_height": weightHeight.toString(),
      "anode_location_chainage": anodeLocationChainage.toString(),
      "depth_auger": depthAuger.toString(),
      "anode_condition": anodeCondition.toString(),
      "distance_pipeline":distancePipeline.toString(),
      "anode_no_space": anodeNoSpace.toString(),
      "cable_length_a1": cableLengthA1.toString(),
      "cable_length_a2": cableLengthA2.toString(),
      "cable_length_a3": cableLengthA3.toString(),
      "earthing_resistance": earthingResistance.toString(),
      "tlp_type_id": tlpTypeId.id != null ? tlpTypeId.id.toString() :"",
      "area": area.toString(),
      "chainage": chainage.toString(),
      "before_psp_connection": beforePspConnection.toString(),
      "anode_open_circuit_a1": anodeOpenCircuitA1.toString(),
      "anode_open_circuit_a2": anodeOpenCircuitA2.toString(),
      "anode_open_circuit_a3": anodeOpenCircuitA3.toString(),
      "anode_open_circuit_a4": anodeOpenCircuitA4.toString(),
      "after_psp_connection_ac": afterPspConnectionAc.toString(),
      "before_psp_connection_dc": beforePspConnectionDc.toString(),
      "after_connection_anode_dc": afterConnectionAnodeDc.toString(),
      "after_installation_connection_ac": afterInstallationConnectionAc.toString(),
      "installation_type": installationType.toString(),
      "check_water_filling": checkWaterFilling.toString(),
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