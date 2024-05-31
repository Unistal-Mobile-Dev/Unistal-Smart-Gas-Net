import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';

List<SegmentModel> segmentListResponse(var json, List<WelderModel> welderList) {
  return List<SegmentModel>.from(
      json.map((x) => SegmentModel.fromJson(x, welderList)));
}

class SegmentModel {
  dynamic id;
  String? name;
  String? observation;
  String? remark;
  List<SegmentStatusModel>? segmentStatusList;
  TextEditingController? observationController;
  TextEditingController? remarkController;
  List<SegmentWelderModel>? segmentWelderList;

  String? rootType;
  List<WelderModel>? rootWelderList;
  WelderModel? rootWelderData;
  String? hootPassType;
  List<WelderModel>? hootPassWelderList;
  WelderModel? hootPassWelderData;
  String? fillerType;
  List<WelderModel>? fillerWelderList;
  WelderModel? fillerWelderData;
  String? cappingType;
  List<WelderModel>? cappingWelderList;
  WelderModel? cappingWelderData;

  SegmentModel({
    this.id,
    this.name,
    this.segmentStatusList,
    this.observation,
    this.remark,
    this.observationController,
    this.remarkController,
    this.cappingType,
    this.cappingWelderData,
    this.cappingWelderList,
    this.fillerType,
    this.fillerWelderData,
    this.fillerWelderList,
    this.hootPassType,
    this.hootPassWelderData,
    this.hootPassWelderList,
    this.rootType,
    this.rootWelderData,
    this.rootWelderList,
    this.segmentWelderList,
  });

  factory SegmentModel.fromJson(
      Map<String, dynamic> json, List<WelderModel> welderList) {
    int id = 1;
    return SegmentModel(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        observationController: TextEditingController(),
        remarkController: TextEditingController(),
        observation: "Observation",
        remark: "Remark",
        segmentStatusList: json['status'] != null
            ? getSegmentStatusData(json['status'], id)
            : [],
        segmentWelderList: json['weld'] != null
            ? segmentWelderListResponse(json['weld'], welderList)
            : []);
  }

  static dynamic getSegmentStatusData(Map segmentStatusData, int id) {
    List<SegmentStatusModel> segmentStatusList = [];
    Map myMap = segmentStatusData;
    myMap.forEach((key, value) {
      segmentStatusList.add(SegmentStatusModel(
          id: key, status: value, selectedValue: "", groupType: id));
      id++;
    });
    return segmentStatusList;
  }

  dynamic toJson() {
    List<dynamic> segmentStatusDataList = [];
    for (var status in segmentStatusList!) {
      if (status.selectedValue.toString().isNotEmpty) {
        segmentStatusDataList.add(status.id.toString());
      }
    }
    var data;
    if (segmentStatusDataList.isNotEmpty) {
      var json = {
        "segment_id": id.toString(),
        "observation": observationController!.text.toString(),
        "status": segmentStatusDataList.isNotEmpty
            ? segmentStatusDataList
                .toString()
                .replaceAll("[", "")
                .toString()
                .replaceAll("]", "")
            : "0",
        "remarks": remarkController!.text.toString(),
        "weld_details": segmentWelderList!.map((v) => v.toJson()).toList(),
      };
      return json;

/*      data['segment_id'] = id;
      data['observation'] = observationController!.text.toString();
      data['status'] = segmentStatusDataList.isNotEmpty ? segmentStatusDataList.toString().replaceAll("[", "").toString().replaceAll("]", "") : "0";
      data['remarks'] = remarkController!.text.toString();
      data['weld_details'] = segmentWelderList!.map((v) => v.toJson()).toList();*/
    }
    return "";
  }
}
