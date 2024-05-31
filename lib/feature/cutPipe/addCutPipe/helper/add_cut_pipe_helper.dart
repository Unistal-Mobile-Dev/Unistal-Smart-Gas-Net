import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class AddCutPipeHelper {
  static Future<dynamic> textFieldValidation(
      {required BuildContext context, required String cutePipeLength}) async {
    try {
      if (cutePipeLength.isEmpty) {
        SnackBarErrorWidget(context).show(message: "Enter cute pipe length");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> submitData(
      {required BuildContext context,
      required String cutePipeLength,
      required PipeModel pipeData}) async {
    try {
      String url = APIs.addCutePipeApi;
      var json = {
        "pipeId": pipeData.id.toString(),
        "pipeLength": pipeData.pipeLength.toString(),
        "cutpipeLength": cutePipeLength.toString(),
      };

      var res = await ServerRequest.postData(urlEndPoint: url, body: json);
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['message'] != null) {
        SnackBarSuccessWidget(context).show(message: res['message']);
        return res;
      } else if (res != null && res['status'] != null && res['error'] != null) {
        SnackBarErrorWidget(context).show(message: res['error']);
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
}
