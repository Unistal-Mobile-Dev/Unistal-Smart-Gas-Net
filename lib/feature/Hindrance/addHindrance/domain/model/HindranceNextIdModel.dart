class HindranceNextIdModel {
  int? status;
  String? nextId;

  HindranceNextIdModel({this.status, this.nextId});

  HindranceNextIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    nextId = json['next_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['next_id'] = nextId;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return nextId.toString();
  }
}
