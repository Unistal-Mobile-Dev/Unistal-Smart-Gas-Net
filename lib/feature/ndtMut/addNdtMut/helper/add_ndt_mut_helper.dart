import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddNdtMutHelper {

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required List<dynamic> segmentData,
    required List<dynamic> segmentStatusData,
    required List<dynamic> segmentObservationData,

    required File file}) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addNdtMutApi;
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
        "alignment_sheet_id": alignmentData.id != null ? alignmentData.id.toString() : "",
        "joint_type_id" : jointTypeData.id != null ? jointTypeData.id.toString(): "",
        "joint_id" : jointNumberData.id != null ? jointNumberData.id.toString(): "",
        "weather" : weatherData.id != null ? weatherData.id.toString() : "",
        "segment_ids": segmentData.toString().replaceAll("]", "").toString().replaceAll("[", ""),
        "segment_status" : segmentStatusData.toString().replaceAll("]", "").toString().replaceAll("[", ""),
        "segment_observation" : segmentObservationData.toString().replaceAll("]", "").toString().replaceAll("[", ""),
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
      }else{
        SnackBarErrorWidget(context).show(message: "Internal Server Error");
        return null;
      }
    }catch(e){
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }

  static Future<dynamic> fetchSegmentData({required BuildContext context, required LoginDataModel userData}) async {

    try{
      String url =  APIs.getSegmentApi;
      var param = {
        "schema" : userData.schema,
      };
      String json =  Uri(queryParameters: param).query;
      var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data']['segment'] != null && res['data']['status'] != null) {


        int id = 1;
        Map myMap = res['data']['status'];
        List<SegmentModel> segmentList  = [];
        List<SegmentModel> _segmentList  = [];
        segmentList =  segmentListResponse(res['data']['segment']);
        for(var segmentData in segmentList){
          List<SegmentStatusModel> segmentStatusList = [];
          myMap.forEach((key, value) {
            segmentStatusList.add(SegmentStatusModel(id: key, status: value, selectedValue: "", groupType: id));
            id++;
          });
          segmentData.segmentStatusList = segmentStatusList;
          _segmentList.add(segmentData);
        }

        return _segmentList;
      }
      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}