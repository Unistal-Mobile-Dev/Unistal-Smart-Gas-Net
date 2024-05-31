List<JointNumberModel> jointNumberListResponse(var json) {
  return List<JointNumberModel>.from(
      json.map((x) => JointNumberModel.fromJson(x)));
}

class JointNumberModel {
  String? id;
  String? jointNumber;

  JointNumberModel({this.id, this.jointNumber});

  JointNumberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    jointNumber = json['joint_number'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['joint_number'] = this.jointNumber;
    return data;
  }
}
