import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/aut_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_layer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddNdtAutHelper {


  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
      required String date,
      required String reportNumber,
      required String activityRemark,
      required WeatherModel weatherData,
      required LoginDataModel userData,
      required JointTypeModel jointTypeData,
      required JointNumberModel jointNumberData,
      required WPSModel wpsTypeData,
      required List<WelderModel> selectedWelderList,
      required List<DefectTypeModel> selectedDefectTypeList,
      required List<DefectLayerModel> selectedDefectLayer,
      required String defectLocation,
      required AutStatusModel autStatusData,
      required File file}) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      List<dynamic> defectTypeList = [];
      List<dynamic> defectLayerList = [];
      List<dynamic> defectWelderList = [];
      List<dynamic> alignmentIdList = [];
      for (var alignmentId in multipleAlignmentData) {
        alignmentIdList.add(alignmentId.id);
      }
      for (var welderData in selectedWelderList) {
        defectWelderList.add(welderData.id);
      }
      for (var defectType in selectedDefectTypeList) {
        defectTypeList.add(defectType.id);
      }
      for (var defectLayer in selectedDefectLayer) {
        defectLayerList.add(defectLayer.id);
      }

      String url = APIs.addNdtAutApi;
      dynamic json = {
        "report_no": reportNumber.toString(),
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        // "alignment_sheet_id": alignmentData.id.toString(),
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "joint_type_id":
            jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "joint_id":
            jointNumberData.id != null ? jointNumberData.id.toString() : "",
        "wpsId": wpsTypeData.id != null ? wpsTypeData.id.toString() : "",
        "aut_status":
            autStatusData.id != null ? autStatusData.id.toString() : "",
        "defect_location": defectLocation.toString(),
        "defect_welder_ids": defectWelderList
            .toString()
            .replaceAll("[", "")
            .toString()
            .replaceAll("]", ""),
        "defect_layer_ids": defectLayerList
            .toString()
            .replaceAll("[", "")
            .toString()
            .replaceAll("]", ""),
        "defect_type_ids": defectTypeList
            .toString()
            .replaceAll("[", "")
            .toString()
            .replaceAll("]", ""),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
        imageRequestObject: [ImageRequestObject(key: "attach_file",path: file.path.toString())],
      );
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
            .show(message: res['data'].toString());
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
      }
      return null;
    } catch (e) {
      SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: e.toString());
      return null;
    }
  }
}
