List<ThicknessModel> thicknessListResponse(var json) {
  return List<ThicknessModel>.from(json.map((x) => ThicknessModel.fromJson(x)));
}

class ThicknessModel {
  String? id;
  dynamic name;
  String? value;

  ThicknessModel({this.id, this.name, this.value});

  ThicknessModel.fromJson(Map<String, dynamic> json) {
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
  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
