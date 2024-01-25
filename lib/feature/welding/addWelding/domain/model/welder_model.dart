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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['welder_name'] = this.welderName;
    return data;
  }
}