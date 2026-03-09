import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddSacrificialAnodeHelper{

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required List<AlignmentModel> multipleAlignmentData,
        required String date,
        required String reportNumber,
        required String activityRemark,
        required WeatherModel weatherData,
        required LoginDataModel userData,
        required String anodeLocation,
        required String currentOutputAnode,
        required VisualChecksModel anodeCondition,
        required String anodeId,
        required String testStationNo,
        required String testStationType,
        required String distancePipeline,
        required String anodeNo,
        required String spacingBetweenAnode,
        required String anodeTailCableLength,
        required String anodeTailCableLength2,
        required String anodeTailCableLength3,
        required String anodeOpenCirkuit,
        required String beforePspConnectionAnode,
        required String chainage,
        required String afterPspConnectionAnode,
        required TlpTypeModel tlpTypeId,
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

      String url = APIs.addSacrificialAnodeInsertApi;
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
        "anode_location": anodeLocation.toString(),
        "test_station_type": testStationType.toString(),
        "anode_id": anodeId.toString(),
        "distance_pipeline": distancePipeline.toString(),
        "anode_no":anodeNo.toString(),
        "spacing_between_anode": spacingBetweenAnode.toString(),
        "current_output_anode": currentOutputAnode.toString(),
        "anode_condition": anodeCondition.id != null ? anodeCondition.id.toString() : "",
        "test_station_no":testStationNo.toString(),
        "anode_tail_cable_length": anodeTailCableLength.toString(),
        "anode_tail_cable_length2": anodeTailCableLength2.toString(),
        "anode_tail_cable_length3": anodeTailCableLength3.toString(),
        "anode_open_cirkuit": anodeOpenCirkuit.toString(),
        "before_psp_connection_anode": beforePspConnectionAnode.toString(),
        "chainage": chainage.toString(),
        "after_psp_connection_anode": afterPspConnectionAnode.toString(),
        "tlp_type_id": tlpTypeId.id != null ? tlpTypeId.id.toString() : "",
        "area": area.toString(),
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