import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/aut_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_layer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_type_model.dart';

class AddNdtAutHelper {

  static Future<dynamic> fetchAutStatusData({required BuildContext context}) async {

    try{
      String url =  APIs.getAutStatusApi;
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        List<AutStatusModel> autStatusLIst = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          autStatusLIst.add(AutStatusModel(id: key, value: value));
        });
        return autStatusLIst;
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchDefectLayerData({required BuildContext context}) async {

    try{
      String url =  APIs.getDefectLayerApi;
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        List<DefectLayerModel> defectLayerList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          defectLayerList.add(DefectLayerModel(id: key, value: value));
        });
        return defectLayerList;
      }
      return null;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchDefectTypeData({required BuildContext context, required LoginDataModel userData}) async {

    try{
      String url =  APIs.getDefectTypeApi+"?schema=${userData.schema}";
      var res =  await ServerRequest.getData(urlEndPoint: url);
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        return defectTypeListResponse(res['data']);
      }
      return null;
    }catch(e){
      return null;
    }
  }

}