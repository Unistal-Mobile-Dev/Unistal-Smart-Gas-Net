import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddTieinHelper {
  static Future<dynamic> submitData({
    required BuildContext context,
    required AlignmentModel alignmentData,
    required String preHeatTempreture,
    required String date,
    required String activityRemark,
    required WelderModel welderData,
    required String electrodeDiaE81t8gBatch,
    required String electrodeDiaE81t8g,
    required String electrodeDiaE6010Batch,
    required String electrodeDiaE6010,
    required String electrodeDiaE9045p2Batch,
    required String electrodeDiaE9045p2,
    required String electrodeEiaE7010p1Batch,
    required String electrodeEiaE7010p1,
    required PipeModel leftPipeData,
    required PipeModel rightPipeData,
    required WPSModel wpsData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required VisualChecksModel fitupData,
    required VisualChecksModel weldVisualData,
    required LoginDataModel userData,
    required File file,
    required WeatherModel weatherData,
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

      String url = APIs.addTieInApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "report_no": reportNumber,
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id":
            alignmentData.id != null ? alignmentData.id.toString() : "",
        "wps_id": wpsData.id != null ? wpsData.id.toString() : "",
        "left_pipe_id":
            leftPipeData.id != null ? leftPipeData.id.toString() : "",
        "right_pipe_id":
            rightPipeData.id != null ? rightPipeData.id.toString() : "",
        "joint_id":
            jointNumberData.id != null ? jointNumberData.id.toString() : "",
        "joint_type_id":
            jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "fitup": fitupData.id != null ? fitupData.id.toString() : "",
        "weld_visual":
            weldVisualData.id != null ? weldVisualData.id.toString() : "",
        "welder": welderData.id != null ? welderData.id.toString() : "",
        "electrode_dia_e6010": electrodeDiaE6010,
        "electrode_dia_e6010_batch": electrodeDiaE6010Batch,
        "electrode_dia_e8010p1": electrodeEiaE7010p1,
        "electrode_dia_e8010p1_batch": electrodeEiaE7010p1Batch,
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "preheat_temp": preHeatTempreture.toString(),
      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
          context: !context.mounted ? context : context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        SnackBarSuccessWidget(!context.mounted ? context : context)
            .show(message: res['data']);
        return res;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 415 &&
          res['data'] != null) {
        SnackBarErrorWidget(!context.mounted ? context : context)
            .show(message: res['data']);
        return null;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 400 &&
          res['data'] != null) {
        String resPonse = res['data'].toString();
        SnackBarErrorWidget(!context.mounted ? context : context).show(
            message: resPonse.replaceAll("{", "").toString()
              ..replaceAll("}", ""));
        return null;
      } else {
        SnackBarErrorWidget(!context.mounted ? context : context)
            .show(message: "Internal Server Error");
        return null;
      }
    } catch (e) {
      SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: e.toString());
      return null;
    }
  }
}
