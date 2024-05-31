import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddPostHydroTestHelper {
  static Future<dynamic> submitData(
      {required BuildContext context,
      required AlignmentModel alignmentData,
      required String date,
      required String activityRemark,
      required WeatherModel weatherData,
      required LoginDataModel userData,
      required JointNumberModel fromJointData,
      required JointNumberModel toJointData,
      required JointTypeModel jointTypeData,
      required String length,
      required File file}) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      String url = APIs.addPostHydroTestApi;
      var json = {
        "schema": userData.schema.toString(),
        "spreadId": userData.spreadId.toString(),
        "sectionId": userData.sectionId.toString(),
        "activityDate": date.toString(),
        "remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "alignmentSheet":
            alignmentData.id != null ? alignmentData.id.toString() : "",
        "joint_id": jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "jointFrom":
            fromJointData.id != null ? fromJointData.id.toString() : "",
        "jointTo": toJointData.id != null ? toJointData.id.toString() : "",
        "totalLength": length.toString(),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
          context: context,
          keyWord: "attachFile",
          filePath: file.path.toString());
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['message'] != null) {
        SnackBarSuccessWidget(context).show(message: res['message']);
        return res;
      } else if (res != null &&
          res['status'] != null &&
          res['errors'] != null &&
          res['message'] != null) {
        SnackBarErrorWidget(context).show(
            message: res['message']
                .toString()
                .replaceAll("{", "")
                .toString()
                .replaceAll("}", ""));
        return null;
      } else {
        SnackBarErrorWidget(context).show(message: "Internal Server Error");
        return null;
      }
    } catch (e) {
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }
}
