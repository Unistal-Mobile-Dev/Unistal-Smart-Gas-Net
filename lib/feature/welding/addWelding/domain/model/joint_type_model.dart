List<JointTypeModel> jointTypeListResponse(var json) {
  return List<JointTypeModel>.from(json.map((x) => JointTypeModel.fromJson(x)));
}

class JointTypeModel {
  String? id;
  String? name;

  JointTypeModel({this.id, this.name});

  JointTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
