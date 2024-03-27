List<BendingTypeModel> bendingTypeListResponse(var json) {
  return List<BendingTypeModel>.from(json.map((x) => BendingTypeModel.fromJson(x)));
}

class BendingTypeModel {
  String? id;
  String? name;

  BendingTypeModel({this.id, this.name});

  BendingTypeModel.fromJson(Map<String, dynamic> json) {
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