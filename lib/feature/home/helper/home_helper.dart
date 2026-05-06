import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/presentation/page/add_hindrance_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/presentation/page/view_hindrance_page.dart';
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
import 'package:flutter_unistal_smart_gas_net/feature/tieIn/addTiein/presentation/page/add_tiein_page.dart';
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
        "section_id": "${userData.sectionId}"
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

      final activeActivities =
      activities.where((e) => e.status == "1" || e.status == "0").toList();

      /// Dashboard
      drawerList.add(
        DrawerModel(
          widget: const DashboardPage(),
          icon: Icons.home_outlined,
          label: AppString.dashboard,
          sublist: [],
          isSelected: true,
          isRoot: true,
        ),
      );

      final mainlineSubItems = <DrawerSubModel>[];
      final tcpSubItems = <DrawerSubModel>[];
      final hddSubItems = <DrawerSubModel>[];

      final addedIds = <String>{};

      for (final item in activeActivities) {
        final id = (item.activityId ?? "").trim(); // <-- use activityId

        if (id.isEmpty) continue;
        if (addedIds.contains(id)) continue;

        if (_mainlineRoutes.containsKey(id)) {
          mainlineSubItems.add(_sub(
            item.activityName ?? id,
            _mainlineRoutes[id]!,
          ));
          addedIds.add(id);
        } else if (_tcpRoutes.containsKey(id)) {
          tcpSubItems.add(_sub(
            item.activityName ?? id,
            _tcpRoutes[id]!,
          ));
          addedIds.add(id);
        } else if (_hddRoutes.containsKey(id)) {
          hddSubItems.add(_sub(
            item.activityName ?? id,
            _hddRoutes[id]!,
          ));
          addedIds.add(id);
        } else {
          debugPrint("⚠️ No mapping found for activity_id: $id");
        }
      }

      if (mainlineSubItems.isNotEmpty) {
        drawerList.add(_groupItem("Mainline", Icons.alt_route, mainlineSubItems));
      }
      if (tcpSubItems.isNotEmpty) {
        drawerList.add(_groupItem(AppString.tcp, Icons.table_chart, tcpSubItems));
      }
      if (hddSubItems.isNotEmpty) {
        drawerList.add(_groupItem(AppString.hdd, Icons.hd, hddSubItems));
      }

      drawerList.add(
        _groupItem(
          "Hindrance",
          Icons.warning_amber_outlined,
          [
            _sub("Add Hindrance", const AddHindrancePage()),
            _sub("View Hindrance", const ViewHindrancePage()),
          ],
        ),
      );

      return drawerList;
    } catch (e) {
      debugPrint("Drawer Error: $e");
      return null;
    }
  }

  /* ===================== ROUTE MAPS (keyed by activity_id) ===================== */

  /// -------- MAINLINE --------
  static final Map<String, Widget> _mainlineRoutes = {
    "1":  const AddRouteSurveyPage(),        // ROUTE SURVEY
    "2":  const AddRouHandoverPage(),         // ROU HANDOVER
    "3":  const AddClearingGradingPage(),     // CLEARING AND GRADING
    "4":  const AddTrenChingPage(),           // TRENCHING
    "5":  const AddStringingPage(),           // STRINGING
    "6":  const AddBendingPage(),             // BENDING
    "7":  const AddWeldingPage(),             // Mainline Welding
    "8":  const AddWelderRepairPage(),        // Weld Repair
    "9":  const AddNdtAutPage(),              // NDT AUT
    "10": const AddRadioGraphyPage(),         // NDT RT
    "11": const AddNdtMutPage(),              // NDT MUT
    "12": const AddLptPage(),                 // NDT LPT
    "13": const AddJointCoatingPage(),        // Joint Coating
    "14": const AddConcreteCoatingPage(),     // Concrete Coating
    "15": const AddLoweringPage(),            // Lowering
    "16": const AddCrossingPage(),            // Crossing
    "17": const AddLevellingPage(),           // Levelling
    "18": const AddBackFillingPage(),         // Backfilling
    "19": const AddHdpeDuctPage(),            // HDPE Duct Laying
    "20": const AddHDPEDuctTestingPage(),     // HDPE Duct Testing
    "21": const AddOfcSplicingPage(),         // OFC Splicing/Jointing
    "22": AddOFCBlowingPage(),                // OFC Blowing
    "23": const AddPreHydroTestPage(),        // Pre Hydrotest
    "24": const AddPreHydroTestPage(),        // Post Hydrotest (same page)
    "25": const AddHydroTestPage(),           // Hydrotest
    "26": const AddRestorationPage(),         // Restoration
    "27": const AddMarkerInstallationPage(),  // Marker Installation
    "30": const AddSoilResistivityPage(),     // Soil Resistivity Survey
    "32": const AddTieinPage(),             // Tie-In Welding
    "33": const AddWeldingPage(),             // Total Weld Joints
    "79": const AddWeldingPage(),             // Total Weld Length
  };

  /// -------- TCP --------
  static final Map<String, Widget> _tcpRoutes = {
    "28": const AddSacrificialAnodePage(),    // Sacrificial Anode
    "29": const AddZnGroundingAnodePage(),    // Zn Grounding Anode
    "31": const AddCableInstallationPage(),   // Cable Installation
    "40": const AddPinBrazzingPage(),         // Pin Brazzing
    "45": const AddTestStationBoxPage(),      // Test Station Box
    "46": const AddThermitWeldPage(),         // Thermit Welding
    "54": const AddSsdPage(),                 // SSD
    "55": const AddSsdPage(),                 // TCP Installation (map to SSD or create new page)
    "66": const AddSurgeDiverterPage(),       // Surge Diverter
    "68": const AddPolarisationCoupanPage(),  // Polarisation Coupan
    "75": const AddSurgeDiverterPage(),       // TCP Commission Report (map accordingly)
    "76": const AddSurgeDiverterPage(),       // TCP Monitoring Report (map accordingly)
  };

  /// -------- HDD --------
  static final Map<String, Widget> _hddRoutes = {
    "34": const AddHddReamingPage(),    // Reaming
    "35": const AddPilotDrillPage(),    // Drilling
    "36": const AddHddCleanPassPage(),  // HDD Bore (map accordingly)
    "37": const AddHddPullingPage(),    // Pipe Pull
    "38": const AddHddCleanPassPage(),  // Gauging (map accordingly)
    "39": const AddHddCleanPassPage(),  // Molling (map accordingly)
    "57": const AddHddCleanPassPage(),  // Clean Pass
    "73": const AddHddCrossingPage(),   // HDD Crossing
  };


  /* ===================== HELPERS ===================== */

  static DrawerModel _groupItem(
      String label, IconData icon, List<DrawerSubModel> sublist) {
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

}