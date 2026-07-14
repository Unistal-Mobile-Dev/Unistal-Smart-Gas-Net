import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddHydroTestHelper {
  static Future<dynamic> fetchFilesData() async {
    try {
      List<ImageRequestObject> fileList = [];
      fileList.add(ImageRequestObject(
          name: "DPR Hydrotest Plan", path: "", key: "planAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Safety", path: "", key: "safetyAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Civil/Mechanical Certificate Completion",
          path: "",
          key: "civilMechAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Air Cleaning", path: "", key: "airCleanAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Brushing", path: "", key: "brushingAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Gauge Inspection Report",
          path: "",
          key: "inspectionAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Water Filling", path: "", key: "waterFillingAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Thermal Stablization",
          path: "",
          key: "stabllizationAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Pressurization Report 50%",
          path: "",
          key: "presurization50AttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Pressurization Report 75%",
          path: "",
          key: "presurization75AttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Pressurization Report 100%",
          path: "",
          key: "presurization100AttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Air Volume Calculation",
          path: "",
          key: "airvolumeAttachFile"));
      fileList.add(ImageRequestObject(
          name: "DPR Pressure Hold for 24 hours",
          path: "",
          key: "hold24AttachFile"));
      fileList.add(ImageRequestObject(
          name: "A ) DPR Hydrostatic Test Calculation",
          path: "",
          key: "testCalculateAttachFile"));
      fileList.add(ImageRequestObject(
          name: "B ) DPR Hydrostatic Test Evaluation",
          path: "",
          key: "testEvalutionAttachFile"));
      fileList.add(ImageRequestObject(
          name: "Depressurization path",
          path: "",
          key: "depressurizationAttachFile"));
      return fileList;
    } catch (e) {
      List<ImageRequestObject> fileList = [];
      return fileList;
    }
  }

  static Future<dynamic> submitData(
      {required BuildContext context,
      required AlignmentModel alignmentData,
      required List<AlignmentModel> multipleAlignmentData,
      required String date,
      required String activityRemark,
      required LoginDataModel userData,
      required JointNumberModel fromJointData,
      required JointNumberModel toJointData,
      required JointTypeModel jointTypeData,
      required String length,
      required String reportNumber,
      required List<ImageRequestObject> fileList}) async {
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

      String url = APIs.addHydroTestApi;
      var json = {
        "schema": userData.schema.toString(),
        "spreadId": userData.spreadId.toString(),
        "sectionId": userData.sectionId.toString(),
        "activityDate": date.toString(),
        "report_no": reportNumber.toString(),
        "remarks": activityRemark.toString(),
        "latitude": locationData.lat.toString(),
        "longitude": locationData.long.toString(),
        // "alignmentSheet": alignmentData.id.toString(),
        "alignmentSheet": alignmentIdList
            .toString()
            .replaceAll("[", "")
            .toString()
            .replaceAll("]", ""),
        "joint_id": jointTypeData.id != null ? jointTypeData.id.toString() : "",
        "jointFrom":
            fromJointData.id != null ? fromJointData.id.toString() : "",
        "jointTo": toJointData.id != null ? toJointData.id.toString() : "",
        "totalLength": length.toString(),
      };
      var res = await ServerRequest.postDataWithFile(
        urlEndPoint: url,
        body: json,
        imageRequestObject: fileList,
      );

      if (res != null &&
          res['success'] == 200 &&
          res['error'] == false &&
          res['data'] != null) {
        SnackBarSuccessWidget(!context.mounted ? context : context)
            .show(message: res['data']);
        return res;
      } else if (res != null &&
          res['success'] == 415 &&
          res['error'] == true &&
          res['data'] != null) {
        SnackBarErrorWidget(!context.mounted ? context : context).show(
            message: res['data']
                .toString()
                .replaceAll("{", "")
                .toString()
                .replaceAll("}", ""));
        return null;
      } else {
        SnackBarErrorWidget(!context.mounted ? context : context)
            .show(message: "Internal Server Error");
        return null;
      }
    } catch (e) {
      print("-----------------------------${e.toString()}");
      SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: e.toString());
      return null;
    }
  }
}
