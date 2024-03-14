List<PipeDiaModel> pipeDiaListResponse(var json) {
  return List<PipeDiaModel>.from(json.map((x) => PipeDiaModel.fromJson(x)));
}

class PipeDiaModel {
  String? id;
  dynamic name;
  String? value;

  PipeDiaModel({this.id, this.name, this.value});

  PipeDiaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    value = json['value'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}