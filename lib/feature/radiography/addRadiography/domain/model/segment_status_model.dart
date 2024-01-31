List<SegmentStatusModel> segmentStatusListResponse(var json) {
  return List<SegmentStatusModel>.from(json.map((x) =>  SegmentStatusModel.fromJson(x)));
}

class SegmentStatusModel {
  dynamic id;
  String? status;
  String? selectedValue;
  SegmentStatusModel({this.id, this.status, this.selectedValue});

  factory SegmentStatusModel.fromJson(Map<String, dynamic> json) {
    return SegmentStatusModel();
  }
}