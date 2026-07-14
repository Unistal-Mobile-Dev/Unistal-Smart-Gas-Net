import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddConcreteCoatingHelper {
  static Future<dynamic> textFiledValidation(
      {required BuildContext context,
        required AlignmentModel alignmentData,
        required List<AlignmentModel> multipleAlignmentData,
      required String reportNumber,
      required String date,
      required String concreteCoatingLength,
      required String chainage,
      required PipeModel pipeData,
      required WeatherModel weatherData,
      required ThicknessModel thicknessData,
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
      } else if (thicknessData.id == null) {
        SnackBarErrorWidget(context)
            .show(message: "Please select Concrete Coating Thickness data");
        return false;
      } else if (concreteCoatingLength.isEmpty) {
        SnackBarErrorWidget(context)
            .show(message: "Please enter concrete coating length");
        return false;
      } else if (weatherData.id == null) {
        SnackBarErrorWidget(context).show(message: "Select weather");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> fetchThicknessData() async {
    LoginDataModel? userData =  UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getPipeThicknessApi + "?schema=${userData!.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return thicknessListResponse(res['data']);
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
      required String date,
      required String reportNumber,
      required String concreteCoatingLength,
      required String chainage,
      required PipeModel pipeData,
      required WeatherModel weatherData,
      required String activityRemark,
      required LoginDataModel userData,
      required File file,
      required String remark,
      required ThicknessModel thicknessData}) async {
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


      String url = APIs.addConcreteCoatingApi;
      var json = {
        "activityDate": date,
        "schema": userData.schema.toString(),
        "weather": weatherData.name.toString(),
        "report_no": reportNumber.toString(),
        // "alignmentSheet": alignmentData.id.toString(),
        "alignment_sheet_id": alignmentIdList.toString().replaceAll("[", "").toString().replaceAll("]", ""),
        "spreadId": userData.spreadId.toString(),
        "sectionId": userData.sectionId.toString(),
        "pipeId": pipeData.id.toString(),
        "chainage": chainage.toString(),
        "totalLength": concreteCoatingLength.toString(),
        "thicknessId":
            thicknessData.id != null ? thicknessData.id.toString() : "",
        "remarks": remark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
      };
      var res = await ServerRequest.postDataWithFile(
          urlEndPoint: url,
          body: json,
        imageRequestObject: [ImageRequestObject(key: "attach_file",path: file.path.toString())],
      );
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['message'] != null) {
        SnackBarSuccessWidget(!context.mounted ? context : context)
            .show(message: res['message']);
        return res;
      } else if (res != null &&
          res['status'] != null &&
          res['errors'] != null) {
        SnackBarErrorWidget(!context.mounted ? context : context)
            .show(message: res['errors']);
        return null;
      } else {
        SnackBarErrorWidget(!context.mounted ? context : context)
            .show(message: "Internal Server Error");
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
