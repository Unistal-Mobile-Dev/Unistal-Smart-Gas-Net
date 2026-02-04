import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';

List<SegmentWelderModel> segmentWelderListResponse(
    var json, List<WelderModel> welderList) {
  return List<SegmentWelderModel>.from(
      json.map((x) => SegmentWelderModel.fromJson(x, welderList)));
}

class SegmentWelderModel {
  dynamic id;
  String? name;
  List<WelderModel>? welderList;
  List<WelderModel>? multipleWelderData;
  WelderModel? welderData;

  SegmentWelderModel({this.welderData, this.welderList, this.id, this.name, this.multipleWelderData});

  factory SegmentWelderModel.fromJson(
      Map<String, dynamic> json, List<WelderModel> welderList) {
    return SegmentWelderModel(
      id: json['id'] ?? "",
      name: json['weld_qualification'] ?? "",
      welderList: welderList,
      welderData: WelderModel(),
      multipleWelderData: [],
    );
  }

  List<Map<String, dynamic>> toJsonList() {
    // MULTIPLE selection
    if (multipleWelderData != null && multipleWelderData!.isNotEmpty) {
      return multipleWelderData!.map((welder) {
        return {
          'weld_qual': id,
          'weld_id': welder.id?.toString() ?? "0",
        };
      }).toList();
    }

    // SINGLE selection fallback
    return [
      {
        'weld_qual': id,
        'weld_id': welderData?.id?.toString() ?? "0",
      }
    ];
  }
}

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['weld_qual'] = id;
  //   data['weld_id'] = welderData!.id != null ? welderData!.id.toString() : "0";
  //   return data;
  // }
//}
