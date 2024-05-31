import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class RestoreCutPipeHelper {
  static Future<dynamic> fetchCutePipeList(
      {required BuildContext context}) async {
    try {
      String url = APIs.getCutePipeApi;
      var res = await ServerRequest.getData(urlEndPoint: url);
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['data'] != null) {
        return pipeResponseList(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> submitData(
      {required BuildContext context, required PipeModel pipeData}) async {
    try {
      String url = APIs.updateCutePipeApi + "${pipeData.id}";
      var res = await ServerRequest.putData(urlEndPoint: url, body: "");
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['message'] != null) {
        SnackBarSuccessWidget(context).show(message: res['message']);
        return res;
      } else if (res != null && res['error'] != null) {
        SnackBarErrorWidget(context).show(message: res['error']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
