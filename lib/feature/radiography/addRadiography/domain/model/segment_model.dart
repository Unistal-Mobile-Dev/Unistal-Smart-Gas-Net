import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_status_model.dart';

List<SegmentModel> segmentListResponse(var json) {
  return List<SegmentModel>.from(json.map((x) => SegmentModel.fromJson(x)));
}

class SegmentModel {

  dynamic id;
  String? name;
  String? observation;
  List<SegmentStatusModel>? segmentStatusList;
  TextEditingController? observationController;

  SegmentModel({this.id, this.name, this.segmentStatusList, this.observation, this.observationController});

  factory SegmentModel.fromJson(Map<String, dynamic> json) {
    return SegmentModel(
      id :  "",
      name :  "",
      observationController: TextEditingController(),
      observation: "Observation",
      segmentStatusList: json [""] != null ? segmentStatusListResponse(json) : [],
    );
  }

  getSegment() {
    List<SegmentModel> segmentList = [];
    List<SegmentStatusModel> segmentStatusList1 = [];
    segmentStatusList1.add(SegmentStatusModel(
        id: "1",
        status: "R/S",
        selectedValue: ""
    ));
    segmentStatusList1.add(SegmentStatusModel(
        id: "2",
        status: "Accept",
        selectedValue: ""
    ));
     segmentList.add(SegmentModel(
       id: "1",
       name: "Segment 1",
       observation: "Observation 1",
       observationController: TextEditingController(),
       segmentStatusList: segmentStatusList1
     ));


    List<SegmentStatusModel> segmentStatusList2 = [];
    segmentStatusList2.add(SegmentStatusModel(
        id: "3",
        status: "Retake",
        selectedValue: ""
    ));
    segmentStatusList2.add(SegmentStatusModel(
        id: "4",
        status: "RNA",
        selectedValue: ""
    ));
    segmentList.add(SegmentModel(
        id: "2",
        name: "Segment 2",
        observation: "Observation 2",
        observationController: TextEditingController(),
        segmentStatusList: segmentStatusList2
    ));


    List<SegmentStatusModel> segmentStatusList3 = [];
    segmentStatusList3.add(SegmentStatusModel(
        id: "5",
        status: "CRS",
        selectedValue: ""
    ));
    segmentStatusList3.add(SegmentStatusModel(
        id: "6",
        status: "RECAP",
        selectedValue: ""
    ));
    segmentList.add(SegmentModel(
        id: "3",
        name: "Segment 3",
        observation: "Observation 3",
        observationController: TextEditingController(),
        segmentStatusList: segmentStatusList3
    ));
    return segmentList;
  }
}