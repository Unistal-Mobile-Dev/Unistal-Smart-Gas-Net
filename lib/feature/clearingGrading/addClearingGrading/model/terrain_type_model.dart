List<TerrainTypeModel> terrainListResponse(var json) {
  return List<TerrainTypeModel>.from(
      json.map((x) => TerrainTypeModel.fromJson(x)));
}

class TerrainTypeModel {
  String? id;
  String? name;

  TerrainTypeModel({this.id, this.name});

  TerrainTypeModel.fromJson(Map<String, dynamic> json) {
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
