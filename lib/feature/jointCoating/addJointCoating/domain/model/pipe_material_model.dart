List<PipeMaterialModel> pipeMaterialListResponse(var json) {
  return List<PipeMaterialModel>.from(
      json.map((x) => PipeMaterialModel.fromJson(x)));
}

class PipeMaterialModel {
  String? id;
  String? name;

  PipeMaterialModel({this.id, this.name});

  PipeMaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
