import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddLoweringHelper {

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date,
    required HolidayChecksModel holidayChecksData,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointNumberModel fromJointData,
    required JointNumberModel toJointData,
    required JointTypeModel jointTypeData,
    required String chainageFrom,
    required String chainageTo,
    required String postPadding,
    required String locationName,
    required String holidayDetectorDetail,
    required String makeModel,
    required String testVoltage,
    required String calibarationDate,
    required String repairOfCoatingDamage,
    required String length,
    required File file}) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addLoweringApi;
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
        "holiday_test" : holidayChecksData.id != null ? holidayChecksData.id.toString() : "",
        "joint_id" : jointTypeData.id != null ? jointTypeData.id.toString(): "",
        "from_joint_id" : fromJointData.id != null ? fromJointData.id.toString() : "",
        "to_joint_id" : toJointData.id  != null ? toJointData.id.toString(): "",
        "post_padding" : postPadding,
        "location" : locationName,
        "make_model" : makeModel,
        "total_length" : length,
        "test_voltage" : testVoltage,
        "holiday_detector" : holidayDetectorDetail,
        "coating_damage_repair" : repairOfCoatingDamage,
        "calibaration_done_date" : calibarationDate,
        "weather" : weatherData.id != null ? weatherData.id.toString() : "",
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