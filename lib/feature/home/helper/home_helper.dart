import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/presentation/page/add_concrete_coating_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/presentation/page/add_crossing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeDutTesting/addHDPEDuctTesting/presentation/page/add_hdpe_duct_testing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/persentation/page/add_hdpe_duct_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/presentation/page/add_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/presentation/page/add_joint_coating_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/levelling/addLevelling/presentation/page/add_levelling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/presentation/page/add_lowering_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/presentation/page/add_lpt_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/presentation/pages/add_marker_installation_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/presentation/page/add_ndt_aut_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/persentation/page/add_ndt_mut_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcBlowing/addOFCBlowing/presentation/page/add_ofc_blowing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/persentation/page/add_ofc_splicing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/preHydrotest/addPreHydrotest/presentation/page/add_pre_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/persentation/page/add_radiography_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/presentation/page/add_restoration_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/presentation/page/add_soil_resistivity_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/presentation/page/add_welder_repair_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_update_message_widget.dart';

/* ===================== MAINLINE ===================== */
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/presentation/page/route_survey_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/presentation/page/add_rou_handover_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/presentation/page/add_clearing_grading_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/presentation/page/add_tren_ching_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/presentation/page/add_stringing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/presentation/page/add_bending_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/presentation/page/add_welding_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/page/add_back_filling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/tieIn/addTiein/presentation/page/add_tiein_page.dart';

/* ===================== TCP ===================== */
import 'package:flutter_unistal_smart_gas_net/feature/TCP/pinBrazzing/addPinBrazzing/presentation/pages/add_pin_brazzing.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/cableInstallation/addCableInstallation/presentation/pages/add_cable_installation_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/znGroundingAnode/addZnGroundingAnode/presentation/pages/add_zn_grounding_anode_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/presentation/pages/test_station_box_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/thermitWeld/addThermitWeld/presentation/pages/add_thermit_weld_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/surgeDiverter/addSurgeDiverter/presentation/pages/add_surge_diverter_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/ssd/addSSD/presentation/pages/add_ssd_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/polarisationCoupan/addPolarisationCoupan/presentation/pages/add_polarisation_coupan_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/sacrificialAnode/addSacrificialAnode/presentation/pages/add_sacrificial_anode_page.dart';

/* ===================== HDD ===================== */
import 'package:flutter_unistal_smart_gas_net/feature/HDD/pilotDrill/addPilotDrill/presentation/pages/add_pilot_drill_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddReaming/addHDDReaming/presentation/pages/add_hdd_reaming_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddCleanPass/addHDDCleanPass/presentation/pages/add_hdd_clean_pass_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddPulling/addHDDPulling/presentation/pages/add_hdd_pulling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddCrossing/addHDDCrossing/presentation/pages/add_hdd_crossing_page.dart';

class HomeHelper {
  /* ===================== API ===================== */

  static Future<List<ActivitySectionData>?> activityBySectionApi({
    required LoginDataModel userData,
  }) async {
    try {
      String url = APIs.activityBySection;
      Map<String, String> para = {
        "schema": "${userData.schema}",
        "userid": "${userData.userId}",
        "section_id":"${ userData.sectionId} "
      };

      String json = Uri(queryParameters: para).query;
      var res = await ServerRequest.getData(urlEndPoint: url + json);

      if (res != null && res['success'] == 200 && res['data'] != null) {
        final list = (res['data'] as List)
            .map((e) => ActivitySectionData.fromJson(e))
            .toList();

        AppConfig.instanceInit()
            ?.setListActivityData(newListOfActivitySection: list);
        return list;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /* ===================== DRAWER ===================== */

  static Future<List<DrawerModel>?> fetchDrawerList({
    required BuildContext context,
  }) async {
    try {
      final drawerList = <DrawerModel>[];
      final activities = AppConfig.instanceInit()?.listOfActivitySection ?? [];

      final activeActivities = activities.where((e) => e.status == "1").toList();

      drawerList.add(
        DrawerModel(
          widget: const DashboardPage(),
          icon: Icons.home_outlined,
          label: AppString.dashboard,
          sublist: [],
          isSelected: true,
        ),
      );

      final mainlineSubItems = <DrawerSubModel>[];
      final tcpSubItems = <DrawerSubModel>[];
      final hddSubItems = <DrawerSubModel>[];

      const mainlineModels = [
        "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",
        "16","17","18","19","20","21","22","23","24","25","26","27","30",
        "32","33","52","56","59","60","61",
      ];

      const tcpModels = [
        "28","29","31","40","41","42","43","44","45","46","54","66","68","75","76",
      ];

      const hddModels = [
        "34","35","36","37","38","39","57","73",
      ];

      for (final item in activeActivities) {
        final model = item.activityId?.toString() ?? "";

        if (mainlineModels.contains(model)) {
          mainlineSubItems.addAll(_mainlineSublist(model));
        }

        if (tcpModels.contains(model)) {
          tcpSubItems.addAll(_tcpSublist(model));
        }

        if (hddModels.contains(model)) {
          hddSubItems.addAll(_hddSublist(model));
        }
      }

      if (mainlineSubItems.isNotEmpty) {
        drawerList.add(_groupItem(
            "Mainline", Icons.alt_route, mainlineSubItems));
      }

      if (tcpSubItems.isNotEmpty) {
        drawerList.add(
            _groupItem(AppString.tcp, Icons.table_chart_outlined, tcpSubItems));
      }

      if (hddSubItems.isNotEmpty) {
        drawerList.add(
            _groupItem(AppString.hdd, Icons.hd_outlined, hddSubItems));
      }

      return drawerList;
    } catch (_) {
      return null;
    }
  }

  /* ===================== SUBLIST BUILDERS ===================== */

  static List<DrawerSubModel> _mainlineSublist(String model) {
    switch (model) {
      case "1":
        return [_sub(AppString.routeSurvey, const AddRouteSurveyPage())];
      case "2":
        return [_sub(AppString.rouHandover, const AddRouHandoverPage())];
      case "3":
        return [_sub(AppString.clearingGrading, const AddClearingGradingPage())];
      case "4":
        return [_sub(AppString.trenChing, const AddTrenChingPage())];
      case "5":
        return [_sub(AppString.stringing, const AddStringingPage())];
      case "6":
        return [_sub(AppString.bending, const AddBendingPage())];
      case "7":
        return [_sub(AppString.welding, const AddWeldingPage())];
      case "8":
        return [_sub(AppString.weldRepair, const AddWelderRepairPage())];
      case "9":
        return [_sub(AppString.ndtAut, const AddNdtAutPage())];
      case "10":
        return [_sub(AppString.radiography, const AddRadioGraphyPage())];
      case "11":
        return [_sub(AppString.ndtMut, const AddNdtMutPage())];
      case "12":
        return [_sub(AppString.lpt, const AddLptPage())];
      case "13":
        return [_sub(AppString.jointCoating, const AddJointCoatingPage())];
      case "14":
        return [_sub(AppString.concreteCoating, const AddConcreteCoatingPage())];
      case "15":
        return [_sub(AppString.lowering, const AddLoweringPage())];
      case "16":
        return [_sub(AppString.crossing, const AddCrossingPage())];
      case "17":
        return [_sub(AppString.levelling, const AddLevellingPage())];
      case "18":
        return [_sub(AppString.backFilling, const AddBackFillingPage())];
      case "19":
        return [_sub(AppString.hdpeDuctLaying, const AddHdpeDuctPage())];
      case "20":
        return [_sub(AppString.hdpeDuctTesting, const AddHDPEDuctTestingPage())];
      case "21":
        return [_sub(AppString.ofcSplicing, const AddOfcSplicingPage())];
      case "22":
        return [_sub(AppString.ofcBlowing, AddOFCBlowingPage())];
      case "23":
        return [_sub(AppString.preHydrotest, const AddPreHydroTestPage())];
      case "24":
        return [_sub(AppString.preHydrotest, const AddPreHydroTestPage())];
      case "25":
        return [_sub(AppString.hydrotest, const AddHydroTestPage())];
      case "26":
        return [_sub(AppString.restoration, const AddRestorationPage())];
      case "27":
        return [_sub(AppString.marker, const AddMarkerInstallationPage())];
        case "30":
        return [_sub(AppString.soilResistivity, const AddSoilResistivityPage())];
      case "32":
        return [_sub(AppString.tiein, const AddTieinPage())];
      case "33":
      return [_sub(AppString.totalWeldJoints, Center(child: Text("${AppString.totalWeldJoints} Page not Found"),))];
      case "52":
        return [_sub(AppString.dpt, Center(child: Text("${AppString.dpt} Page not Found"),))];
      case "56":
        return [_sub(AppString.hindrance, Center(child: Text("${AppString.hindrance} Page not Found"),))];
      case "59":
        return [_sub(AppString.ofcFinalTesting, Center(child: Text("${AppString.ofcFinalTesting} Page not Found"),))];
      case "60":
        return [_sub(AppString.svInstallation, Center(child: Text("${AppString.svInstallation} Page not Found"),))];
      case "61":
        return [_sub(AppString.ipInstallation, Center(child: Text("${AppString.ipInstallation} Page not Found"),))];
      default:
        return [];
    }
  }

  static List<DrawerSubModel> _tcpSublist(String model) {
    switch (model) {
      case "28":
        return [_sub(AppString.sacrificialAnode, const AddSacrificialAnodePage())];
      case "29":
        return [_sub(AppString.sacrificialAnode, const AddZnGroundingAnodePage())];
      case "31":
        return [_sub(AppString.installationCables, const AddCableInstallationPage())];
        case "40":
        return [_sub(AppString.pinBrazzing, const AddPinBrazzingPage())];
      case "41":
        return [_sub(AppString.mgAnodeInstallation,Center(child: Text("${AppString.mgAnodeInstallation} Page not Found"),))];
      case "42":
        return [_sub(AppString.anodeBedInstallation, Center(child: Text("${AppString.anodeBedInstallation} Page not Found"),))];
      case "43":
        return [_sub(AppString.cableLaying, Center(child: Text("${AppString.cableLaying} Page not Found"),))];
      case "44":
        return [_sub(AppString.groundingAnode, const AddZnGroundingAnodePage())];
      case "45":
        return [_sub(AppString.testStationBoxes, const AddTestStationBoxPage())];
      case "46":
        return [_sub(AppString.thermitWelding, const AddThermitWeldPage())];
      case "54":
        return [_sub(AppString.ssd, const AddSsdPage())];
        case "66":
        return [_sub(AppString.surgeDiverter, const AddSurgeDiverterPage())];
        case "68":
        return [_sub(AppString.polarisationCoupan, const AddPolarisationCoupanPage())];
        case "75":
        return [_sub(AppString.sacrificialAnode, const AddSacrificialAnodePage())];
      case "76":
        return [_sub(AppString.tcpMonitoringReport, Center(child: Text("${AppString.tcpMonitoringReport} Page not Found"),))];
      default:
        return [];
    }
  }

  static List<DrawerSubModel> _hddSublist(String model) {
    switch (model) {
      case "34":
        return [_sub(AppString.hddReaming, const AddHddReamingPage())];
      case "35":
        return [_sub(AppString.pilotDrill, const AddPilotDrillPage())];
      case "36":
        return [_sub(AppString.hddBore,  Center(child: Text("${AppString.hddBore} Page not Found"),))];
      case "37":
        return [_sub(AppString.hddPulling, const AddHddPullingPage())];
      case "38":
        return [_sub(AppString.gauging,  Center(child: Text("${AppString.gauging} Page not Found"),))];
      case "39":
        return [_sub(AppString.molling, Center(child: Text("${AppString.molling} Page not Found"),))];
      case "57":
        return [_sub(AppString.hddCleanPass, const AddHddCleanPassPage())];
      case "73":
        return [_sub(AppString.hddCrossing, const AddHddCrossingPage())];
      default:
        return [];
    }
  }

  /* ===================== HELPERS ===================== */

  static DrawerModel _groupItem(String label, IconData icon, List<DrawerSubModel> sublist) {
    return DrawerModel(
      widget: const SizedBox.shrink(),
      icon: icon,
      label: label,
      sublist: sublist,
      isSelected: false,
    );
  }

  static DrawerSubModel _sub(String label, Widget page) {
    return DrawerSubModel(
      label: label,
      widget: page,
      isSelected: false,
    );
  }

  /* ===================== APP UPDATE ===================== */

  static checkAppUpdate({required BuildContext context}) async {
    try {
      PackageInfo info = await PackageInfo.fromPlatform();
      String url =
          "http://unistal.smartgasnet.com/api/app-details?packageName=${info.packageName}";

      var res = await ServerRequest.getGoogleData(url: Uri.parse(url));
      if (res != null &&
          res['status'] == true &&
          double.parse(info.buildNumber) <
              double.parse(res['data']['app_version_code'])) {
        AppUpdateMessage.showAlertDialog(
            context: context, url: res['data']['app_url']);
      }
    } catch (_) {}
  }
}
