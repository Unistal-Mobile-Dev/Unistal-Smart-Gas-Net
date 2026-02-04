List<MarkerTypeModel> markerTypeListResponse(var json) {
  return List<MarkerTypeModel>.from(json.map((x) => MarkerTypeModel.fromJson(x)));
}

class MarkerTypeModel {
  String? id;
  String? name;

  MarkerTypeModel({this.id, this.name});

  MarkerTypeModel.fromJson(Map<String, dynamic> json) {
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
