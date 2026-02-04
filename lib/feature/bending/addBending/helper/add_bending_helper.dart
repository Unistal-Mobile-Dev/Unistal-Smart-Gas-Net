import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/bending_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddBendingHelper {
  static Future<dynamic> textFiledValidation(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
      required String reportNumber,
      required String date,
      required String bendTpNumber,
      required String bendDegree,
      required String bendMinits,
      required String bendSecond,
      required String chainage,
      required BendingTypeModel bendingTypeData,
      required VisualChecksModel visualChecksData,
      required VisualChecksModel gaugingCheckData,
      required VisualChecksModel disbomdmentCheckData,
      required HolidayChecksModel holidayChecksData,
      required PipeModel pipeData,
      required String activityRemark}) async {
    try {
      if (date.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select date");
        return false;
      } else if (alignmentData.id == null || multipleAlignmentData.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select alignment");
        return false;
      } else if (reportNumber.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter report number");
        return false;
      } else if (pipeData.id == null) {
        SnackBarErrorWidget(context).show(message: "Please select pipe data");
        return false;
      } else if (chainage.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter chainage");
        return false;
      } else if (bendingTypeData.id == null) {
        SnackBarErrorWidget(context)
            .show(message: "Please select bending type data");
        return false;
      } else if (visualChecksData.id == null) {
        SnackBarErrorWidget(context)
            .show(message: "Please select visual checks data");
        return false;
      } else if (gaugingCheckData.id == null) {
        SnackBarErrorWidget(context)
            .show(message: "Please select gauging check data");
        return false;
      } else if (disbomdmentCheckData.id == null) {
        SnackBarErrorWidget(context)
            .show(message: "Please select disbomdment check data");
        return false;
      } else if (holidayChecksData.id == null) {
        SnackBarErrorWidget(context)
            .show(message: "Please select holiday check data");
        return false;
      } else if (bendTpNumber.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter bend tp number");
        return false;
      } else if (bendDegree.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter bend degree");
        return false;
      } else if (bendMinits.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter bend Minute");
        return false;
      } else if (bendSecond.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter bend second");
        return false;
      } else if (activityRemark.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter activity remark");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> submitData({
    required BuildContext context,
    required AlignmentModel alignmentData,
    required List<AlignmentModel> multipleAlignmentData,
      required String reportNumber,
      required String date,
      required String bendTpNumber,
      required String bendDegree,
      required String bendMinits,
      required String bendSecond,
      required String chainage,
      required BendingTypeModel bendingTypeData,
      required VisualChecksModel visualChecksData,
      required VisualChecksModel gaugingCheckData,
      required VisualChecksModel disbomdmentCheckData,
      required HolidayChecksModel holidayChecksData,
      required PipeModel pipeData,
      required String activityRemark,
      required WeatherModel weatherData,
      required LoginDataModel userData,
      required String chainageFrom,
      required String chainageTo,
      required String bendNumber,
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

      String url = APIs.addBendinginsertApi;
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
        "alignment_sheet_id": AppConfig.instanceInit()!.client == Client.vppl
            ? alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", "") :alignmentData.id.toString(),
        "pipe_id": pipeData.id.toString(),
        "chainage": chainage.toString(),
        "visual_checks": visualChecksData.id.toString(),
        "gauging_checks": gaugingCheckData.id.toString(),
        "disbomdment_checks": disbomdmentCheckData.id.toString(),
        "holiday_checks": holidayChecksData.id.toString(),
        "bend_no": bendNumber,
        "bend_type_id": bendingTypeData.id.toString(),
        "bend_angle_tp_number": bendTpNumber,
        "bend_angle_degree": bendDegree,
        "bend_angle_minute": bendMinits,
        "bend_angle_second": bendSecond,
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
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

  static Future<dynamic> fetchBendingType(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getBendingTypeApi;
      var param = {
        "schema": userData.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return bendingTypeListResponse(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchVisualChecks(
      {required BuildContext context}) async {
    try {
      String url = APIs.getVisualChecksApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<VisualChecksModel> visualChecksList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          visualChecksList.add(VisualChecksModel(id: key, value: value));
        });
        return visualChecksList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchHolidayData(
      {required BuildContext context}) async {
    try {
      String url = APIs.getHolidayChecksApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<HolidayChecksModel> holidayChecksList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          holidayChecksList.add(HolidayChecksModel(id: key, value: value));
        });
        return holidayChecksList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
