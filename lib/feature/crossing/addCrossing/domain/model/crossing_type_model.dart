List<CrossingTypeModel> crossingTypeListResponse(var json) {
  return List<CrossingTypeModel>.from(json.map((x) => CrossingTypeModel.fromJson(x)));
}

class CrossingTypeModel {
  String? id;
  String? name;

  CrossingTypeModel({this.id, this.name});

  CrossingTypeModel.fromJson(Map<String, dynamic> json) {
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