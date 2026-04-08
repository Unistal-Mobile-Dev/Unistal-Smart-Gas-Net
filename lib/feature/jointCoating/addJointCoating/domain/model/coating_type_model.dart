List<CoatingTypeModel> coatingTypeListResponse(var json) {
  return List<CoatingTypeModel>.from(
      json.map((x) => CoatingTypeModel.fromJson(x)));
}

class CoatingTypeModel {
  String? id;
  String? name;

  CoatingTypeModel({this.id, this.name});

  CoatingTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
