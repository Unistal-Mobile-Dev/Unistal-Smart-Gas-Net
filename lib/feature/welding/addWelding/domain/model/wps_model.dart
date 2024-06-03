List<WPSModel> wpsListResponse(var json) {
  return List<WPSModel>.from(json.map((x) => WPSModel.fromJson(x)));
}

class WPSModel {
  String? id;
  String? wps;

  WPSModel({this.id, this.wps});

  WPSModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wps = json['wps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wps'] = wps;
    return data;
  }
}
