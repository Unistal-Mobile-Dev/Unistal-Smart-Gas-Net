import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/model/hindrance_category_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class EditHindranceHelper {

  static Future<dynamic> textFiledValidation({
    required BuildContext context,
    required String resolutionDate,
  }) async {
    try {
       if (resolutionDate.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter resolution date");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> submitData({
    required BuildContext context,
    required String date,
    required String id,
    required String reportNo,
    required String resolutionDate,
    required String resolutionNotes,
    required String resolutionEditNotes,
    required LoginDataModel userData,
    required String locationAdd,
    required String chainageFrom,
    required String chainageTo,
    required String hindranceCategory,
    required String hindranceType,
    required String activityAffected,
    required String responsibleBy,
    required File file,
  }) async {
    try {
      if (!context.mounted) return null;

      final location = await LocationHelper.getLocation(context: context);
      if (location == null) return null;

      String url = APIs.Addhindranceinsert;

      final Map<String, String?> body = {
        "id": id.toString(),
        "schema": userData.schema?.toString(),
        "spread": userData.spreadId?.toString(),
        "section": userData.sectionId?.toString(),
        "hindrance_category": hindranceCategory.toString(),
        "hindrance_type": hindranceType.toString(),
        "activity_affected": activityAffected.toString(),
        "responsible_by": responsibleBy.toString(),
        "location": locationAdd,
        "chainageFrom": chainageFrom,
        "chainageTo": chainageTo,
        "report_no": reportNo.trim().toString(),
        "reportDate": date.trim().toString(),
        "toDate": resolutionDate.trim().toString(),
        "reason": resolutionNotes.trim().toString(),
        "edit_remarks": resolutionEditNotes.trim().toString(),
        "latitude": location.lat?.toString(),
        "longitude": location.long?.toString(),
        "user_id": userData.userId?.toString(),
      };

      final res = await ServerRequest.postDataWithFile(
        urlEndPoint: url,
        body: body,
        context: context,
        keyWord: "attachmentFile",
        filePath: file.path,
      );

      if (res != null && res['status'] == 1) {
        SnackBarSuccessWidget(context).show(message: res['message']);
        return res;
      }
      if (res != null && res['status'] == 0) {
        SnackBarSuccessWidget(context).show(message: res['errors']);
        return res;
      }
      if (res != null && res['success'] == 415) {
        SnackBarErrorWidget(context).show(message: res['data']);
        return null;
      }
      if (res != null && res['success'] == 400) {
        String message = res['data'].toString().replaceAll("{", "").replaceAll("}", "");
        SnackBarErrorWidget(context).show(message: message);
        return null;
      }
      SnackBarErrorWidget(context).show(message: "Internal Server Error");
      return null;
    } catch (e) {
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }
}
