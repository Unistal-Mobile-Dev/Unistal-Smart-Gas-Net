import 'package:flutter/widgets.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';

class AddValveChamberHelper {

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date,
    required String descriptionOfStructureMember,
    required String unitWeight, required String activityRemark,
    required File file,
    required LoginDataModel userData,
    required WeatherModel weatherData,
    required String chainageFrom,
    required String weight,
    required String length,
    required String height,
  }) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addValveChamberApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "total_length": length,
        "unit": unitWeight,
        "valve_description": descriptionOfStructureMember,
        "width": weight,
        "height": height,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id.toString(),
        "weather" : weatherData.id != null ? weatherData.id.toString() : "",
      };
      if(!context.mounted) return null;
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        if(!context.mounted) return res;
         if(!context.mounted) return null;
 SnackBarErrorWidget(context).show(message: res['data'].toString());
        return res;
      }else  if(res != null && res['success'] != null
          && res['success'] == 415 && res['data'] != null) {
        if(!context.mounted) return null;
         if(!context.mounted) return null;
 SnackBarErrorWidget(context).show(message: res['data'].toString());
        return null;
      } else  if(res != null && res['success'] != null
          && res['success'] == 400 && res['data'] != null) {
        String resPonse = res['data'].toString();
        if(!context.mounted) return null;
        SnackBarErrorWidget(context).show(message: resPonse.replaceAll("{", "").toString()..replaceAll("}", ""));
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
}