List<ElectrodeBatchData> electrodeBatchListResponse(var json) {
  return List<ElectrodeBatchData>.from(json.map((x) => ElectrodeBatchData.fromJson(x)));
}

class ElectrodeBatchModel {
  int? success;
  bool? error;
  List<ElectrodeBatchData>? data;

  ElectrodeBatchModel({this.success, this.error, this.data});

  ElectrodeBatchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ElectrodeBatchData>[];
      json['data'].forEach((v) {
        data!.add(new ElectrodeBatchData.fromJson(v));
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

class ElectrodeBatchData {
  String? diaValue;
  String? batchNo;

  ElectrodeBatchData({this.diaValue, this.batchNo});

  ElectrodeBatchData.fromJson(Map<String, dynamic> json) {
    diaValue = json['dia_value'];
    batchNo = json['batch_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dia_value'] = this.diaValue;
    data['batch_no'] = this.batchNo;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return batchNo.toString();
  }
}
