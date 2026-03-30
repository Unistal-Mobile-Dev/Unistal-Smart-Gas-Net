List<HindranceCategoryData> hindranceCategoryList(var json) {
  return List<HindranceCategoryData>.from(json.map((x) => HindranceCategoryData.fromJson(x)));
}

class HindranceCategoryData {
  dynamic id;
  String? name;

  HindranceCategoryData({this.id, this.name});

  HindranceCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
