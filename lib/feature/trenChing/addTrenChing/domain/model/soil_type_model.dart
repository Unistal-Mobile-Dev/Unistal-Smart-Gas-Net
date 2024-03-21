List<SoilTypeModel> soilTypeListResponse(var json) {
  return List<SoilTypeModel>.from(json.map((x) => SoilTypeModel.fromJson(x)));
}

class SoilTypeModel {

  dynamic id;
  String? name;

  SoilTypeModel({this.id, this.name});

  factory SoilTypeModel.fromJson(Map<String, dynamic> json) {
    return SoilTypeModel(
       id: json['id'] ?? "",
       name:  json['name'] ?? "",
    );
  }
}