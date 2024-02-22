import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/domain/file_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddHydroTestHelper {

  static Future<dynamic> fetchFilesData() async {

     try{
         List<FileModel> fileList = [];
         fileList.add(FileModel(name: "DPR Hydrotest Plan", file: File(""), keyName: "planAttachFile"));
         fileList.add(FileModel(name: "DPR Safety", file: File(""), keyName: "safetyAttachFile"));
         fileList.add(FileModel(name: "DPR Civil/Mechanical Certificate Completion", file: File(""), keyName: "civilMechAttachFile"));
         fileList.add(FileModel(name: "DPR Air Cleaning", file: File(""), keyName:  "airCleanAttachFile"));
         fileList.add(FileModel(name: "DPR Brushing", file: File(""),  keyName: "brushingAttachFile"));
         fileList.add(FileModel(name: "DPR Gauge Inspection Report", file: File(""),  keyName:  "inspectionAttachFile"));
         fileList.add(FileModel(name: "DPR Water Filling", file: File(""), keyName:  "waterFillingAttachFile"));
         fileList.add(FileModel(name: "DPR Thermal Stablization", file: File(""), keyName: "stabllizationAttachFile"));
         fileList.add(FileModel(name: "DPR Pressurization Report 50%", file: File(""), keyName: "presurization50AttachFile"));
         fileList.add(FileModel(name: "DPR Pressurization Report 75%", file: File(""), keyName: "presurization75AttachFile"));
         fileList.add(FileModel(name: "DPR Pressurization Report 100%", file: File(""), keyName: "presurization100AttachFile"));
         fileList.add(FileModel(name: "DPR Air Volume Calculation", file: File(""), keyName: "airvolumeAttachFile"));
         fileList.add(FileModel(name: "DPR Pressure Hold for 24 hours", file: File(""), keyName: "hold24AttachFile"));
         fileList.add(FileModel(name: "A ) DPR Hydrostatic Test Calculation", file: File(""), keyName: "testCalculateAttachFile"));
         fileList.add(FileModel(name: "B ) DPR Hydrostatic Test Evaluation", file: File(""), keyName: "testEvalutionAttachFile"));
         fileList.add(FileModel(name: "Depressurization File", file: File(""), keyName: "depressurizationAttachFile"));
         return fileList;
     }catch(e){
       List<FileModel> fileList = [];
       return fileList;
     }
  }

  static Future<dynamic> submitData({required BuildContext context,
    required AlignmentModel alignmentData,
    required String date,
    required String activityRemark,
    required LoginDataModel userData,
    required JointNumberModel fromJointData,
    required JointNumberModel toJointData,
    required JointTypeModel jointTypeData,
    required String length,
    required List<FileModel> fileList}) async {

    try{

      var location =  await LocationHelper.getLocation(context: context);
      LocationModel locationData = LocationModel();
      if(location != null){
        locationData =  location;
      } else{ return null; }

      String url =  APIs.addHydroTestApi;
      var json = {
        "schema": userData.schema.toString(),
        "spreadId": userData.spreadId.toString(),
        "sectionId": userData.sectionId.toString(),
        "activityDate": date.toString(),
        "remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        "alignmentSheet": alignmentData.id != null ? alignmentData.id.toString() : "",
        "joint_id" : jointTypeData.id != null ? jointTypeData.id.toString(): "",
        "jointFrom" : fromJointData.id != null ? fromJointData.id.toString() : "",
        "jointTo" : toJointData.id  != null ? toJointData.id.toString(): "",
        "totalLength" : length.toString(),
      };
      var res =  await ServerRequest.postDataWithFile(urlEndPoint: url, body: json,
          context: context, fileList: fileList);
      if(res != null && res['status'] != null
          && res['status'] == true && res['message'] != null) {
        SnackBarSuccessWidget(context).show(message: res['message']);
        return res;
      } else  if(res != null && res['status'] != null && res['errors'] != null && res['message'] != null) {
        SnackBarErrorWidget(context).show(message: res['message'].toString().replaceAll("{", "").toString().replaceAll("}", ""));
        return null;
      } else{
        SnackBarErrorWidget(context).show(message: "Internal Server Error");
        return null;
      }
    }catch(e){
      SnackBarErrorWidget(context).show(message: e.toString());
      return null;
    }
  }


}