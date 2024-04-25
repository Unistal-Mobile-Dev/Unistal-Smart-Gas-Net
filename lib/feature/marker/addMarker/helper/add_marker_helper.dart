import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/marker/addMarker/domain/model/marker_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddMarkerHelper {

  static Future<dynamic> fetchMarkerData() async{
      try{
          String url =  APIs.getMarkerTypeApi;
          var res =  await ServerRequest.getData(urlEndPoint: url);
          if(res != null && res['success'] !=  null && res['success'] == 200 && res['data'] != null){
             return markerListResponse(res['data']);
          } else{
            return null;
          }
      }catch(e){
        log(e.toString());
        return null;
      }
  }

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String onWeld,
    required String date,
    required HolidayChecksModel holidayChecksData,
    required String activityRemark,
    required WeatherModel weatherData,
    required LoginDataModel userData,
    required JointNumberModel fromJointData,
    required JointNumberModel toJointData,
    required JointTypeModel jointTypeData,
    required String chainageFrom,
    required String chainageTo,
    required String description,
    required String locationName,
    required String holidayTestNo,
    required String primaryAbatch,
    required String primaryBbatch,
    required String onBody,
    required String surfacePreparation,
    required String surface,
    required ThicknessModel thicknessData,
    required PipeDiaModel pipeDiaData,
    required VisualChecksModel visualChecksData,
    required PipeMaterialModel pipeMaterialData,
    required ThicknessModel coatingThicknessData,
    required PaddingModel peelTestData,
    required MarkerTypeModel markerTypeData,
    required SectionTypeModel sectionTypeData,
    required SpreadTypeModel spreadTypeData,
    required File file}) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addMarkerApi;
      var json = {
        "schema": userData.schema.toString(),
        "spread_id":  spreadTypeData.id !=  null ? spreadTypeData.id.toString()  : "",
        "section_id": sectionTypeData.id !=  null ? sectionTypeData.id.toString()  : "",
        "description": description,
        "activity_date": date.toString(),
        "activity_remarks": activityRemark,
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "user_id": userData.userId.toString(),
        "weather" : weatherData.id != null ? weatherData.id.toString() : "0",
        "marker_type" : markerTypeData.id != null ? markerTypeData.id.toString() : "0",
      };
      if(!context.mounted) return null;
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json, context: context,
          keyWord: "attach_file",
          filePath: file.path.toString());
      if(res != null && res['success'] != null
          && res['success'] == 200 && res['data'] != null) {
        if(!context.mounted) return res;
        SnackBarSuccessWidget(context).show(message: res['data'].toString());
        return res;
      } else  if(res != null && res['success'] != null
          && res['success'] == 415 && res['data'] != null) {
        if(!context.mounted) return null;
        SnackBarErrorWidget(context).show(message: res['data'].toString());
        return null;
      } else  if(res != null && res['success'] != null
          && res['success'] == 400 && res['data'] != null) {
        String response = res['data'].toString();
        if(!context.mounted) return null;
        SnackBarErrorWidget(context).show(message: response.replaceAll("{", "").toString()..replaceAll("}", ""));
        return null;
      }else{
        if(!context.mounted) return null;
        SnackBarErrorWidget(context).show(message: "Internal Server Error");
        return null;
      }
    }catch(e){
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }
}