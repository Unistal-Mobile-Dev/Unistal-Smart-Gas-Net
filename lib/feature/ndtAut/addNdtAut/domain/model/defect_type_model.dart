List<DefectTypeModel> defectTypeListResponse(var json) {
  return List<DefectTypeModel>.from(
      json.map((x) => DefectTypeModel.fromJson(x)));
}

class DefectTypeModel {
  String? id;
  String? name;

  DefectTypeModel({this.id, this.name});

  DefectTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
