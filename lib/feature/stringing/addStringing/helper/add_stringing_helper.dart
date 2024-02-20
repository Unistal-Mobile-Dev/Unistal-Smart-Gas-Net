import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/concrete_coating_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddStringingHelper {

  static Future<dynamic> textFiledValidation({required BuildContext context,
    required AlignmentModel alignmentData,
    required PipeModel pipeData,
    required ConcreteCoatingModel concreteCoatingData,
    required String reportNumber,
    required String date,
    required String activityRemark}) async {

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
      }else if(pipeData.id == null){
        SnackBarErrorWidget(context).show(message: "Please select pipe number");
        return false;
      }else if(concreteCoatingData.id == null){
        SnackBarErrorWidget(context).show(message: "Please select concrete coating");
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
    required PipeModel pipeData,
    required ConcreteCoatingModel concreteCoatingData,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required String chainageFrom,
    required String chainageTo,
    required LoginDataModel userData, required File file, required WeatherModel weatherData,}) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addStringingApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "pipe_id" : pipeData.id.toString(),
        "concrete_coating" : concreteCoatingData.id.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id.toString(),
        "weather" : weatherData.name ?? "",
      };
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        SnackBarSuccessWidget(context).show(message: res['data']);
        return res;
      }else  if(res != null && res['success'] != null
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

  static Future<dynamic> fetchConcreteCoatingData({required BuildContext context}) async {

    try{
      String url =  APIs.getConcreteCoatingApi;
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        List<ConcreteCoatingModel> concreteCoatingList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          concreteCoatingList.add(ConcreteCoatingModel(id: key, value: value));
        });
        return concreteCoatingList;
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchPipeData({required BuildContext context,
    required LoginDataModel userData, String? type, String? searchKeyword}) async {

    try{
      String url =  APIs.getPipeDetailApi;
      var param = {
        "schema" : userData.schema,
        "spread_id" : userData.spreadId,
        "section_id" : userData.sectionId,
        "type" :  type ?? "",
        "search_txt" : searchKeyword ?? ""
      };
      String json =  Uri(queryParameters: param).query;
      var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return pipeResponseList(res['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }
}