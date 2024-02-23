import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/aut_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_layer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddNdtAutHelper {

  static Future<dynamic> fetchAutStatusData({required BuildContext context}) async {

    try{
      String url =  APIs.getAutStatusApi;
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        List<AutStatusModel> autStatusLIst = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          autStatusLIst.add(AutStatusModel(id: key, value: value));
        });
        return autStatusLIst;
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchDefectLayerData({required BuildContext context}) async {

    try{
      String url =  APIs.getDefectLayerApi;
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        List<DefectLayerModel> defectLayerList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          defectLayerList.add(DefectLayerModel(id: key, value: value));
        });
        return defectLayerList;
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchDefectTypeData({required BuildContext context, required LoginDataModel userData}) async {

    try{
      String url =  APIs.getDefectTypeApi+"?schema=${userData.schema}";
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return defectTypeListResponse(res['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required WPSModel wpsTypeData,
    required List<WelderModel> selectedWelderList,
    required List<DefectTypeModel> selectedDefectTypeList,
    required List<DefectLayerModel> selectedDefectLayer,
    required String defectLocation,
    required AutStatusModel autStatusData,
    required File file}) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }


      List<dynamic> defectTypeList = [];
      List<dynamic> defectLayerList = [];
      List<dynamic> defectWelderList = [];

      for(var welderData in selectedWelderList){
         defectWelderList.add(welderData.id);
      }
      for(var defectType in selectedDefectTypeList){
        defectTypeList.add(defectType.id);
      }
      for(var defectLayer in selectedDefectLayer){
        defectLayerList.add(defectLayer.id);
      }

      String url =  APIs.addNdtAutApi;
      dynamic json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id != null ? alignmentData.id.toString() : "",
        "joint_type_id" : jointTypeData.id != null ? jointTypeData.id.toString(): "",
        "joint_id" : jointNumberData.id != null ? jointNumberData.id.toString(): "",
        "wpsId" : wpsTypeData.id != null ? wpsTypeData.id.toString(): "",
        "aut_status" : autStatusData.id != null ? autStatusData.id.toString(): "",
        "defect_location" : defectLocation.toString(),
        "defect_welder_ids" : defectWelderList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "defect_layer_ids" : defectLayerList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "defect_type_ids" : defectTypeList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
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
        SnackBarErrorWidget(context).show(message: res['data'].toString());
        return null;
      } else  if(res != null && res['success'] != null
          && res['success'] == 400 && res['data'] != null) {
        String resPonse = res['data'].toString();
        SnackBarErrorWidget(context).show(message: resPonse.replaceAll("{", "").toString()..replaceAll("}", ""));
        return null;
      }
      return null;
    }catch(e){
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }


}