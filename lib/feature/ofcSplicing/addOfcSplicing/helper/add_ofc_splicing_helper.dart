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

class AddOfcSplicingHelper {
  static Future<dynamic> submitData({
    required BuildContext context,
    required AlignmentModel alignmentData,
    required List<AlignmentModel> multipleAlignmentData,
    required String reportNumber,
    required String date,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointTypeModel jointTypeData,
    required JointNumberModel jointNumberData,
    required String chainageFrom,
    required String chainageTo,
    required String jointPit,
    required File file,
    required String srNumberSplicingMachine,
    required String makeModelMachine,
    required String ofcDrumNoPlusDirection,
    required String ofcDrumNoMinusDirection,
    required String cableReadingPlusDirection,
    required String cableReadingMinusDirection,
  }) async {
    try {
      final location = await LocationHelper.getLocation(context: context);

      if (location == null) {
        SnackBarErrorWidget(context).show(message: "Location not found");
        return null;
      }

      final alignmentIds =
          multipleAlignmentData.map((e) => e.id.toString()).join(",");

      final body = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "report_no": reportNumber,
        "activity_date": date,
        "activity_remarks": activityRemark,
        "latitude": location.lat.toString(),
        "longitude": location.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentIds,
        "joint_type_id": jointTypeData.id?.toString() ?? "",
        "joint_id": jointNumberData.id?.toString() ?? "",
        "pit_number": jointPit,
        "weather": weatherData.id?.toString() ?? "",
        "splicing_machine_no": srNumberSplicingMachine,
        "make_model": makeModelMachine,
        "ofc_drum_no_plus_direction": ofcDrumNoPlusDirection,
        "ofc_drum_no_minus_direction": ofcDrumNoMinusDirection,
        "cable_reading_plus_direction": cableReadingPlusDirection,
        "cable_reading_minus_direction": cableReadingMinusDirection,
      };

      final res = await ServerRequest.postDataWithFile(
        urlEndPoint: APIs.addOfcSpliceApi,
        body: body,
        imageRequestObject: [ImageRequestObject(key: "attach_file",path: file.path.toString())],
      );

      if (res == null) {
        SnackBarErrorWidget(context).show(message: "No response from server");
        return null;
      }

      final int statusCode = res['success'] ?? 0;
      final dynamic data = res['data'];

      switch (statusCode) {
        case 200:
          SnackBarSuccessWidget(context).show(message: data.toString());
          return res;

        case 400:
        case 415:
          String errorMessage =
              data.toString().replaceAll("{", "").replaceAll("}", "");

          SnackBarErrorWidget(context).show(message: errorMessage);

          return null;

        default:
          SnackBarErrorWidget(context).show(message: "Internal Server Error");

          return null;
      }
    } catch (e) {
      SnackBarErrorWidget(context).show(message: e.toString());

      return null;
    }
  }
}
