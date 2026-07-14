import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/domain/model/lpt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/domain/model/marker_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/aut_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_layer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/electrode_batch_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/electrode_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardHelper {


  static Future<dynamic> fetchWeatherData() async {
    LoginDataModel? userData =  UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getWeatherApi + "?schema=${userData!.schema}";
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

  static Future<dynamic> fetchWPSType() async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getWPSApi;
      var param = {
        "schema": userData!.schema,
        "spread_id": userData.spreadId,
        "section_id": userData.sectionId,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return wpsListResponse(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchElectrodeDia() async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getElectrodeDiaBatch;
      var param = {
        "schema": userData!.schema,
        "section_id": userData.sectionId,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return electrodeDiaListResponse(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchElectrodeBatch({required String diaValue}) async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getElectrodeDiaBatch;
      var param = {
        "schema": userData!.schema,
        "section_id": userData.sectionId,
        "dia_value": diaValue,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return electrodeBatchListResponse(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchJointType() async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getJointTypeApi;
      var param = {
        "schema": userData!.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return jointTypeListResponse(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchJointNumberData({
    required String type,
  }) async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getJointNumberWithTypeApi;
      var param = {
        "schema": userData!.schema,
        "section_id": userData.sectionId,
        "type": type,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return jointNumberListResponse(res['data']['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<MarkerTypeModel>?> fetchMarkerType() async {
    LoginDataModel? userData =  UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getMarkerTypeApi;
      var param = {
        "schema": userData!.schema,
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return markerTypeListResponse(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchWelderData({required WPSModel wpsData}) async {
    LoginDataModel? userData = UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getWelderApi;
      var param = {
        "schema": userData!.schema,
        "spread_id": userData.spreadId,
        "section_id": userData.sectionId,
        "wps_id": wpsData.id != null ? wpsData.id.toString() : "",
      };
      String json = Uri(queryParameters: param).query;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      log("getWelderApi-->$url?$json");
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return welderListResponse(res['data']['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchAutStatusData(
      {required BuildContext context}) async {
    try {
      String url = APIs.getAutStatusApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<AutStatusModel> autStatusLIst = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          autStatusLIst.add(AutStatusModel(id: key, value: value));
        });
        return autStatusLIst;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchDefectLayerData(
      {required BuildContext context}) async {
    try {
      String url = APIs.getDefectLayerApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<DefectLayerModel> defectLayerList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          defectLayerList.add(DefectLayerModel(id: key, value: value));
        });
        return defectLayerList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchDefectTypeData(
      {required BuildContext context, required LoginDataModel userData}) async {
    try {
      String url = APIs.getDefectTypeApi + "?schema=${userData.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return defectTypeListResponse(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchLptData() async {
    try {
      String url = APIs.getLptStatusApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<LptStatusModel> lptStatusList = [];
        Map myMap = res['data'];
        myMap.forEach((key, value) {
          lptStatusList.add(LptStatusModel(id: key, value: value));
        });
        return lptStatusList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<TerrainTypeModel>> fetchConstantData({required String key}) async {
    try {
      String url = APIs.getConstantApi + "?key=$key";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null && res is Map<String, dynamic>) {
        return res.entries.map((entry) {
          return TerrainTypeModel(
            id: entry.key,
            name: entry.value.toString(),
          );
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }


  static Future<File?> cameraCapture() async {
    await Permission.camera.request();
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 900,
      maxWidth: 1000,
    );
    File files = File(file!.path);
    return files;
  }

  static Future<dynamic> fetchTerrainData() async {
    LoginDataModel? userData =  UserInfo.instanceInit()!.userData;
    try {
      String url = APIs.getTerrianApi + "?schema=${userData!.schema}";
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        return terrainListResponse(res['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<File?> galleryCapture() async {
    await Permission.storage.request();
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 900,
      maxWidth: 1000,
    );
    File files = File(file!.path);
    return files;
  }
}
