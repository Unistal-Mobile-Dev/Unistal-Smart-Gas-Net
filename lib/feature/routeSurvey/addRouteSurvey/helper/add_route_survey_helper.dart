import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/ground_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddRouteSurveyHelper {
  static Future<dynamic> textFiledValidation(
      {required BuildContext context,
      required AlignmentModel alignmentData,
      required String reportNumber,
      required String date,
      required String tpIpChainage,
      required String tpIpNOS,
      required String tpIpRemark,
      required String bearing,
      required String terrain,
      required String activityRemark}) async {
    try {
      if (date.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please select date");
        return false;
      } else if (alignmentData.id == null) {
        SnackBarErrorWidget(context).show(message: "Please api/steel/ignment");
        return false;
      } else if (reportNumber.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter report number");
        return false;
      } else if (tpIpChainage.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter TP IP Chainage");
        return false;
      } else if (tpIpNOS.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter tp ip number");
        return false;
      } else if (tpIpRemark.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter tp ip remark");
        return false;
      } else if (bearing.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter bearing angle");
        return false;
      } else if (terrain.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Please enter terrain");
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

  static Future<dynamic> fetchGroundTypeData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getGroundTypeApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return groundTypeListResponse(res['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> submitData({
    required BuildContext context,
    required AlignmentModel alignmentData,
    required String reportNumber,
    required String date,
    required String tpIpChainage,
    required String tpIpNOS,
    required String tpIpRemark,
    required String bearing,
    required String terrain,
    required String activityRemark,
    required LoginDataModel userData,
    required File file,
    required String chainageFrom,
    required String chainageTo,
    required WeatherModel weatherData,
    required GroundTypeModel groundTypeData,
  }) async {
    try {
      var location = await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if (location != null) {
        locationData = location;
      } else {
        return null;
      }

      String url = APIs.addRouteSurveyApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id": userData.spreadId.toString(),
        "section_id": userData.sectionId.toString(),
        "chainage_from": chainageFrom,
        "chainage_to": chainageTo,
        "report_no": reportNumber.toString(),
        "activity_date": date.toString(),
        "tp_ip_chainage": tpIpChainage.toString(),
        "tp_ip_nos": tpIpNOS.toString(),
        "tp_remarks": tpIpRemark.toString(),
        "bearing_angle": bearing.toString(),
        "terrain": terrain.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "alignment_sheet_id": alignmentData.id.toString(),
        "weather": weatherData.id != null ? weatherData.id.toString() : "",
        "ground_type_id":
            groundTypeData.id != null ? groundTypeData.id.toString() : "",
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
        SnackBarSuccessWidget(context).show(message: res['data']);
        return res;
      } else if (res != null &&
          res['success'] != null &&
          res['success'] == 415 &&
          res['data'] != null) {
        SnackBarErrorWidget(context).show(message: res['data']);
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

  static Future<dynamic> fetchAlignmentData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getAlignmentSheetApi;
      var param = {
        "schema": userData.schema,
        "spread_id": userData.spreadId,
        "section_id": userData.sectionId,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return alignmentResponseList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> imagePiker({required BuildContext context}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 60,
          maxHeight: 1200,
          maxWidth: 950,
          preferredCameraDevice: CameraDevice.rear);
      if (photo != null) {
        return File(photo.path);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> filePiker({required BuildContext context}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
      );
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        return files[0];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void mediaType({required BuildContext context}) {
    showModalBottomSheet(
      context: context, // Also default
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    "Gallery",
                    fontSize: AppFont.font_16,
                  )),
            ],
          ),
        );
      },
    );
  }
}
