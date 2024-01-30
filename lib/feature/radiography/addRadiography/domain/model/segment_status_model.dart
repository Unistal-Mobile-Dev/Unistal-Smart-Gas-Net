List<SegmentStatusModel> segmentStatusListResponse(var json) {
  return List<SegmentStatusModel>.from(json.map((x) =>  SegmentStatusModel.fromJson(x)));
}

class SegmentStatusModel {
  dynamic id;
  String? status;
  SegmentStatusModel({this.id, this.status});

  factory SegmentStatusModel.fromJson(Map<String, dynamic> json) {
    return SegmentStatusModel(

    );
  }

  getStatus() {
    List<SegmentStatusModel> segmentStatusList = [];
    segmentStatusList.add(SegmentStatusModel(
      id: "1",
      status: "R/S"
    ));
    segmentStatusList.add(SegmentStatusModel(
        id: "2",
        status: "Accept"
    ));
    segmentStatusList.add(SegmentStatusModel(
        id: "3",
        status: "Retake"
    ));
    segmentStatusList.add(SegmentStatusModel(
        id: "4",
        status: "RNA"
    ));
    segmentStatusList.add(SegmentStatusModel(
        id: "5",
        status: "CRS"
    ));
    segmentStatusList.add(SegmentStatusModel(
        id: "6",
        status: "RECAP"
    ));
    return;
  }

}