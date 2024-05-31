List<GroundTypeModel> groundTypeListResponse(var json) {
  return List<GroundTypeModel>.from(
      json.map((x) => GroundTypeModel.fromJson(x)));
}

class GroundTypeModel {
  String? id;
  String? name;

  GroundTypeModel({this.id, this.name});

  GroundTypeModel.fromJson(Map<String, dynamic> json) {
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
