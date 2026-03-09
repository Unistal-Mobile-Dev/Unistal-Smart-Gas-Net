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

class AddTestStationBoxHelper{


  static Future<dynamic> fetchTLPType(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getTLPTypeApi;
      var param = {
        "schema": userData.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
      return tlpTypeResList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchAnodeTypeApi(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getAnodeTypeApi;
      var param = {
        "schema": userData.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return tlpTypeResList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }


  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
        required String date,
        required String reportNumber,
        required String activityRemark,
        required WeatherModel weatherData,
        required LoginDataModel userData,
        required VisualChecksModel tesStationMounting,
        required VisualChecksModel testStationDoors,
        required String testStationLocation,
        required VisualChecksModel distancePipeline,
        required String testStationType,
        required TlpTypeModel tlpTypeId,
        required VisualChecksModel cableEntrySealing,
        required VisualChecksModel foundationCheck,
        required VisualChecksModel cableTerminationCheck,
        required VisualChecksModel namePlateConnectionCheck,
        required VisualChecksModel shuntValueCheck,
        required VisualChecksModel compactionAlignmentCheck,
        required VisualChecksModel cableSealing,
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


      String url = APIs.addTestStationInsertApi;
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
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "test_station_location": testStationLocation,
        "distance_pipeline": distancePipeline.id != null ?distancePipeline.id.toString() : "",
        "test_station_type": testStationType.toString(),
        "tlp_type_id": tlpTypeId.id!= null ? tlpTypeId.id.toString() : "",
        "foundation_check": foundationCheck.id != null ? foundationCheck.id.toString() : "",
        "test_station_mounting": tesStationMounting.id != null ? tesStationMounting.id.toString() : "",
        "test_station_doors": testStationDoors.id != null ? testStationDoors.id.toString() : "",
        "cable_entry_sealing":cableEntrySealing.id != null ? cableEntrySealing.id.toString() : "",
        "cable_termination_check": cableTerminationCheck.id != null ? cableTerminationCheck.id.toString() : "",
        "name_plate_connection_check": namePlateConnectionCheck.id != null ? namePlateConnectionCheck.id.toString() : "",
        "shunt_value_check": shuntValueCheck.id != null ? shuntValueCheck.id.toString() : "",
        "compaction_alignment_check": compactionAlignmentCheck.id != null ? compactionAlignmentCheck.id.toString() : "",
        "cable_sealing": cableSealing.id != null ? cableSealing.id.toString() : "",
        "chainage": chainage.toString(),
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