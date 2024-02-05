import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddClearingGradingHelper {

  static Future<dynamic> textFiledValidation({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date, required String tpIpChainage,
    required String tpIpNOS,
    required String tpIpRemark,
    required String ipNumber,
    required String ipNumberFrom,
    required String structureDetail,
    required String boundaryLocation, required String activityRemark,
    required String groundType}) async {

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
      } else if(tpIpChainage.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter TP IP From");
        return false;
      } else if(tpIpNOS.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter tp ip number");
        return false;
      }else if(groundType.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter ground type");
        return false;
      } else if(ipNumberFrom.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter ip number from");
        return false;
      }else if(ipNumber.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter ip number");
        return false;
      }
      else if(structureDetail.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter structure detail");
        return false;
      } else if(boundaryLocation.isEmpty){
        SnackBarErrorWidget(context).show(message: "Please enter boundary location");
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
    required String date, required String tpIpChainage,
    required String ipNumber, required String ipNumberFrom,
    required String tpIpNOS, required String tpIpRemark, required String structureDetail,
    required String boundaryLocation, required String activityRemark,
    required LoginDataModel userData, required File file, required String groundType,
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

      String url =  APIs.addCGinsertApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "chainage": alignmentData.chainageFrom.toString(),
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "tp_ip_from": tpIpChainage.toString(),
        "tp_ip_to": tpIpNOS.toString(),
        "ip_no_from": ipNumber.toString(),
        "ip_no_to": ipNumberFrom.toString(),
        "ground_type": groundType.toString(),
        "structure_detail": structureDetail.toString(),
        "boundary_location": boundaryLocation.toString(),
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

}