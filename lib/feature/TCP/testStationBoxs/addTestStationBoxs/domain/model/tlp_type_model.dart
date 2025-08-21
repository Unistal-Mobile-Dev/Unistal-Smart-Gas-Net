List<TlpTypeModel> tlpTypeResList(var json) {
  return List<TlpTypeModel>.from(json.map((x) => TlpTypeModel.fromJson(x)));
}

class TlpTypeModel {
  String? id;
  String? name;

  TlpTypeModel({this.id, this.name});

  TlpTypeModel.fromJson(Map<String, dynamic> json) {
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
