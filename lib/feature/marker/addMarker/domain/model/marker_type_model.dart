List<MarkerTypeModel> markerListResponse(var json) {
  return List<MarkerTypeModel>.from(json.map((x) => MarkerTypeModel.fromJson(x)));
}

class MarkerTypeModel {

  dynamic id;
  String? name;

  MarkerTypeModel({this.name, this.id});

  factory MarkerTypeModel.fromJson(Map<String, dynamic> json) {
    return MarkerTypeModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
    );
  }
}