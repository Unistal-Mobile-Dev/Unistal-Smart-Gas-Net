List<PipeModel> pipeResponseList(var json) {
  return List<PipeModel>.from(json.map((x) => PipeModel.fromJson(x)));
}

class PipeModel {
  String? id;
  String? pipeNumber;

  PipeModel({this.id, this.pipeNumber});

  PipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    pipeNumber = json['pipe_number'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pipe_number'] = this.pipeNumber;
    return data;
  }
}