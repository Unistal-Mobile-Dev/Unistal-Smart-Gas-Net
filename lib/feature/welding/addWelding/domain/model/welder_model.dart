List<WelderModel> welderListResponse(var json) {
  return List<WelderModel>.from(json.map((x) => WelderModel.fromJson(x)));
}

class WelderModel {
  String? id;
  String? welderName;

  WelderModel({this.id, this.welderName});

  WelderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ??  "";
    welderName = json['welder_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['welder_name'] = welderName;
    return data;
  }
}