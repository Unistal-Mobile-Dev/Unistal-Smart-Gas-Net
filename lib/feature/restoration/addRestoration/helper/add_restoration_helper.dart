import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddRestorationHelper {

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointNumberModel fromJointData,
    required JointNumberModel toJointData,
    required JointTypeModel jointTypeData,
    required String chainageFrom,
    required String chainageTo,
    required String landType,
    required String length,
    required PaddingModel removalOfSurplusMaterialData,
    required PaddingModel replacementofTopSoilData,
    required PaddingModel reinstallationBoundaryStonesData,
    required File file}) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addRestorationApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id != null ? alignmentData.id.toString() : "",
        "joint_id" : jointTypeData.id != null ? jointTypeData.id.toString(): "",
        "from_joint_id" : fromJointData.id != null ? fromJointData.id.toString() : "",
        "to_joint_id" : toJointData.id  != null ? toJointData.id.toString(): "",
        "land_type" : landType,
        "total_length" : length,
        "weather" : weatherData.id != null ? weatherData.id.toString() : "",
        "surplus_material_removal" : removalOfSurplusMaterialData.id != null ? removalOfSurplusMaterialData.id.toString() : "",
        "top_soil_replacement" : replacementofTopSoilData.id != null ? replacementofTopSoilData.id.toString() : "",
        "boundary_stone_reinstall" : reinstallationBoundaryStonesData.id != null ? reinstallationBoundaryStonesData.id.toString() : "",
      };
      if(!context.mounted) return null;
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        if(!context.mounted) return res;
        SnackBarSuccessWidget(context).show(message: res['data'].toString());
        return res;
      } else  if(res != null && res['success'] != null
          && res['success'] == 415 && res['data'] != null) {
        if(!context.mounted) return null;
        SnackBarErrorWidget(context).show(message: res['data'].toString());
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
}