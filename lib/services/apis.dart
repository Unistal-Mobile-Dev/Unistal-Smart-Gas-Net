import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/singleton.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class APIs {


  static BuildContext? context =  Singleton.instanceInit()?.context;

  static final String baseUrl =
      EnvironmentConfig.of(context!)!.generalUrlBaseOnFlavour;

  static get login => "api/auth";
  static get getAlignmentSheetApi => "api/get-alignment-sheet";
  static get addRouteSurveyApi => "api/rousurveyinsert";
  static get addCGinsertApi => "api/cginsert";
  static get addSoilResistivityinsertApi => "api/soilresistivityinsert";
  static get addRouHandoverinsertApi => "api/rouhandoverinsert";
  static get trenchinginsertApi => "api/trenchinginsert";
  static get getConcreteCoatingApi => "api/get-concrete-coating";
  static get getPipeDetailApi => "api/get-pipe-details";
  static get addStringingApi => "api/stringinginsert";
  static get getBendingTypeApi => "api/get-bend-type";
  static get getVisualChecksApi => "api/get-visual-checks";
  static get getHolidayChecksApi => "api/get-holiday-checks";
  static get addBendinginsertApi => "api/bendinginsert";
  static get getWelderApi => "api/get-welder";
  static get getWPSApi => "api/get-wps";
  static get getJointTypeApi => "api/get-joint-type";
  static get getJointNumberApi => "api/get-joints-chainage";
  static get getJointNumberWithTypeApi => "api/get-joint-by-type";
  static get addWeldingApi => "api/weldinginsert";
  static get getPaddingCheckApi => "api/get-padding-checks";
  static get addBackFillingApi => "api/backfillinginsert";
  static get addLoweringApi => "api/loweringinsert";




  static get productTypeApi => "admin/rest/getItemType";
  static get productApi => "admin/rest/getItem";
  static get stateApi => "admin/rest/getState";
  static get categoryApi => "admin/rest/getCategory";
  static get addComplaint => "admin/rest/add_complain";
  static get forgotPasswordApi => "";
}