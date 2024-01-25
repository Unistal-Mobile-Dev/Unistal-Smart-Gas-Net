import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';

class AddRouteSurveyHelper {

  static Future<dynamic> textFiledValidation({required BuildContext context,
   required AlignmentModel alignmentData,
    required String reportNumber,
    required String date, required String tpIpChainage,
    required String tpIpNOS, required String tpIpRemark, required String bearing,
    required String terrain, required String activityRemark}) async {

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
          SnackBarErrorWidget(context).show(message: "Please enter TP IP Chainage");
          return false;
        } else if(tpIpNOS.isEmpty){
          SnackBarErrorWidget(context).show(message: "Please enter tp ip number");
          return false;
        } else if(tpIpRemark.isEmpty){
          SnackBarErrorWidget(context).show(message: "Please enter tp ip remark");
          return false;
        } else if(bearing.isEmpty){
          SnackBarErrorWidget(context).show(message: "Please enter bearing angle");
          return false;
        } else if(terrain.isEmpty){
          SnackBarErrorWidget(context).show(message: "Please enter terrain");
          return false;
        } else if(activityRemark.isEmpty){
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
    required String tpIpNOS, required String tpIpRemark, required String bearing,
    required String terrain, required String activityRemark,
    required LoginDataModel userData, required File file}) async {

    try{

      var location =  await LocationHelper.getLocation();
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      }

      String url =  APIs.addRouteSurveyApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": alignmentData.chainageFrom.toString(),
        "chainage_to": alignmentData.chainageTo.toString(),
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "tp_ip_chainage": tpIpChainage.toString(),
        "tp_ip_nos": tpIpNOS.toString(),
        "tp_remarks": tpIpRemark.toString(),
        "bearing_angle": bearing.toString(),
        "terrain": terrain.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id.toString(),
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

  static Future<dynamic> fetchAlignmentData({required BuildContext context,
       required LoginDataModel userData}) async {

      try{
         String url =  APIs.getAlignmentSheetApi;
         var param = {
           "schema" : userData.schema,
           "spread_id" : userData.spreadId,
           "section_id" : userData.sectionId,
         };
         String json =  Uri(queryParameters: param).query;
         var res =  await ServerRequest.getData(urlEndPoint: "$url?$json");
         if(res != null && res['success'] != null
              && res['success'] == 200 && res['data'] != null) {
           return alignmentResponseList(res['data']);
         }
         return null;
      }catch(e){
        return null;
      }
  }

  static Future<dynamic> filePiker({required BuildContext context}) async {
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
      );
      if(result != null){
        List<File> files = result.paths.map((path) => File(path!)).toList();
        return files[0];
      } else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

}