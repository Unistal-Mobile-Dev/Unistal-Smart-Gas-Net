List<ObstructionTypeModel> obstructionTypeListResponse(var json) {
  return List<ObstructionTypeModel>.from(json.map((x) => ObstructionTypeModel.fromJson(x)));
}

class ObstructionTypeModel {
  dynamic id;
  String? name;

  ObstructionTypeModel({this.id, this.name});

  ObstructionTypeModel.fromJson(Map<String, dynamic> json) {
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