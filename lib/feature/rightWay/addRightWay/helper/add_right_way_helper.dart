import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rightWay/addRightWay/domain/model/road_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddRightWayHelper {

  static Future<dynamic> fetchRoadType() async {

    try{
      LoginDataModel userData =  UserInfo.instanceInit()!.userData!;
      String url = APIs.getRoadTypeApi+"?schema=${userData.schema}";
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res !=  null && res['status'] != null
          && res['status'] == true && res['data'] != null) {
        return roadTypeListResponse(res['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> submitData({required BuildContext context,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required String roadLength,
    required RoadTypeModel roadTypeData,
    required String roadName,
    required String longitude,
    required String latitude,
    required String roadWidth,
    required String locationm,
    required String materialType,
    required SpreadTypeModel spreadTypeData,
    required SectionTypeModel sectionTypeData,
    required String rodeSideValue,
    required String other,
    required File file}) async {

    try{

      String url =  APIs.addRightWayApi;
      var json = {
        "schema": userData.schema.toString(),
        "date": date,
        "roadName" : roadName,
        "type" : roadTypeData.id != null ? roadTypeData.id.toString() : "0",
        "materialType" : materialType,
        "roadWidth" :roadWidth,
        "roadLength" : roadLength,
        "roadSide" : rodeSideValue,
        "location" : locationm,
        "latitude": latitude,
        "longitude": longitude,
        "remarks" : activityRemark,
        "other" : other,
        "spreadId" : spreadTypeData.id ?? "0",
        "sectionId" : sectionTypeData.id ?? "0",
      };
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attachFile",
          filePath: file.path.toString());
      if(res != null && res['status'] != null
          && res['status'] == true && res['message'] != null) {
        SnackBarSuccessWidget(context).show(message: res['message']);
        return res;
      }  else  if(res != null && res['status'] != null
          && res['status'] == false && res['errors'] != null) {
        SnackBarErrorWidget(context).show(message: res['errors'].toString().replaceAll("{", "").toString()..replaceAll("}", ""));
        return null;
      } else  if(res != null && res['status'] != null
          && res['status'] == false && res['errors'] != null) {
        String resPonse = res['errors'].toString();
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
}