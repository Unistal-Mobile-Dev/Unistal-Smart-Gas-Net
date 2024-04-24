List<SpreadTypeModel> spreadListResponse(var json) {
  return List<SpreadTypeModel>.from(json.map((x) => SpreadTypeModel.fromJson(x)));
}

class SpreadTypeModel {
  String? id;
  String? spreadName;

  SpreadTypeModel({this.id, this.spreadName});

  SpreadTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    spreadName = json['spread_name'] ?? "" ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['spread_name'] = spreadName;
    return data;
  }
}