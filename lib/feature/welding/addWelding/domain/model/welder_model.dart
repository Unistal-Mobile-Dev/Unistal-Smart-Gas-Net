List<WelderModel> welderListResponse(var json) {
  return List<WelderModel>.from(json.map((x) => WelderModel.fromJson(x)));
}

class WelderModel {
  String? id;
  String? welderName;
  String? welderNumber;

  WelderModel({this.id, this.welderName, this.welderNumber});

  WelderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    welderName = json['welder_name'] ?? "";
    welderNumber = json['welder_number'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['welder_name'] = welderName;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "${welderName.toString()} (${welderNumber.toString()})".toString();
  }
}
