import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/model/hindrance_category_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddHindranceHelper {

  static Future<dynamic> fetchHindranceNextId({required LoginDataModel userData}) async {
    try {
      var param = {
        "schema": userData.schema.toString(),
      };
      String json = Uri(queryParameters: param).query;
      String url = APIs.hindranceNextId;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null && res['status'] == 1 && res['next_id'] != null) {
        return res['next_id'].toString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }


  static Future<dynamic> fetchHindranceCategoryData() async {
    try {
      String url = APIs.hindranceCategory;
      var res = await ServerRequest.getData(urlEndPoint:url);
      if (res != null && res['status'] == true  && res['data'] != null) {
        return hindranceCategoryList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchHindranceTypeData({required String categoryId}) async {
    try {
      var param = {
        "category_id": categoryId,
      };
      String json = Uri(queryParameters: param).query;
      String url = APIs.hindranceType;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null && res['status'] == true  && res['data'] != null) {
        return hindranceCategoryList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchActivityAffectedData() async {
    try {
      String url = APIs.activityAffected;
      var res = await ServerRequest.getData(urlEndPoint:url);
      if (res != null && res['status'] == true  && res['data'] != null) {
        return hindranceCategoryList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchResponsibleByData() async {
    try {
      String url = APIs.responsibleBy;
      var res = await ServerRequest.getData(urlEndPoint:url);
      if (res != null && res['status'] == true  && res['data'] != null) {
        return hindranceCategoryList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> textFiledValidation({
    required BuildContext context,
    required String date,
    required String reportNo,
    required String chainageFrom,
    required String chainageTo,
    required HindranceCategoryData hindranceCategory,
    required HindranceCategoryData hindranceType,
    required ActivitySectionData activityAffected,
    required HindranceCategoryData responsibleBy,
    required String resolutionNotes
  }) async {
    try {
      if (date.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select date");
        return false;
      } else if (reportNo.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select Report No");
        return false;
      } else if (hindranceCategory.id == null ) {
        SnackBarErrorWidget(context).show(message: "Please select hindrance category");
        return false;
      } else if (hindranceType.id == null ) {
        SnackBarErrorWidget(context).show(message: "Please select hindrance type");
        return false;
      } else if (activityAffected.id == null ) {
        SnackBarErrorWidget(context).show(message: "Please select activity affected");
        return false;
      } else if (responsibleBy.id == null ) {
        SnackBarErrorWidget(context).show(message: "Please select responsible by");
        return false;
      } else if (chainageFrom.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter chainage from");
        return false;
      } else if (chainageTo.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter chainage To");
        return false;
      }
      // else if (resolutionNotes.isEmpty) {
      //   SnackBarErrorWidget(context).show(message: "Please enter resolution notes");
      //   return false;
      // }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> submitData({
    required BuildContext context,
    required String date,
    required String reportNo,
    required String resolutionNotes,
    required LoginDataModel userData,
    required String locationAdd,
    required String chainageFrom,
    required String chainageTo,
    required HindranceCategoryData hindranceCategory,
    required HindranceCategoryData hindranceType,
    required ActivitySectionData activityAffected,
    required HindranceCategoryData responsibleBy,
    required File file,
  }) async {
    try {
      if (!context.mounted) return null;

      final location = await LocationHelper.getLocation(context: context);
      if (location == null) return null;

      String url = APIs.Addhindranceinsert;

      final Map<String, String?> body = {
        "schema": userData.schema?.toString(),
        "spread": userData.spreadId?.toString(),
        "section": userData.sectionId?.toString(),
        "hindrance_category": hindranceCategory.id?.toString() ?? "0",
        "hindrance_type": hindranceType.id?.toString() ?? "0",
        "activity_affected": activityAffected.id?.toString() ?? "0",
        "responsible_by": responsibleBy.id?.toString() ?? "0",
        "location": locationAdd,
        "chainageFrom": chainageFrom,
        "chainageTo": chainageTo,
        "report_no": reportNo.trim().toString(),
        "reportDate": date.trim().toString(),
        "reason": resolutionNotes.trim().toString(),
        "latitude": location.lat?.toString(),
        "longitude": location.long?.toString(),
        "user_id": userData.userId?.toString(),
      };

      final res = await ServerRequest.postDataWithFile(
        urlEndPoint: url,
        body: body,
        imageRequestObject: [ImageRequestObject("attachmentFile", file.path.toString())],
      );

      if (res != null && res['status'] == 1) {
        SnackBarSuccessWidget(context).show(message: res['message']);
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
