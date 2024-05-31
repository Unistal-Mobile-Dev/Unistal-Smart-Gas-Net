import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';

class DashboardHelper {
  static Future<dynamic> fetchWeatherData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getWeatherApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return weatherListResponse(res['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
