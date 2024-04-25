List<RoadTypeModel> roadTypeListResponse(var json) {
  return List<RoadTypeModel>.from(json.map((x) => RoadTypeModel.fromJson(x)));
}

class RoadTypeModel {
  dynamic id;
  String? name;

  RoadTypeModel({this.id, this.name});

  RoadTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}