List<PipeModel> pipeResponseList(var json) {
  return List<PipeModel>.from(json.map((x) => PipeModel.fromJson(x)));
}

class PipeModel {
  String? id;
  String? pipeNumber;
  dynamic heatNumber;
  dynamic pipeLength;
  bool? isSelected;

  PipeModel({this.id, this.pipeNumber});

  PipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    pipeNumber = json['pipe_number'] ?? "";
    pipeLength = json['pipe_length'] ?? "0.0";
    heatNumber = json['heat_number'] ?? "";
    isSelected =  false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['pipe_number'] = pipeNumber;
    data['pipe_length'] = pipeLength;
    data['heat_number'] = heatNumber;
    return data;
  }
}