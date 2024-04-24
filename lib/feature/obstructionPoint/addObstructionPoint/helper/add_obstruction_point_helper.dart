import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/building_category_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddObstructionPointHelper {

  static Future<dynamic> submitData({required BuildContext context,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required String buildingCategory,
    required String type,
    required String enterOther,
    required String longitude,
    required String latitude,
    required String floorNo,
    required String locationm,
    required String name,
    required SpreadTypeModel spreadTypeData,
    required SectionTypeModel sectionTypeData,
    required BuildingCategoryTypeModel buildingCategoryTypeData,
    required File file}) async {

    try{

      String url =  APIs.addObstructionPointApi;
      var json = {
        "type" :type,
        "other" : enterOther,
        "name" : name,
        "location" : locationm,
        "latitude" : latitude,
        "longitude" : longitude,
        "remarks" : activityRemark,
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
      } else  if(res != null && res['status'] != null
          && res['status'] == false && res['message'] != null) {
        SnackBarErrorWidget(context).show(message: res['message']);
        return null;
      } else  if(res != null && res['status'] != null
          && res['status'] == false && res['message'] != null) {
        String resPonse = res['message'].toString();
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