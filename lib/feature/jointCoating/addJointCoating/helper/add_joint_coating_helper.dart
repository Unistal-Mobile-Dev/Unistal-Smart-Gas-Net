import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddJointCoatingHelper {
  static Future<dynamic> fetchPipeTypeData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getPipeTypeApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return pipeTypeListResponse(res['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchCoatingTypeData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getCoatingTypeApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return coatingTypeListResponse(res['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchPipeMaterialData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getPipeMaterialApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return pipeMaterialListResponse(res['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> submitData(
      {required BuildContext context,
      required AlignmentModel alignmentData,
      required String onWeld,
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
      required String batchNo,
      required String locationName,
      required String holidayTestNo,
      required String primaryAbatch,
      required String primaryBbatch,
      required String onBody,
      required String electrometerNo,
      required String surface,
      required ThicknessModel thicknessData,
      required PipeDiaModel pipeDiaData,
      required VisualChecksModel visualChecksData,
      required PipeMaterialModel pipeMaterialData,
      required CoatingTypeModel coatingTypeData,
      required PaddingModel peelTestData,
      required String reportNumber,
      required File file}) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      String url = APIs.addJointCoatingApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "report_no": reportNumber,
        "activity_date": date.toString(),
        "joint_id": fromJointData.id != null ? fromJointData.id.toString() : "",
        "pipe_type_id":
            pipeMaterialData.id != null ? pipeMaterialData.id.toString() : "",
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id":
            alignmentData.id != null ? alignmentData.id.toString() : "",
        "pipe_dia_id": pipeDiaData.id != null ? pipeDiaData.id.toString() : "",
        "pipe_thickness_id":
            thicknessData.id != null ? thicknessData.id.toString() : "",
        "coating_type_id":
            coatingTypeData.id != null ? coatingTypeData.id.toString() : "",
        "holiday_test":
            holidayChecksData.id != null ? holidayChecksData.id.toString() : "",
        "visuals":
            visualChecksData.id != null ? visualChecksData.id.toString() : "",
        "to_joint_id": toJointData.id != null ? toJointData.id.toString() : "",
        "location": locationName,
        "primer_a_batch": primaryAbatch,
        "primer_b_batch": primaryBbatch,
        "batch_no": batchNo,
        "sleeve": "",
        "surface_contamination": "",
        "surface_roughness": surface,
        "test_voltage": primaryBbatch,
        "holiday_detector": holidayTestNo,
        "coating_damage_repair": electrometerNo,
        "thickness_on_body": onBody,
        "thickness_on_weld": onWeld.toString(),
        "peel_test": peelTestData.id != null ? peelTestData.id.toString() : "",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
          context: context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        SnackBarSuccessWidget(context).show(message: res['data'].toString());
        return res;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 415 &&
          res['data'] != null) {
        SnackBarErrorWidget(context).show(message: res['data'].toString());
        return null;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 400 &&
          res['data'] != null) {
        String resPonse = res['data'].toString();
        SnackBarErrorWidget(context).show(
            message: resPonse.replaceAll("{", "").toString()
              ..replaceAll("}", ""));
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
