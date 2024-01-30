import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_status_model.dart';

List<SegmentModel> segmentListResponse(var json) {
  return List<SegmentModel>.from(json.map((x) => SegmentModel.fromJson(x)));
}

class SegmentModel {

  dynamic id;
  String? name;
  List<SegmentStatusModel>? segmentStatusList;

  SegmentModel({this.id, this.name, this.segmentStatusList});

  factory SegmentModel.fromJson(Map<String, dynamic> json) {
    return SegmentModel(

    );
  }

  getSegment() {
    List<SegmentModel> segmentList = [];
    List<SegmentStatusModel> segmentStatusList1 = [];
    segmentStatusList1.add(SegmentStatusModel(
        id: "1",
        status: "R/S"
    ));
    segmentStatusList1.add(SegmentStatusModel(
        id: "2",
        status: "Accept"
    ));
     segmentList.add(SegmentModel(
       id: "1",
       name: "Segment1",
       segmentStatusList: segmentStatusList1
     ));


    List<SegmentStatusModel> segmentStatusList2 = [];
    segmentStatusList2.add(SegmentStatusModel(
        id: "3",
        status: "Retake"
    ));
    segmentStatusList2.add(SegmentStatusModel(
        id: "3",
        status: "RNA"
    ));
    segmentList.add(SegmentModel(
        id: "1",
        name: "Segment1",
        segmentStatusList: segmentStatusList2
    ));

    return ;
  }
}