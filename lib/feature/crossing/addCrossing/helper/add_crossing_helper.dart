import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/model/crossing_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddCrossingHelper {
  static Future<dynamic> fetchCrossingData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getCrossingTypeApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return crossingTypeListResponse(res['data']);
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
        required List<AlignmentModel> multipleAlignmentData,
      required String onWeld,
      required String date,
      required HolidayChecksModel holidayChecksData,
      required String activityRemark,
      required WeatherModel weatherData,
      required LoginDataModel userData,
      required JointNumberModel fromJointData,
      required JointNumberModel toJointData,
      required JointTypeModel jointTypeData,
      required String sectionLength,
      required String casingPipeLength,
      required String batchNo,
      required String locationName,
      required String holidayTestNo,
      required String concreteCoatingLength,
      required String crossingName,
      required String onBody,
      required String electrometerNo,
      required String surface,
      required ThicknessModel thicknessData,
      required PipeDiaModel pipeDiaData,
      required VisualChecksModel visualChecksData,
      required PipeMaterialModel pipeMaterialData,
      required CoatingTypeModel coatingTypeData,
      required PaddingModel prePaddingData,
      required PaddingModel postPaddingData,
      required CrossingTypeModel crossingTypeData,
      required String reportNumber,
      required File file,
      required File fileStageInspection,
      required File filePreHydrotest,
      required File fileRestoration,
      required File filePhotoBefore,
      required File filePhotoAfter,
      required File fileVideoBefore,
      required File fileVideoAfter,

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

      String url = APIs.addCrossingApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "activity_date": date.toString(),
        "report_no": reportNumber.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        // "alignment_sheet_id": alignmentData.id.toString(),
        "total_length": sectionLength,
        "casing_pipe_length": casingPipeLength,
        "concrete_coating_length": concreteCoatingLength,
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "from_joint_id": fromJointData.id != null ? fromJointData.id.toString() : "",
        "to_joint_id": toJointData.id != null ? toJointData.id.toString() : "",
        "crossing_type_id": crossingTypeData.id != null ? crossingTypeData.id.toString() : "",
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "holiday_checking": holidayChecksData.id != null ? holidayChecksData.id.toString() : "",
        "pre_padding_checking": prePaddingData.id != null ? prePaddingData.id.toString() : "",
        "post_padding_checking": postPaddingData.id != null ? postPaddingData.id.toString() : "",
        "activity_remarks": activityRemark,
        "crossing_name": crossingName,
      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
        imageRequestObject: [
          ImageRequestObject("attach_file", file.path.toString()),
          ImageRequestObject("stage_inspection", fileStageInspection.path.toString()),
          ImageRequestObject("pre_hydrotest", filePreHydrotest.path.toString()),
          ImageRequestObject("restoration", fileRestoration.path.toString()),
          ImageRequestObject("photo_before", filePhotoBefore.path.toString()),
          ImageRequestObject("photo_after", filePhotoAfter.path.toString()),
          ImageRequestObject("video_before", fileVideoBefore.path.toString()),
          ImageRequestObject("video_after", fileVideoAfter.path.toString()),
        ],
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
