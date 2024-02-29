import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/domain/model/file_model.dart';

List<TestModel> testListResponse(var json) {
  return List<TestModel>.from(json.map((x) => TestModel.fromJson(x)));
}

class TestModel {

  String? keyword;
  String? label;
  String? type;
  bool? required;
  String? inputType;
  Widget? child;
  TextEditingController? controller;
  dynamic value;
  List<dynamic>? selectedValue;
  List<TestListModel>? list;
  FileModel? fileData;
  String? api;

  TestModel(
      {this.keyword,
        this.label,
        this.type,
        this.required,
        this.inputType,
        this.value,
        this.child,
        this.controller,
        this.list,
        this.selectedValue,
        this.api,
      });

  TestModel.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    label = json['label'];
    type = json['type'];
    required = json['required'];
    inputType = json['inputType'];
    api = json['api'] ?? "";
    value = "";
    child =  const SizedBox.shrink();
    controller =  TextEditingController();
    fileData =  FileModel();
    selectedValue = [];
    list = json['list'] != null ? testListModelResponse(json['list']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword'] = keyword;
    data['label'] = label;
    data['type'] = type;
    data['required'] = required;
    data['inputType'] = inputType;
    data['value'] = value;
    return data;
  }
}

List<TestListModel> testListModelResponse(var json) {
  return List<TestListModel>.from(json.map((x) => TestListModel.fromJson(x)));
}

class TestListModel {
  dynamic id;
  dynamic name;
  dynamic value;
  bool? isSelected;

  TestListModel({this.name, this.value, this.isSelected});

  TestListModel.fromJson(Map<String, dynamic> json) {
    id =  json['id']  ?? "";
    name = json['name'] ?? "";
    value = json['value'] ?? "";
    isSelected =  false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}