import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/model/HindranceListModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';

class ViewHindranceHelper {

  static Future<dynamic> fetchHindranceListData({
    required String search,
    required LoginDataModel userData,
  }) async {
    try {
      var param = {
        "schema": userData.schema.toString(),
        "pageSize": "10",
        "section": userData.sectionId.toString(),
        "search": search,
      };
      String json = Uri(queryParameters: param).query;
      String url = APIs.hindranceList;
      var res = await ServerRequest.getData(urlEndPoint: "$url?$json");
      if (res != null && res['success'] == 200  && res['data'] != null && res['error'] == false  ) {
        return hindranceListData(res['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

}
