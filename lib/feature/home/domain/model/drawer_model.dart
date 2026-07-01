import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ActivitySectionModel.dart';

class DrawerModel {
  Widget widget;
  String label;
  IconData icon;
  List<DrawerSubModel> sublist;
  bool isSelected;
  Widget? actionButtonWidget;
  bool isRoot;
  bool? isSublistLoader = false;

  DrawerModel(
      {required this.widget,
      required this.icon,
      required this.label,
      required this.sublist,
      required this.isSelected,
      this.isSublistLoader,
      this.isRoot= false,
      this.actionButtonWidget});
}

class DrawerSubModel {
  String? label;
  bool? isSelected;
  Widget widget;
  Widget? actionButtonWidget;
  ActivitySectionData activityData;

  DrawerSubModel(
      {this.label, this.isSelected, required this.widget, this.actionButtonWidget, required  this.activityData,});
}


/// ===================== DRAWER MODEL =====================

class DrawerDemoModel {
  final Widget widget;
  final IconData icon;
  final String label;
  final List<DrawerSubDemoModel> sublist;
  bool isSelected;
  bool isRoot;

  DrawerDemoModel({
    required this.widget,
    required this.icon,
    required this.label,
    required this.sublist,
    this.isSelected = false,
    this.isRoot = false,
  });
}

class DrawerSubDemoModel {
  final String label;
  final Widget widget;
  bool isSelected;

  DrawerSubDemoModel({
    required this.label,
    required this.widget,
    this.isSelected = false,
  });
}