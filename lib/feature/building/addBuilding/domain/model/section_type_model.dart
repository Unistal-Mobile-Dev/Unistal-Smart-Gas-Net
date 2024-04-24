List<SectionTypeModel> sectionTypeListResponse(var json) {
  return List<SectionTypeModel>.from(json.map((x) => SectionTypeModel.fromJson(x)));
}

class SectionTypeModel {
  String? id;
  String? sectionName;

  SectionTypeModel({this.id, this.sectionName});

  SectionTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    sectionName = json['section_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_name'] = sectionName;
    return data;
  }
}