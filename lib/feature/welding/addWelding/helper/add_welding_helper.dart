import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddWeldingHelper {

  static Future<dynamic> textFiledValidation({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WelderModel rootWelders1Data,
    required WelderModel rootWelders2Data,
    required WelderModel hotWelders1Data,
    required WelderModel hotWelders2Data,
    required WelderModel filler1Welders1Data,
    required WelderModel filler1Welders2Data,
    required WelderModel filler2Welders1Data,
    required WelderModel filler2Welders2Data,
    required WelderModel filler3Welders1Data,
    required WelderModel filler3Welders2Data,
    required WelderModel filler4Welders1Data,
    required WelderModel filler4Welders2Data,
    required WelderModel filler5Welders1Data,
    required WelderModel filler5Welders2Data,
    required WelderModel filler6Welders1Data,
    required WelderModel filler6Welders2Data,
    required WelderModel filler7Welders1Data,
    required WelderModel filler7Welders2Data,
    required WelderModel filler8Welders1Data,
    required WelderModel filler8Welders2Data,
    required WelderModel cappingWelder1Data,
    required WelderModel cappingWelder2Data,
    required WelderModel stripWelder1Data,
    required WelderModel stripWelder2Data,
    required String electrodeDiaE81t8gBatch,
    required String electrodeDiaE81t8g,
    required String electrodeDiaE6010Batch,
    required String electrodeDiaE6010,
    required String electrodeDiaE9045p2Batch,
    required String electrodeDiaE9045p2,
    required String electrodeEiaE8010p1Batch,
    required String electrodeEiaE8010p1,
    required String leftPipeNumber,
    required String rightPipeNumber,
    required WPSModel wpsData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required VisualChecksModel fitupData,
    required VisualChecksModel weldVisualData,
    }) async {

    try{
      if(date.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please select date");
        return false;
      } else if(alignmentData.id == null){
        SnackBarErrorWidget(context).show(message: "Please select alignment");
        return false;
      } else if(reportNumber.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter report number");
        return false;
      } else if(wpsData.id == null){
        SnackBarErrorWidget(context).show(message: "Please Select WPS Data");
        return false;
      } else if(jointTypeData.id == null){
        SnackBarErrorWidget(context).show(message: "Please Select joint type");
        return false;
      }else if(jointNumberData.id == null){
        SnackBarErrorWidget(context).show(message: "Please Select joint number");
        return false;
      }else if(leftPipeNumber.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter left pipe number");
        return false;
      } else if(rightPipeNumber.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter right pipe number");
        return false;
      }
      else if(electrodeDiaE6010.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E6010");
        return false;
      }
      else if(electrodeDiaE6010Batch.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E6010 Batch");
        return false;
      }else if(electrodeEiaE8010p1.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E8010p1");
        return false;
      }else if(electrodeEiaE8010p1Batch.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E8010p1 Batch");
        return false;
      }
      else if(electrodeDiaE9045p2.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E9045p2");
        return false;
      }
      else if(electrodeDiaE9045p2Batch.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E9045p2 Batch");
        return false;
      }
      else if(electrodeDiaE81t8g.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E81t8g");
        return false;
      }
      else if(electrodeDiaE81t8gBatch.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter electrode Dia E81t8g Batch");
        return false;
      }
      else if(activityRemark.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter activity remark");
        return false;
      }
      return true;
    }catch(e){
      return false;
    }
  }

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WelderModel rootWelders1Data,
    required WelderModel rootWelders2Data,
    required WelderModel hotWelders1Data,
    required WelderModel hotWelders2Data,
    required WelderModel filler1Welders1Data,
    required WelderModel filler1Welders2Data,
    required WelderModel filler2Welders1Data,
    required WelderModel filler2Welders2Data,
    required WelderModel filler3Welders1Data,
    required WelderModel filler3Welders2Data,
    required WelderModel filler4Welders1Data,
    required WelderModel filler4Welders2Data,
    required WelderModel filler5Welders1Data,
    required WelderModel filler5Welders2Data,
    required WelderModel filler6Welders1Data,
    required WelderModel filler6Welders2Data,
    required WelderModel filler7Welders1Data,
    required WelderModel filler7Welders2Data,
    required WelderModel filler8Welders1Data,
    required WelderModel filler8Welders2Data,
    required WelderModel cappingWelder1Data,
    required WelderModel cappingWelder2Data,
    required WelderModel stripWelder1Data,
    required WelderModel stripWelder2Data,
    required String electrodeDiaE81t8gBatch,
    required String electrodeDiaE81t8g,
    required String electrodeDiaE6010Batch,
    required String electrodeDiaE6010,
    required String electrodeDiaE9045p2Batch,
    required String electrodeDiaE9045p2,
    required String electrodeEiaE8010p1Batch,
    required String electrodeEiaE8010p1,
    required PipeModel leftPipeData,
    required PipeModel rightPipeData,
    required WPSModel wpsData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required VisualChecksModel fitupData,
    required VisualChecksModel weldVisualData,
    required LoginDataModel userData,
    required File file,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String chainageTo,
  }) async {
    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addWeldingApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id != null ? alignmentData.id.toString() : "",
        "wps_id": wpsData.id != null ? wpsData.id.toString() : "",
        "root_welder1": rootWelders1Data.id ??  "",
        "root_welder2": rootWelders1Data.id ??  "",
        "hot_welder1": hotWelders1Data.id ??  "",
        "hot_welder2": hotWelders2Data.id ??  "",
        "filler1_welder_one": filler1Welders1Data.id ??  "" ?? "",
        "filler1_welder_two": filler1Welders2Data.id ??  "",
        "filler2_welder_one": filler2Welders1Data.id ??  "",
        "filler2_welder_two": filler2Welders2Data.id ??  "",
        "filler3_welder_one": filler3Welders1Data.id ??  "",
        "filler3_welder_two": filler3Welders2Data.id ??  "",
        "filler4_welder_one": filler4Welders1Data.id ??  "",
        "filler4_welder_two": filler4Welders2Data.id ??  "",
        "filler5_welder_one": filler5Welders1Data.id ??  "",
        "filler5_welder_two": filler5Welders2Data.id ??  "",
        "filler6_welder_one": filler6Welders1Data.id ??  "",
        "filler6_welder_two": filler6Welders2Data.id ??  "",
        "filler7_welder_one": filler7Welders1Data.id ??  "",
        "filler7_welder_two": filler7Welders2Data.id ??  "",
        "filler8_welder_one": filler8Welders1Data.id ??  "",
        "filler8_welder_two": filler8Welders2Data.id ??  "",
        "left_pipe_id": leftPipeData.id != null ? leftPipeData.id.toString() : "",
        "right_pipe_id": rightPipeData.id != null ? rightPipeData.id.toString() : "",
        "joint_id":  jointNumberData.id != null ? jointNumberData.id.toString() : "",
        "joint_type_id" : jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "fitup": fitupData.id != null ? fitupData.id.toString(): "",
        "weld_visual": weldVisualData.id != null ? weldVisualData.id.toString() : "",
        "strip_welder1": stripWelder1Data.id != null ? stripWelder1Data.id.toString(): "",
        "strip_welder2": stripWelder2Data.id != null ? stripWelder2Data.id.toString() : "",
        "capping_welder1": cappingWelder1Data.id != null ? cappingWelder1Data.id.toString() : "",
        "capping_welder2": cappingWelder2Data.id != null ? cappingWelder2Data.id.toString():  "",
        "electrode_dia_e6010": electrodeDiaE6010,
        "electrode_dia_e6010_batch": electrodeDiaE6010Batch,
        "electrode_dia_e8010p1": electrodeEiaE8010p1,
        "electrode_dia_e8010p1_batch": electrodeEiaE8010p1Batch,
        "electrode_dia_e9045p2": electrodeDiaE9045p2,
        "electrode_dia_e9045p2_batch": electrodeDiaE9045p2Batch,
        "electrode_dia_e81t8g": electrodeDiaE81t8g,
        "electrode_dia_e81t8g_batch": electrodeDiaE81t8gBatch,
        "weather" : weatherData.name ?? "",
      };
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        SnackBarSuccessWidget(context).show(message: res['data']);
        return res;
      } else  if(res != null && res['success'] != null
          && res['success'] == 415 && res['data'] != null) {
        SnackBarErrorWidget(context).show(message: res['data']);
        return null;
      } else  if(res != null && res['success'] != null
          && res['success'] == 400 && res['data'] != null) {
           String resPonse = res['data'].toString();
          SnackBarErrorWidget(context).show(message: resPonse.replaceAll("{", "").toString()..replaceAll("}", ""));
        return null;
      }else{
        SnackBarErrorWidget(context).show(message: "Internal Server Error");
        return null;
      }
    }catch(e){
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }

  static Future<dynamic> fetchWPSType({required BuildContext context,
    required LoginDataModel userData}) async {

    try{
      String url =  APIs.getWPSApi;
      var param = {
        "schema" : userData.schema,
        "spread_id" : userData.spreadId,
        "section_id" : userData.sectionId,
      };
      String json =  Uri(queryParameters: param).query;
      var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return wpsListResponse(res['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchJointType({required BuildContext context,
    required LoginDataModel userData}) async {

    try{
      String url =  APIs.getJointTypeApi;
      var param = {
        "schema" : userData.schema,
      };
      String json =  Uri(queryParameters: param).query;
      var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return jointTypeListResponse(res['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchJointNumberData({required BuildContext context,
    required LoginDataModel userData, required JointTypeModel jointTypeData}) async {

    try{
      String url =  APIs.getJointNumberWithTypeApi;
      var param = {
        "schema" : userData.schema,
        "section_id" : userData.sectionId,
        "joint_type_id" : jointTypeData.id.toString(),
      };
      String json =  Uri(queryParameters: param).query;
      var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return jointNumberListResponse(res['data']['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchWelderData({required BuildContext context,
    required LoginDataModel userData, required WPSModel wpsData}) async {

    try{
      String url =  APIs.getWelderApi;
      var param = {
        "schema" : userData.schema,
        "spread_id" : userData.spreadId,
        "section_id" : userData.sectionId,
        "wps_id" :   wpsData.id.toString(),
      };
      String json =  Uri(queryParameters: param).query;
      var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return welderListResponse(res['data']['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }



}