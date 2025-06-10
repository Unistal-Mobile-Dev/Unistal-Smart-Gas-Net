List<ElectrodeDiaData> electrodeDiaListResponse(var json) {
  return List<ElectrodeDiaData>.from(json.map((x) => ElectrodeDiaData.fromJson(x)));
}

class ElectrodeDiaModel {
  int? success;
  bool? error;
  List<ElectrodeDiaData>? data;

  ElectrodeDiaModel({this.success, this.error, this.data});

  ElectrodeDiaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ElectrodeDiaData>[];
      json['data'].forEach((v) {
        data!.add(new ElectrodeDiaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ElectrodeDiaData {
  String? diaValue;
  String? batchNumbers;

  ElectrodeDiaData({this.diaValue, this.batchNumbers});

  ElectrodeDiaData.fromJson(Map<String, dynamic> json) {
    diaValue = json['dia_value'];
    batchNumbers = json['batch_numbers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dia_value'] = this.diaValue;
    data['batch_numbers'] = this.batchNumbers;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return diaValue.toString();
  }
}
