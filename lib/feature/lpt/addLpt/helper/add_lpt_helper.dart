import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/domain/model/lpt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddLptHelper {


  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
        required String reportNumber,
        required String date,
        required String activityRemark,
        required WeatherModel weatherData,
        required LoginDataModel userData,
        required JointNumberModel jointData,
        required JointTypeModel jointTypeData,
        required LptStatusModel lptStatusData,
        required String observationResults,
        required PipeModel pipeData,
        required File file,
        required String penetrantManufacturer,
        required String penetrantBatchNo,
        required String cleanerManufacturer,
        required String cleanerBatchNo,
        required String developerManufacturer,
        required String developerBatchNo,
        required String surfaceTemperature,
        required String penetrantDwellTime,
        required String developerTime,
        required String acceptanceCriteria,
        required String materialType,
        required String applicationMethod,
        required String sketch,
        required String type,
        required String size,
        required ThicknessModel pipeThicknessData,
        required TerrainTypeModel meil,
        required TerrainTypeModel ceil,
        required TerrainTypeModel mecon,
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

      String url = APIs.addLptApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "Observation": observationResults,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "joint_type_id":
        jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "joint_id": jointData.id != null ? jointData.id.toString() : "",
        "pipe_id": pipeData.id != null ? pipeData.id.toString() : "",
        "lpt_status":
        lptStatusData.id != null ? lptStatusData.id.toString() : "0",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "penetrant_manufacturer": penetrantManufacturer,
        "penetrant_batch_no": penetrantBatchNo,
        "cleaner_manufacturer": cleanerManufacturer,
        "cleaner_batch_no": cleanerBatchNo,
        "developer_manufacturer": developerManufacturer,
        "developer_batch_no": developerBatchNo,
        "surface_temperature": surfaceTemperature,
        "penetrant_dwell_time": penetrantDwellTime,
        "developer_time": developerTime,
        "acceptance_criteria": acceptanceCriteria,
        "material_type": materialType,
        "application_method": applicationMethod,
        "sketch": sketch,
        "size": size,
        "type": type,
        "meil": meil.id != null ? meil.id .toString() : "",
        "ceil": ceil.id != null ? ceil.id .toString() : "",
        "mecon": mecon.id != null ? mecon.id .toString() : "",
        "pipe_thickness": pipeThicknessData.id != null
            ? pipeThicknessData.id.toString()
            : "",
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