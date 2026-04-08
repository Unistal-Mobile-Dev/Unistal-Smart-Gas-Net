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
      final activities =
          AppConfig.instanceInit()?.listOfActivitySection ?? [];

      final activeActivities = activities.where((e) => e.status == "1" || e.status == "0").toList();

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

      // drawerList.add(
      //   DrawerModel(
      //     widget: const AddHindrancePage(),
      //     icon: Icons.warning_amber_outlined,
      //     label: "Hindrance",
      //     sublist: [], // no sub items
      //     isSelected: false,
      //   ),
      // );

      final mainlineSubItems = <DrawerSubModel>[];
      final tcpSubItems = <DrawerSubModel>[];
      final hddSubItems = <DrawerSubModel>[];

      /// Prevent duplicates
      final addedModels = <String>{};

      for (final item in activeActivities) {
        final model = (item.modelName ?? "").trim();

        if (model.isEmpty) continue;
        if (addedModels.contains(model)) continue;

        /// MAINLINE
        if (_mainlineRoutes.containsKey(model)) {
          mainlineSubItems.add(_sub(
            _mainlineLabels[model] ?? model,
            _mainlineRoutes[model]!,
          ));
          addedModels.add(model);
        }

        /// TCP
        else if (_tcpRoutes.containsKey(model)) {
          tcpSubItems.add(_sub(
            _tcpLabels[model] ?? model,
            _tcpRoutes[model]!,
          ));
          addedModels.add(model);
        }

        /// HDD
        else if (_hddRoutes.containsKey(model)) {
          hddSubItems.add(_sub(
            _hddLabels[model] ?? model,
            _hddRoutes[model]!,
          ));
          addedModels.add(model);
        }


        /// UNKNOWN (Optional Debug)
        else {
          debugPrint("⚠️ No mapping found for model: $model");
        }
      }

      if (mainlineSubItems.isNotEmpty) {
        drawerList.add(
            _groupItem("Mainline", Icons.alt_route, mainlineSubItems));
      }

      if (tcpSubItems.isNotEmpty) {
        drawerList.add(
            _groupItem(AppString.tcp, Icons.table_chart, tcpSubItems));
      }

      if (hddSubItems.isNotEmpty) {
        drawerList.add(
            _groupItem(AppString.hdd, Icons.hd, hddSubItems));
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

  /* ===================== ROUTE MAPS ===================== */

  /// -------- MAINLINE --------
  static final Map<String, Widget> _mainlineRoutes = {
    "RouteSurvey": const AddRouteSurveyPage(),
    "RouHandover": const AddRouHandoverPage(),
    "Clearingngrading": const AddClearingGradingPage(),
    "Trenching": const AddTrenChingPage(),
    "Stringing": const AddStringingPage(),
    "Bending": const AddBendingPage(),
    "Welding": const AddWeldingPage(),
    "WeldRepair": const AddWelderRepairPage(),
    "NdtAut": const AddNdtAutPage(),
    "Ndtrt": const AddRadioGraphyPage(),
    "NdtMut": const AddNdtMutPage(),
    "NdtLpt": const AddLptPage(),
    "JointCoating": const AddJointCoatingPage(),
    "ConcreteCoating": const AddConcreteCoatingPage(),
    "Lowering": const AddLoweringPage(),
    "Crossing": const AddCrossingPage(),
    "Levelling": const AddLevellingPage(),
    "Backfilling": const AddBackFillingPage(),
    "HDPEDuctLaying": const AddHdpeDuctPage(),
    "HdpeDuctTesting": const AddHDPEDuctTestingPage(),
    "OfcSplicing": const AddOfcSplicingPage(),
    "OfcBlowing": AddOFCBlowingPage(),
    "PrepostHydrotest": const AddPreHydroTestPage(), // handle both
    "Hydrotest": const AddHydroTestPage(),
    "Restoration": const AddRestorationPage(),
    "Marker": const AddMarkerInstallationPage(),
    "SoilResistivity": const AddSoilResistivityPage(),
  };

  static final Map<String, String> _mainlineLabels = {
    "RouteSurvey": AppString.routeSurvey,
    "RouHandover": AppString.rouHandover,
    "Clearingngrading": AppString.clearingGrading,
    "Trenching": AppString.trenChing,
    "Stringing": AppString.stringing,
    "Bending": AppString.bending,
    "Welding": AppString.welding,
    "WeldRepair": AppString.weldRepair,
    "NdtAut": AppString.ndtAut,
    "Ndtrt": AppString.radiography,
    "NdtMut": AppString.ndtMut,
    "NdtLpt": AppString.lpt,
    "JointCoating": AppString.jointCoating,
    "ConcreteCoating": AppString.concreteCoating,
    "Lowering": AppString.lowering,
    "Crossing": AppString.crossing,
    "Levelling": AppString.levelling,
    "Backfilling": AppString.backFilling,
    "HDPEDuctLaying": AppString.hdpeDuctLaying,
    "HdpeDuctTesting": AppString.hdpeDuctTesting,
    "OfcSplicing": AppString.ofcSplicing,
    "OfcBlowing": AppString.ofcBlowing,
    "PrepostHydrotest": AppString.preHydrotest,
    "Hydrotest": AppString.hydrotest,
    "Restoration": AppString.restoration,
    "Marker": AppString.marker,
    "SoilResistivity": AppString.soilResistivity,
  };

  /// -------- TCP --------
  static final Map<String, Widget> _tcpRoutes = {
    "PinBrazzing": const AddPinBrazzingPage(),
    "CableInstallation": const AddCableInstallationPage(),
    "ZnGroundingAnode": const AddZnGroundingAnodePage(),
    "TestStationBox": const AddTestStationBoxPage(),
    "ThermitWelding": const AddThermitWeldPage(),
    "SurgeDiverter": const AddSurgeDiverterPage(),
    "SSD": const AddSsdPage(),
    "PolarisationCoupan": const AddPolarisationCoupanPage(),
    "SacrificialAnode": const AddSacrificialAnodePage(),
  };

  static final Map<String, String> _tcpLabels = {
    "PinBrazzing": AppString.pinBrazzing,
    "CableInstallation": AppString.installationCables,
    "ZnGroundingAnode": AppString.groundingAnode,
    "TestStationBox": AppString.testStationBoxes,
    "ThermitWelding": AppString.thermitWelding,
    "SurgeDiverter": AppString.surgeDiverter,
    "SSD": AppString.ssd,
    "PolarisationCoupan": AppString.polarisationCoupan,
    "SacrificialAnode": AppString.sacrificialAnode,
  };

  /// -------- HDD --------
  static final Map<String, Widget> _hddRoutes = {
    "Reaming": const AddHddReamingPage(),
    "Drilling": const AddPilotDrillPage(),
    "PipePull": const AddHddPullingPage(),
    "CleanPass": const AddHddCleanPassPage(),
    "HddCrossing": const AddHddCrossingPage(),
  };

  static final Map<String, String> _hddLabels = {
    "Reaming": AppString.hddReaming,
    "Drilling": AppString.pilotDrill,
    "PipePull": AppString.hddPulling,
    "CleanPass": AppString.hddCleanPass,
    "HddCrossing": AppString.hddCrossing,
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