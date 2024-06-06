import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddPreHydroTestHelper {
  static Future<dynamic> submitData({
    required BuildContext context,
    required AlignmentModel alignmentData,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointNumberModel fromJointData,
    required JointNumberModel toJointData,
    required JointTypeModel jointTypeData,
    required String length,
    required String ndeClearance,
    required ThicknessModel thicknessData,
    required File file,
    required String pressureGaugeNo,
    required String pressureGaugeCalibrationDate,
    required String testPressure,
    required String range,
    required String pipeSize,
    required String duration,
    required String timeOn,
    required String timeOff,
    required String timeInHours,
    required String pressureReading1KG,
    required String pressureReading2KG,
    required String temp,
    required String chainageFrom,
    required String chainageTo,
    required String reportNumber,
  }) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      String url = APIs.addPreHydroTestApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "activity_date": date.toString(),
        "report_no": reportNumber.toString(),
        "user_id": userData.userId.toString(),
        "activity_remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "alignment_sheet_id":
            alignmentData.id != null ? alignmentData.id.toString() : "",
        "to_joint_id": toJointData.id != null ? toJointData.id.toString() : "",
        "from_joint_id":
            fromJointData.id != null ? fromJointData.id.toString() : "",
        "jointTo": jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "total_length": length.toString(),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "pressure_gauge_no": pressureGaugeNo.toString(),
        "gauge_calibaration_date": pressureGaugeCalibrationDate.toString(),
        "test_pressure": testPressure.toString(),
        "range": range.toString(),
        "pipe_size": pipeSize.toString(),
        "duration": duration.toString(),
        "time_on": timeOn.toString(),
        "time_off": timeOff.toString(),
        "time": timeInHours.toString(),
        "temp": temp.toString(),
        "pressure_reading_1": pressureReading1KG.toString(),
        "pressure_reading_2": pressureReading2KG.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
          context: !context.mounted ? context : context,
          keyWord: "attachFile",
          filePath: file.path.toString());
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        SnackBarSuccessWidget(!context.mounted ? context : context).show(message: res['data'].toString());
        return res;
      } else if (res != null && res['data'] != null) {
        SnackBarErrorWidget(!context.mounted ? context : context).show(
            message: res['data']
                .toString()
                .replaceAll("{", "")
                .toString()
                .replaceAll("}", ""));
        return null;
      } else {
        SnackBarErrorWidget(!context.mounted ? context : context).show(message: "Internal Server Error");
        return null;
      }
    } catch (e) {
      SnackBarErrorWidget(!context.mounted ? context : context).show(message: e.toString());
      return null;
    }
  }
}
