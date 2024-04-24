import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/singleton.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class APIs {


  static BuildContext? context =  Singleton.instanceInit()?.context;

  static final String baseUrl =
      EnvironmentConfig.of(context!)!.generalUrlBaseOnFlavour;

  static get login => "api/auth";
  static get getAlignmentSheetApi => "api/steel/get-alignment-sheet";
  static get addRouteSurveyApi => "api/steel/rousurveyinsert";
  static get addCGinsertApi => "api/steel/cginsert";
  static get addSoilResistivityinsertApi => "api/steel/soilresistivityinsert";
  static get addRouHandoverinsertApi => "api/steel/rouhandoverinsert";
  static get trenchinginsertApi => "api/steel/trenchinginsert";
  static get getConcreteCoatingApi => "api/steel/get-concrete-coating";
  static get getPipeDetailApi => "api/steel/get-pipe-details";
  static get addStringingApi => "api/steel/stringinginsert";
  static get getBendingTypeApi => "api/steel/get-bend-type";
  static get getVisualChecksApi => "api/steel/get-visual-checks";
  static get getHolidayChecksApi => "api/steel/get-holiday-checks";
  static get addBendinginsertApi => "api/steel/bendinginsert";
  static get getWelderApi => "api/steel/get-welder";
  static get getWPSApi => "api/steel/get-wps";
  static get getJointTypeApi => "api/steel/get-joint-type";
  static get getJointNumberApi => "api/steel/get-joints-chainage";
  static get getJointNumberWithTypeApi => "api/steel/get-joint-by-type";
  static get addWeldingApi => "api/steel/weldinginsert";
  static get getPaddingCheckApi => "api/steel/get-padding-checks";
  static get addBackFillingApi => "api/steel/backfillinginsert";
  static get addLoweringApi => "api/steel/loweringinsert";
  static get addHDPEDuctApi => "api/steel/hdpeductinsert";
  static get addOfcSpliceApi => "api/steel/ofcspliceinsert";
  static get addRestorationApi => "api/steel/restorationinsert";
  static get addLevellingApi => "api/steel/levellinginsert";
  static get addDryingApi => "api/steel/dryinginsert";
  static get addRadiographyApi => "api/steel/ndtrtinsert";
  static get addNdtMutApi => "api/steel/ndtmutinsert";
  static get getSegmentApi => "api/steel/get-segments";
  static get getLptStatusApi => "api/steel/lptstatus";
  static get addLptApi => "api/steel/lptinsert";
  static get addCutePipeApi => "api/steel/cut-pipe";
  static get getCutePipeApi => "api/steel/cut-pipes";
  static get updateCutePipeApi => "api/steel/cut-pipe/restore/";
  static get getPipeThicknessApi => "api/steel/get-pipe-thickness";
  static get addConcreteCoatingApi => "api/steel/concrete-coating";
  static get addPostHydroTestApi => "api/steel/post-hydrotest";
  static get addPreHydroTestApi => "api/steel/prehydrotestinsert";
  static get addHydroTestApi => "api/steel/hydrotest";
  static get addHDPEDuctTestingApi => "api/steel/hdpe-duct-testing";
  static get AddSwabbingApi => "api/steel/swabbing";
  static get getWelderRepairStatusApi => "api/steel/wp-status";
  static get addWeldRepairApi => "api/steel/weld-repair";
  static get getAutStatusApi => "api/steel/autstatus";
  static get getDefectTypeApi => "api/steel/defecttype";
  static get getDefectLayerApi => "api/steel/defectlayer";
  static get addNdtAutApi => "api/steel/ndtaut";
  static get getWeatherApi => "api/steel/weather";
  static get getTerrianApi => "api/steel/terrian";
  static get getGroundTypeApi => "api/steel/groundtype";
  static get getPipeDiaApi => "api/steel/get-pipe-dia";
  static get addJointCoatingApi => "api/steel/jointcoatinginsert";
  static get getPipeTypeApi => "api/steel/get-pipe-type";
  static get getCoatingTypeApi => "api/steel/get-coating-type";
  static get getPipeMaterialApi => "api/steel/get-pipe-material";
  static get getCrossingTypeApi => "api/steel/crossing-type";
  static get addCrossingApi => "api/steel/crossinginsert";
  static get getNdtStatusApi => "api/steel/ndtstatus";
  static get getNdtSourceApi => "api/steel/ndtsource";
  static get addTieInApi => "api/steel/tieininsert";
  static get addBuildingApi => "api/steel-building/save";
  static get getSpreadTypeApi => "api/steel-building/spreads";
  static get getSectionTypeApi => "api/steel-building/sections";
  static get getBuildingCategoryTypeApi => "api/steel-building/categories";
  static get addObstructionPointApi => "api/steel-building/obstruction-point";
  static get addRightWayApi => "api/steel-building/right-way";


  static get productTypeApi => "admin/rest/getItemType";
  static get productApi => "admin/rest/getItem";
  static get stateApi => "admin/rest/getState";
  static get categoryApi => "admin/rest/getCategory";
  static get addComplaint => "admin/rest/add_complain";
  static get forgotPasswordApi => "";
}