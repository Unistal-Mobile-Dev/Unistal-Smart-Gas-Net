import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddHddCrossingHelper {


  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
        required String date,
        required String reportNumber,
        required String activityRemark,
        required WeatherModel weatherData,
        required LoginDataModel userData,
        required JointNumberModel fromJointData,
        required JointNumberModel toJointData,
        required String hddLocation,
        required String equipmentUsed,
        required String equipmentCapacit,
        required String commencementDate,
        required String completionDate,
        required String preHydroTestDate,
        required String crossingLength,
        required String pilotBoreCommencementDate,
        required String pilotBoreCompletionDate,
        required String pilotBoreDiameter,
        required String pilotBoreStartTime,
        required String pilotBoreComplateTime,
        required String pilotBoreDuration,
        required String reamerSize,
        required String reamingStart,
        required String reamingEnd,
        required String reamingDuration,
        required String loadObserved,
        required File file
      }) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }
      List<dynamic> alignmentIdList = [];
      for (var alignmentId in multipleAlignmentData) {
        alignmentIdList.add(alignmentId.id);
      }
      String url = APIs.addPipeCrossingInsertApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        // "alignment_sheet_id": alignmentData.id.toString(),
        "alignment_sheet_id":  alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "from_joint_id": fromJointData.id != null ? fromJointData.id.toString() : "",
        "to_joint_id": toJointData.id != null ? toJointData.id.toString() : "",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "hdd_location": hddLocation.toString(),
        "equipment_used": equipmentUsed.toString(),
        "equipment_capacit": equipmentCapacit,
        "commencement_date": commencementDate,
        "completion_date":completionDate,
        "pre_hydro_test_date":preHydroTestDate,
        "crossing_length": crossingLength,
        "pilot_bore_commencement_date": pilotBoreCommencementDate,
        "pilot_bore_completion_date": pilotBoreCompletionDate,
        "pilot_bore_diameter": pilotBoreDiameter,
        "pilot_bore_start_time": pilotBoreStartTime,
        "pilot_bore_complate_time": pilotBoreComplateTime,
        "pilot_bore_duration": pilotBoreDuration,
        "reamer_size": reamerSize,
        "reaming_start": reamingStart,
        "reaming_end": reamingEnd,
        "reaming_duration": reamingDuration,
        "load_observed": loadObserved,

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
            .show(message: res['data'].toString());
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
