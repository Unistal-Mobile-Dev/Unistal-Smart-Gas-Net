import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/services/apis.dart';
import 'package:flutter_unistal_smart_gas_net/services/server_request.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';

class SectionIdHelper {
  static Future<List<ActivitySectionData>?> activityBySectionApi({
    required LoginDataModel userData,
  }) async {
    try {
      String url = APIs.activityBySection;
      Map<String, String> para = {
        "schema": "${userData.schema}",
        "userid": "${userData.userId}",
        "section_id":""
      };

      String json = Uri(queryParameters: para).query;
      var res = await ServerRequest.getData(urlEndPoint: url + json);

      if (res != null && res['success'] == 200 && res['data'] != null) {
        final list = (res['data'] as List)
            .map((e) => ActivitySectionData.fromJson(e))
            .toList();
        return list;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}