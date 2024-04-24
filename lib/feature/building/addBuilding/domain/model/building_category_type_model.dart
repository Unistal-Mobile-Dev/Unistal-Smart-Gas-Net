List<BuildingCategoryTypeModel> buildingCategoryListResponse(var json) {
  return List<BuildingCategoryTypeModel>.from(json.map((x) => BuildingCategoryTypeModel.fromJson(x)));
}

class BuildingCategoryTypeModel {
  int? id;
  String? name;

  BuildingCategoryTypeModel({this.id, this.name});

  BuildingCategoryTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}