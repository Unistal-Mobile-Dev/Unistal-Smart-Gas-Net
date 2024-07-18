import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';

class AddTestStationBoxHelper{


  static Future<dynamic> fetchTLPType(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getTLPTypeApi;
      var param = {
        "schema": userData.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
      return tlpTypeResList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchAnodeTypeApi(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getAnodeTypeApi;
      var param = {
        "schema": userData.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return tlpTypeResList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}