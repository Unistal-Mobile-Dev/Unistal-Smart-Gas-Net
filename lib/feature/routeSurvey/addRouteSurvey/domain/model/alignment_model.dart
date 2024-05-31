List<AlignmentModel> alignmentResponseList(var json) {
  return List<AlignmentModel>.from(json.map((x) => AlignmentModel.fromJson(x)));
}

class AlignmentModel {
  String? id;
  String? alignmentName;
  String? chainageFrom;
  String? chainageTo;

  AlignmentModel(
      {this.id, this.alignmentName, this.chainageFrom, this.chainageTo});

  AlignmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alignmentName = json['alignment_name'];
    chainageFrom = json['chainage_from'];
    chainageTo = json['chainage_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = alignmentName;
    data['value'] = "";
    return data;
  }
}
