import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/domain/model/welder_repair_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddWelderRepairHelper {
  static Future<dynamic> fetchWelderRepairStatusData(
      {required BuildContext context}) async {
    try {
      String url = APIs.getWelderRepairStatusApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['data'] != null) {
        List<WelderRepairStatusModel> welderRepairStatusList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          welderRepairStatusList
              .add(WelderRepairStatusModel(id: key, value: value));
        });
        return welderRepairStatusList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> submitData(
      {required BuildContext context,
      required AlignmentModel alignmentData,
      required String date,
      required String activityRemark,
      required WeatherModel weatherData,
      required LoginDataModel userData,
      required JointTypeModel jointTypeData,
      required JointNumberModel jointNumberData,
      required List<SegmentModel> segmentList,
      required WelderRepairStatusModel welderRepairStatusData,
      required WPSModel wpsTypeData,
      required WelderModel welderData,
      required String? e6010,
      required String? e8010P1,
      required String? e9045P2,
      required String? er70s6,
      required String? e81TM21AB,
      required String? preHeatingTemperature,
      required File file}) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      List<dynamic> segmentArray = [];
      Map<String, String> segmentData = <String, String>{};
      for (var element in segmentList) {
        var json = {"segments[]": element.id.toString()};
        segmentData.addAll(json);
        segmentArray.add(element.id);
      }

      String url = APIs.addWeldRepairApi;
      dynamic json = {
        "schema": userData.schema.toString(),
        "spreadId": userData.spreadId.toString(),
        "sectionId": userData.sectionId.toString(),
        "activityDate": date.toString(),
        "remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignmentSheet":
            alignmentData.id != null ? alignmentData.id.toString() : "",
        "joint_type_id":
            jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "joint":
            jointNumberData.id != null ? jointNumberData.id.toString() : "",
        "wpsId": wpsTypeData.id != null ? wpsTypeData.id.toString() : "",
        "welderId": welderData.id != null ? welderData.id.toString() : "",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "repairStatus": welderRepairStatusData.id.toString(),
        "preHeatingTemp": preHeatingTemperature.toString(),
        "electrodeFillerE6010": e6010.toString(),
        "electrodeFillerE8010p1": e8010P1.toString(),
        "electrodeFillerE9045p2": e9045P2.toString(),
        "electrodeFillerE81T1m21ab": e81TM21AB.toString(),
        "electrodeFillerEr70s6": er70s6.toString(),
      };
      segmentData.addAll(json);
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: segmentData,
          context: !context.mounted ? context : context,
          keyWord: "attachFile",
          filePath: file.path.toString());
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['message'] != null) {
        SnackBarSuccessWidget(!context.mounted ? context : context).show(message: res['message']);
        return res;
      } else if (res != null &&
          res['status'] != null &&
          res['status'] == false &&
          res['message'] != null) {
        SnackBarErrorWidget(!context.mounted ? context : context).show(message: res['message'].toString());
        return null;
      } else if (res != null &&
          res['status'] != null &&
          res['status'] == false &&
          res['message'] != null) {
        String resPonse = res['message'].toString();
        SnackBarErrorWidget(!context.mounted ? context : context).show(
            message: resPonse.replaceAll("{", "").toString()
              ..replaceAll("}", ""));
        return null;
      }
      return null;
    } catch (e) {
      SnackBarErrorWidget(!context.mounted ? context : context).show(message: e.toString());
      return null;
    }
  }
}
