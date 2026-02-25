import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_source_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddNdtMutHelper {
  static Future<dynamic> fetchNdtStatusData(
      {required BuildContext context}) async {
    try {
      String url = APIs.getNdtStatusApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<NdtStatusModel> ndtStatusList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          ndtStatusList.add(NdtStatusModel(id: key, value: value));
        });
        return ndtStatusList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchNdtSourceData(
      {required BuildContext context}) async {
    try {
      String url = APIs.getNdtSourceApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<NdtSourceModel> ndtSourceList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          ndtSourceList.add(NdtSourceModel(id: key, value: value));
        });
        return ndtSourceList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> submitData(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
      required String reportNumber,
      required String date,
      required String activityRemark,
      required WeatherModel weatherData,
      required LoginDataModel userData,
      required JointTypeModel jointTypeData,
      required JointNumberModel jointNumberData,
      required List<dynamic> segmentData,
      required List<dynamic> segmentStatusData,
      required List<dynamic> segmentObservationData,
      required List<dynamic> segmentRemarkData,
      required NdtStatusModel ndtAgencyData,
      required NdtStatusModel dSPPLAgencyData,
      required NdtStatusModel meconPbgplData,
      required String locationDefect,
      required String typeOfFlawDetector,
      required String angleOfRayInput,
      required String operatingFrequency,
      required String leveOfInspection,
      required PipeModel pipeData,
      required File file}) async {
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

      String url = APIs.addNdtMutApi;
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
        "alignment_sheet_id": AppConfig.instanceInit()!.client == Client.vppl || AppConfig.instanceInit()!.client == Client.vrpl
            ? alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", "") :alignmentData.id.toString(),
        "joint_type_id":
            jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "joint_id":
            jointNumberData.id != null ? jointNumberData.id.toString() : "",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "segment_ids": segmentData
            .toString()
            .replaceAll("]", "")
            .toString()
            .replaceAll("[", ""),
        "segment_status": segmentStatusData
            .toString()
            .replaceAll("]", "")
            .toString()
            .replaceAll("[", ""),
        "segment_observation": segmentObservationData
            .toString()
            .replaceAll("]", "")
            .toString()
            .replaceAll("[", ""),
        "segment_remark": segmentRemarkData
            .toString()
            .replaceAll("]", "")
            .toString()
            .replaceAll("[", ""),
        "ndt_agency_status":
            ndtAgencyData.id != null ? ndtAgencyData.id.toString() : "",
        "contractor_agency_status":
            dSPPLAgencyData.id != null ? dSPPLAgencyData.id.toString() : "",
        "pmc_agency_status":
            meconPbgplData.id != null ? meconPbgplData.id.toString() : "",
        "pipe_id": pipeData.id != null ? pipeData.id.toString() : "",
        "defects": locationDefect,
        "flaw_detector_type": typeOfFlawDetector,
        "angle_ray_input": angleOfRayInput,
        "operating_frequency": operatingFrequency,
        "inspection_level": leveOfInspection,
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

  static Future<dynamic> fetchSegmentData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getSegmentApi;
      var param = {
        "schema": userData.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['segment'] != null) {
        List<SegmentModel> segmentList =
            segmentListResponse(res['segment'], []);
        return segmentList;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
