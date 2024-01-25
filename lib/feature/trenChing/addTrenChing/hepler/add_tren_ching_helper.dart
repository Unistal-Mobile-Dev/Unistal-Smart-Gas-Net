import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';

class AddTrenChingHelper {


  static Future<dynamic> textFiledValidation({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date, required String fromJointId,
    required String toJointId, required String trenchingDepth,
    required String terrainType, required String activityRemark}) async {

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
      }
      else if(fromJointId.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter From joint ID");
        return false;
      }
      else if(toJointId.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter To Joint ID");
        return false;
      }
      else if(trenchingDepth.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter trenching depth");
        return false;
      }
      else if(terrainType.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter Terrain Type");
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
    required String date, required String fromJointId,
    required String toJointId, required String trenchingDepth,
    required String terrainType, required String activityRemark,
    required File file, required LoginDataModel userData,
    required WeatherModel weatherData,
  }) async {

    try{

      var location =  await LocationHelper.getLocation();
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      }

      String url =  APIs.trenchinginsertApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": alignmentData.chainageFrom.toString(),
        "chainage_to": alignmentData.chainageTo.toString(),
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "from_joint_id": fromJointId,
        "to_joint_id": toJointId,
        "trenching_depth": trenchingDepth,
        "terrain_type": terrainType,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id.toString(),
        "weather" : weatherData.name ?? "",
      };
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attached_file",
          filePath: file.path.toString());
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        SnackBarErrorWidget(context).show(message: res['data']);
        return res;
      }
      return null;
    }catch(e){
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }

  static Future<dynamic> fetchjointNumberData({required BuildContext context,
    required LoginDataModel userData}) async {

    try{
      String url =  APIs.getJointNumberApi;
      var param = {
        "schema" : userData.schema,
        "spread_id" : userData.spreadId,
        "section_id" : userData.sectionId,
      };
      String json =  Uri(queryParameters: param).query;
      var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return jointNumberListResponse(res['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }
}