List<PipeTypeModel> pipeTypeListResponse(var json) {
  return List<PipeTypeModel>.from(json.map((x) => PipeTypeModel.fromJson(x)));
}

class PipeTypeModel {
  String? id;
  String? name;

  PipeTypeModel({this.id, this.name});

  PipeTypeModel.fromJson(Map<String, dynamic> json) {
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