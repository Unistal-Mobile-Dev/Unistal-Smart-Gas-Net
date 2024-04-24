List<BuildingTypeModel> buildingTypeListResponse(var json) {
  return List<BuildingTypeModel>.from(json.map((x) => BuildingTypeModel.fromJson(x)));
}

class BuildingTypeModel {
  int? id;
  String? name;

  BuildingTypeModel({this.id, this.name});

  BuildingTypeModel.fromJson(Map<String, dynamic> json) {
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