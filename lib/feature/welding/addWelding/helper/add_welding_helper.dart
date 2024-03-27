import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
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
    required WelderModel welderData,
    required String electrodeDiaE81t8gBatch,
    required String electrodeDiaE81t8g,
    required String electrodeDiaE6010Batch,
    required String electrodeDiaE6010,
    required String electrodeDiaE9045p2Batch,
    required String electrodeDiaE9045p2,
    required String electrodeEiaE7010p1Batch,
    required String electrodeEiaE7010p1,
    required PipeModel leftPipeData,
    required PipeModel rightPipeData,
    required WPSModel wpsData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required VisualChecksModel fitupData,
    required VisualChecksModel weldVisualData,
    required VisualChecksModel preHeatData,
    required LoginDataModel userData,
    required File file,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String chainageTo,
    required PipeMaterialModel pipeMaterialData,
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
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id != null ? alignmentData.id.toString() : "0",
        "wps_id": wpsData.id != null ? wpsData.id.toString() : "0",
        "left_pipe_id": leftPipeData.id != null ? leftPipeData.id.toString() : "0",
        "right_pipe_id": rightPipeData.id != null ? rightPipeData.id.toString() : "0",
        "joint_id":  jointNumberData.id != null ? jointNumberData.id.toString() : "0",
        "joint_type_id" : jointTypeData.id != null ? jointTypeData.id.toString() : "0",
        "pipe_material_id" : pipeMaterialData.id != null ? pipeMaterialData.id.toString() : "0",
        "fitup": fitupData.id != null ? fitupData.id.toString(): "0",
        "visual_check": weldVisualData.id != null ? weldVisualData.id.toString() : "0",
        "pre_heat": preHeatData.id != null ? preHeatData.id.toString() : "0",
        "welder_id": welderData.id != null ? welderData.id.toString() : "0",
        "electrode_six_a": electrodeDiaE6010,
        "electrode_six_b": electrodeDiaE6010Batch,
        "electrode_seven_a": electrodeDiaE6010,
        "electrode_seven_b": electrodeDiaE6010Batch,
        "weather" : weatherData.id != null ? weatherData.id.toString() : "",
      };
      if(!context.mounted) return null;
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        if(!context.mounted) return res;
        SnackBarSuccessWidget(context).show(message: res['data']);
        return res;
      } else  if(res != null && res['success'] != null
          && res['success'] == 415 && res['data'] != null) {
        if(!context.mounted) return null;
        SnackBarErrorWidget(context).show(message: res['data']);
        return null;
      } else  if(res != null && res['success'] != null
          && res['success'] == 400 && res['data'] != null) {
           String response = res['data'].toString();
           if(!context.mounted) return null;
          SnackBarErrorWidget(context).show(message: response.replaceAll("{", "").toString()..replaceAll("}", ""));
        return null;
      }else{
        if(!context.mounted) return null;
        SnackBarErrorWidget(context).show(message: "Internal Server Error");
        return null;
      }
    }catch(e){
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }

  static Future<dynamic> fetchWPSType({required LoginDataModel userData}) async {

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

  static Future<dynamic> fetchJointType({required LoginDataModel userData}) async {
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

  static Future<dynamic> fetchWelderData({required LoginDataModel userData, required WPSModel wpsData}) async {

    try{
      String url =  APIs.getWelderApi;
      var param = {
        "schema" : userData.schema,
        "spread_id" : userData.spreadId,
        "section_id" : userData.sectionId,
        "wps_id" :   wpsData.id != null ? wpsData.id.toString() : "",
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