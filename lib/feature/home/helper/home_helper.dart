import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/presentation/widget/BackFillingRecordWidget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/presentation/widget/ClearGradeRecordWidget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/presentation/widget/RouHandoverRecordWidget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/presentation/widget/RouteSurveyRecordWidget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/presentation/widget/TrenchingRecordWidget.dart';

class HomeHelper {
  /* ===================== API ===================== */

  static Future<List<ActivitySectionData>?> activityBySectionApi({
    required LoginDataModel userData,
  }) async {

    if (!await ConnectivityHelper.checkInterNetConnect()) {
      return _loadFromHive();
    }
    try {
      String url = APIs.activityBySection;
      Map<String, String> para = {
        "schema": "${userData.schema}",
        "userid": "${userData.userId}",
        "section_id": "${userData.sectionId}"
      };

      String json = Uri(queryParameters: para).query;
      var res = await ServerRequest.getData(urlEndPoint: url + json, showNoInternetPopup: false,);

      if (res != null && res['success'] == 200 && res['error'] == false && res['data'] != null) {
        List<ActivitySectionData> list = (res['data'] as List)
            .map((e) => ActivitySectionData.fromJson(e))
            .toList();
        AppConfig.instanceInit()?.setListActivityData(newListOfActivitySection: list);
        if (HiveDataBase.activitySectionBox != null && HiveDataBase.activitySectionBox!.isOpen) {
          await HiveDataBase.activitySectionBox!.clear();
          await HiveDataBase.activitySectionBox!.addAll(list);
        }
        return list;
      }
      // API ne galat response diya → Hive se
      return _loadFromHive();
    } catch (e) {
      debugPrint("activityBySectionApi error: $e");
      // Error aaya → Hive se
      return _loadFromHive();
    }
  }

  static List<ActivitySectionData>? _loadFromHive() {
    final box = HiveDataBase.activitySectionBox;
    if (box == null || !box.isOpen || box.isEmpty) return null;

    final cached = box.values.toList();
    AppConfig.instanceInit()?.setListActivityData(newListOfActivitySection: cached);
    return cached;
  }

  /* ===================== DRAWER ===================== */

  static Future<List<DrawerModel>?> fetchDrawerList({
    required BuildContext context,
  }) async {
    try {
      final drawerList = <DrawerModel>[];
      List<ActivitySectionData> activities =
          AppConfig.instanceInit()?.listOfActivitySection ?? [];

    // 2. Khaali ho to Hive se lo (offline case)
      if (activities.isEmpty) {
        activities = _loadFromHive() ?? [];
        debugPrint("fetchDrawerList: loaded ${activities.length} from Hive");
      }

      // final activeActivities = activities.where((e) => e.status == "1" || e.status == "0").toList();
      final activeActivities =
          activities.where((e) => e.status == "1").toList();

      /// Dashboard
      // drawerList.add(
      //   DrawerModel(
      //     widget: const DashboardPage(),
      //     icon: Icons.home_outlined,
      //     label: AppString.dashboard,
      //     sublist: [],
      //     isSelected: true,
      //     isRoot: true,
      //   ),
      // );

      final mainlineSubItems = <DrawerSubModel>[];
      final tcpSubItems = <DrawerSubModel>[];
      final hddSubItems = <DrawerSubModel>[];

      final addedIds = <String>{};
      // drawerList.add(
      //   DrawerModel(
      //     widget: const WebDashboardPage(),
      //     icon: Icons.home_outlined,
      //     label: AppString.dashboard,
      //     sublist: [],
      //     isSelected: true,
      //     isRoot: true,
      //   ),
      // );

      // String? dashboardLink =  AppConfig.instanceInit()?.dashboardLink.toString();
      // String? dashboardToken =  AppConfig.instanceInit()?.dashboardToken.toString();
      //   if(dashboardLink != null){
      //     drawerList.add(DrawerModel(
      //         widget: WebDashboardPage(url: dashboardLink.toString(),token: dashboardToken.toString(), name: "Dashboard",),
      //         icon: Icons.dashboard_outlined,
      //         label: "Dashboard",
      //         isSelected: true,
      //         sublist: [],
      //        )
      //     );
      //   }

      for (final item in activeActivities) {
        final id = (item.activityId ?? "").trim(); // <-- use activityId

        if (id.isEmpty) continue;
        if (addedIds.contains(id)) continue;

        if (_mainlineRoutes.containsKey(id)) {
          mainlineSubItems.add(_sub(
            label: item.activityName ?? id,
            page: _mainlineRoutes[id]!,
            activityData: item,
          ));
          addedIds.add(id);
        } else if (_tcpRoutes.containsKey(id)) {
          tcpSubItems.add(_sub(
            label: item.activityName ?? id,
            page: _tcpRoutes[id]!,
            activityData: item,
          ));
          addedIds.add(id);
        } else if (_hddRoutes.containsKey(id)) {
          hddSubItems.add(_sub(
            label: item.activityName ?? id,
            page: _hddRoutes[id]!,
            activityData: item,
          ));
          addedIds.add(id);
        } else {
          debugPrint("⚠️ No mapping found for activity_id: $id");
        }
      }
      if (mainlineSubItems.isNotEmpty) {
        drawerList.add(_groupItem(
            label: "Mainline",
            icon: Icons.alt_route,
            sublist: mainlineSubItems));
      }
      if (tcpSubItems.isNotEmpty) {
        drawerList.add(_groupItem(
            label: AppString.tcp,
            icon: Icons.table_chart,
            sublist: tcpSubItems));
      }
      if (hddSubItems.isNotEmpty) {
        drawerList.add(_groupItem(
            label: AppString.hdd, icon: Icons.hd, sublist: hddSubItems));
      }

      drawerList.add(
        _groupItem(
          label: "Hindrance",
          icon: Icons.warning_amber_outlined,
          sublist: [
            _sub(
              label: "Add Hindrance",
              page: const AddHindrancePage(),
              activityData: ActivitySectionData(),
            ),
            _sub(
              label: "View Hindrance",
              page: const ViewHindrancePage(),
              activityData:ActivitySectionData(),
            ),
          ],
        ),
      );
      drawerList.add(
        _groupItem(
          label: "Records",
          icon: Icons.cloud_upload_outlined,
          sublist: [
            _sub(
              label: "ROUTE SURVEY",
              page: const RouteSurveyRecordWidget(),
              activityData: ActivitySectionData(),
            ),
            _sub(
              label: "ROU HANDOVER",
              page: const RouHandoverRecordWidget(),
              activityData: ActivitySectionData(),
            ),
            _sub(
              label: "CLEARING AND GRADING",
              page: const ClearGradeRecordWidget(),
              activityData: ActivitySectionData(),
            ),
            _sub(
              label: "TRENCHING",
              page: const TrenchingRecordWidget(),
              activityData: ActivitySectionData(),
            ),
            _sub(
              label: "BACKFILLING",
              page: const BackFillingRecordWidget(),
              activityData: ActivitySectionData(),
            ),

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

  /// -------- MAINLINE --------=09
  static final Map<String, Widget> _mainlineRoutes = {
    "1": const AddRouteSurveyPage(), // ROUTE SURVEY
    "2": const AddRouHandoverPage(), // ROU HANDOVER
    "3": const AddClearingGradingPage(), // CLEARING AND GRADING
    "4": const AddTrenChingPage(), // TRENCHING
    "5": const AddStringingPage(), // STRINGING
    "6": const AddBendingPage(), // BENDING
    "7": const AddWeldingPage(), // Mainline Welding
    "8": const AddWelderRepairPage(), // Weld Repair
    "9": const AddNdtAutPage(), // NDT AUT
    "10": const AddRadioGraphyPage(), // NDT RT
    "11": const AddNdtMutPage(), // NDT MUT
    "12": const AddLptPage(), // NDT LPT
    "13": const AddJointCoatingPage(), // Joint Coating
    "14": const AddConcreteCoatingPage(), // Concrete Coating
    "15": const AddLoweringPage(), // Loweringrtfyu
    "16": const AddCrossingPage(), // Crossing
    "17": const AddLevellingPage(), // Levelling
    "18": const AddBackFillingPage(), // Backfilling
    "19": const AddHdpeDuctPage(), // HDPE Duct Laying
    "20": const AddHDPEDuctTestingPage(), // HDPE Duct Testing
    "21": const AddOfcSplicingPage(), // OFC Splicing/Jointing
    "22": AddOFCBlowingPage(), // OFC Blowing
    "23": const AddPreHydroTestPage(), // Pre Hydrotest
    "24": const AddPostHydroTestPage(), // Post Hydrotest
    "25": const AddHydroTestPage(), // Hydrotest
    "26": const AddRestorationPage(), // Restoration
    "27": const AddMarkerInstallationPage(), // Marker Installation
    "30": const AddSoilResistivityPage(), // Soil Resistivity Survey
    "32": const AddTieinPage(), // Tie-In Welding
    "33": const AddWeldingPage(), // Total Weld Joints
    "79": const AddWeldingPage(), // Total Weld Length
  };

  /// -------- TCP --------
  static final Map<String, Widget> _tcpRoutes = {
    "28": const AddSacrificialAnodePage(),
    // Sacrificial Anode
    "29": const AddZnGroundingAnodePage(),
    // Zn Grounding Anode
    "31": const AddCableInstallationPage(),
    // Cable Installation
    "40": const AddPinBrazzingPage(),
    // Pin Brazzing
    "45": const AddTestStationBoxPage(),
    // Test Station Box
    "46": const AddThermitWeldPage(),
    // Thermit Welding
    "54": const AddSsdPage(),
    // SSD
    "55": const AddSsdPage(),
    // TCP Installation (map to SSD or create new page)
    "66": const AddSurgeDiverterPage(),
    // Surge Diverter
    "68": const AddPolarisationCoupanPage(),
    // Polarisation Coupan
    "75": const AddSurgeDiverterPage(),
    // TCP Commission Report (map accordingly)
    "76": const AddSurgeDiverterPage(),
    // TCP Monitoring Report (map accordingly)
  };

  /// -------- HDD --------
  static final Map<String, Widget> _hddRoutes = {
    "34": const AddHddReamingPage(), // Reaming
    "35": const AddPilotDrillPage(), // Drilling
    "36": const AddHddCleanPassPage(), // HDD Bore (map accordingly)
    "37": const AddHddPullingPage(), // Pipe Pull
    "38": const AddHddCleanPassPage(), // Gauging (map accordingly)
    "39": const AddHddCleanPassPage(), // Molling (map accordingly)
    "57": const AddHddCleanPassPage(), // Clean Pass
    "73": const AddHddCrossingPage(), // HDD Crossing
  };

  /* ===================== HELPERS ===================== */

  static DrawerModel _groupItem(
      {required String label,
      required IconData icon,
      required List<DrawerSubModel> sublist}) {
    return DrawerModel(
      widget: const SizedBox.shrink(),
      icon: icon,
      label: label,
      sublist: sublist,
      isSelected: false,
    );
  }

  static DrawerSubModel _sub({
    required String label,
    required Widget page,
    required ActivitySectionData activityData,
  }) {
    return DrawerSubModel(
        label: label,
        widget: page,
        isSelected: false,
        activityData: activityData);
  }
}
