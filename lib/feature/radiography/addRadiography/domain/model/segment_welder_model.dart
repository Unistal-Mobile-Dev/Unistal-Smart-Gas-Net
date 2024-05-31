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
  WelderModel? welderData;

  SegmentWelderModel({this.welderData, this.welderList, this.id, this.name});

  factory SegmentWelderModel.fromJson(
      Map<String, dynamic> json, List<WelderModel> welderList) {
    return SegmentWelderModel(
      id: json['id'] ?? "",
      name: json['weld_qualification'] ?? "",
      welderList: welderList,
      welderData: WelderModel(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weld_qual'] = id;
    data['weld_id'] = welderData!.id != null ? welderData!.id.toString() : "0";
    return data;
  }
}
