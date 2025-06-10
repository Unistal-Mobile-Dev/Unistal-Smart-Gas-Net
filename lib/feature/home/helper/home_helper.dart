import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/bloc/add_back_filling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/page/add_back_filling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/bloc/add_bending_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/presentation/page/add_bending_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/presentation/page/add_clearing_grading_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/presentation/page/add_concrete_coating_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/presentation/page/add_crossing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/addCutPipe/presentation/page/add_cut_pipe_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/restoreCutePipe/presentation/page/restore_cut_pipe_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/drying/addDrying/presentation/page/add_drying_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeDutTesting/addHDPEDuctTesting/presentation/page/add_hdpe_duct_testing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/persentation/page/add_hdpe_duct_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/presentation/page/add_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/presentation/page/add_joint_coating_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/levelling/addLevelling/presentation/page/add_levelling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/presentation/page/add_lowering_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/presentation/page/add_lpt_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/presentation/page/add_ndt_aut_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/persentation/page/add_ndt_mut_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/persentation/page/add_ofc_splicing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/postHydrotest/addPostHydrotest/presentation/page/add_post_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/preHydrotest/addPreHydrotest/presentation/page/add_pre_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/persentation/page/add_radiography_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/presentation/page/add_restoration_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/domain/add_rou_handover_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/presentation/page/add_rou_handover_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/presentation/page/route_survey_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/domain/bloc/add_soil_resistivity_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/presentation/page/add_soil_resistivity_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/bloc/add_stringing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/presentation/page/add_stringing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/swabbing/addSwabbing/presentation/page/add_swabbing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/tieIn/addTiein/presentation/page/add_tiein_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/bloc/add_tren_ching_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/presentation/page/add_tren_ching_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/presentation/page/add_welder_repair_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/bloc/add_welding_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/presentation/page/add_welding_page.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_update_message_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeHelper {
  static Future<List<ActivitySectionData>?> activityBySectionApi(
      {required LoginDataModel userData}) async {
    try {
      String url = APIs.activityBySection;
      Map<String, String> para = {
        "schema": "${userData.schema}",
        "userid": "${userData.userId}",
        "section_id": "${userData.sectionId}"
      };
      String json = Uri(queryParameters: para).query;
      var res = await ServerRequest.getData(urlEndPoint: url + json);

      if (res != null &&
          res['success'] != null &&
          res['success'] == 200 &&
          res['data'] != null) {
        List<ActivitySectionData> activityList = (res['data'] as List)
            .map((item) => ActivitySectionData.fromJson(item))
            .toList();

        AppConfig.instanceInit()
            ?.setListActivityData(newListOfActivitySection: activityList);
        return activityList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchDrawerList(
      {required BuildContext context}) async {
    try {
      List<DrawerModel> drawerList = [];
      List<ActivitySectionData> listOfActivitySection =
          await AppConfig.instanceInit()?.listOfActivitySection ?? [];
      drawerList.add(DrawerModel(
          widget: const DashboardPage(),
          icon: Icons.home_outlined,
          label: AppString.dashboard,
          sublist: [],
          isSelected: true));

      for (var item in listOfActivitySection) {
        String modelName = item.activityId?.toString().trim() ?? '';
        switch (modelName) {
          case '1':
            drawerList.add(DrawerModel(
                widget: const AddRouteSurveyPage(),
                icon: Icons.alt_route_sharp,
                label: AppString.routeSurvey,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddRouHandoverPage(),
                  icon: Icons.handshake_outlined,
                  label: AppString.rouHandover,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '3':
            drawerList.add(DrawerModel(
                widget: const AddClearingGradingPage(),
                icon: Icons.auto_graph,
                label: AppString.clearingGrading,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));

            break;
          case '4':
            drawerList.add(DrawerModel(
                widget: const AddTrenChingPage(),
                icon: Icons.comment_bank_outlined,
                label: AppString.trenChing,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));

            break;
          case '5':
            drawerList.add(DrawerModel(
                widget: const AddStringingPage(),
                icon: Icons.stream,
                label: AppString.stringing,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));

            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddBendingPage(),
                  icon: Icons.webhook_rounded,
                  label: AppString.bending,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '7':
            drawerList.add(DrawerModel(
                widget: const AddWeldingPage(),
                icon: Icons.transgender_outlined,
                label: AppString.welding,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '8':
            drawerList.add(DrawerModel(
                widget: const AddWelderRepairPage(),
                icon: Icons.tire_repair_sharp,
                label: AppString.weldRepair,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '10':
            drawerList.add(DrawerModel(
                widget: const AddRadioGraphyPage(),
                icon: Icons.graphic_eq,
                label: AppString.ndtRT,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            drawerList.add(DrawerModel(
                widget: const AddTieinPage(),
                icon: Icons.send_time_extension_outlined,
                label: AppString.tiein,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            drawerList.add(DrawerModel(
                widget: const AddLptPage(),
                icon: Icons.local_play_outlined,
                label: AppString.ndtLpt,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddNdtAutPage(),
                  icon: Icons.auto_awesome_mosaic_outlined,
                  label: AppString.ndtAut,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '11':
            drawerList.add(DrawerModel(
                widget: const AddNdtMutPage(),
                icon: Icons.nearby_error_rounded,
                label: AppString.ndtMut,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '13':
            drawerList.add(DrawerModel(
                widget: const AddJointCoatingPage(),
                icon: Icons.join_inner_outlined,
                label: AppString.jointCoating,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddConcreteCoatingPage(),
                  icon: Icons.business,
                  label: AppString.concreteCoating,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '15':
            drawerList.add(DrawerModel(
                widget: const AddLoweringPage(),
                icon: Icons.bookmark_added_outlined,
                label: AppString.lowering,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddHdpeDuctPage(),
                  icon: Icons.padding_outlined,
                  label: AppString.hdpeDuctLaying,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddHDPEDuctTestingPage(),
                  icon: Icons.pages_outlined,
                  label: AppString.hdpeDuctTesting,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '18':
            drawerList.add(DrawerModel(
                widget: const AddBackFillingPage(),
                icon: Icons.newspaper,
                label: AppString.backFilling,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '16':
            drawerList.add(DrawerModel(
                widget: const AddCrossingPage(),
                icon: Icons.format_line_spacing_sharp,
                label: AppString.crossing,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddOfcSplicingPage(),
                  icon: Icons.offline_share,
                  label: AppString.ofcSplicing,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddPostHydroTestPage(),
                  icon: Icons.fire_hydrant_alt_outlined,
                  label: AppString.postHydrotest,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '23':
            drawerList.add(DrawerModel(
                widget: const AddPreHydroTestPage(),
                icon: Icons.precision_manufacturing,
                label: AppString.preHydrotest,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '25':
            drawerList.add(DrawerModel(
                widget: const AddHydroTestPage(),
                icon: Icons.fire_hydrant,
                label: AppString.hydrotest,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '26':
            drawerList.add(DrawerModel(
                widget: const AddRestorationPage(),
                icon: Icons.present_to_all_sharp,
                label: AppString.restoration,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '17':
            drawerList.add(DrawerModel(
                widget: const AddLevellingPage(),
                icon: Icons.file_present,
                label: AppString.levelling,
                sublist: [],
                isSelected: false,
                actionButtonWidget: null));
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddSwabbingPage(),
                  icon: Icons.swap_horizontal_circle_outlined,
                  label: AppString.swabbing,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddDryingPage(),
                  icon: Icons.dry_outlined,
                  label: AppString.drying,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: null));
            }
            break;
          case '':
            if (AppConfig.instanceInit()!.client != Client.mgl) {
              drawerList.add(DrawerModel(
                  widget: const AddCutPipePage(),
                  icon: Icons.panorama_horizontal_rounded,
                  label: AppString.cutPipe,
                  sublist: [],
                  isSelected: false,
                  actionButtonWidget: _restoreActionWidget(context: context)));
            }
            break;
        }
      }
      return drawerList;
    } catch (e) {
      return null;
    }
  }

  static Widget _restoreActionWidget({required BuildContext context}) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const RestoreCutPipePage()));
            },
            child: TextWidget(
              AppString.restore,
              color: AppColor.white,
            )),
      ],
    );
  }

  static Widget _bendingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddBendingBloc>(context)
                  .add(AddBendingPageLoadEvent(context: context));
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddBendingPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _weldingActionButton({required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddWeldingBloc>(context)
                  .add(AddWeldingPageLoadEvent(context: context));
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddWeldingPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _backFillingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddBackFillingBloc>(context)
                  .add(AddBackFillingPageLoadEvent(context: context));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddBackFillingPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _clearingGradingAction({required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddClearingGradingBloc>(context)
                  .add(AddClearingGradingPageLoadEvent(context: context));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddClearingGradingPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _soilresistivityinsertActionWidget(
      {required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddSoilResistivityBloc>(context)
                  .add(AddSoilResistivityPageLoadEvent(context: context));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddSoilResistivityPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _rouHandoverActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddRouHandoverBloc>(context)
                  .add(AddRouHandoverLoadEvent(context: context));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddRouHandoverPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _trenchingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddTrenChingBloc>(context)
                  .add(AddTrenChingPageLoadEvent(context: context));
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddTrenChingPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _stringingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AddStringingBloc>(context)
                  .add(AddStringingPageLoadEvent(context: context));
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddStringingPage()));
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Future<dynamic> fetchSystemAdminSubList() async {
    try {
      List<DrawerSubModel> drawerSubList = [];
      drawerSubList.add(DrawerSubModel(
        label: 'Add User',
        widget: Container(),
        isSelected: false,
      ));

      drawerSubList.add(DrawerSubModel(
        label: 'Update User',
        widget: Container(),
        isSelected: false,
      ));

      drawerSubList.add(DrawerSubModel(
        label: 'Update Company',
        widget: Container(),
        isSelected: false,
      ));
      return drawerSubList;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchAppBottomBarItems(
      {required BuildContext context, required RoleType appModule}) async {
    try {
      List<BottomNavigationBarItem> bottomNavigationBarItemList = [];

/*         if (appModule == RoleType.serviceCenter){
            bottomNavigationBarItemList.add(BottomNavigationBarItem(
              icon: const Icon(Icons.fire_truck_outlined,),
              label: AppString.running,
            ));
            bottomNavigationBarItemList.add(BottomNavigationBarItem(
              icon: const Icon(Icons.assignment_outlined,),
              label: AppString.assign,
            ));

            bottomNavigationBarItemList.add(BottomNavigationBarItem(
              icon: const Icon(Icons.person_pin,),
              label: AppString.profile,
            ));
          }*/

      return bottomNavigationBarItemList;
    } catch (e) {
      SnackBarErrorWidget(context).show(message: "Bottom Bar Error");
      return null;
    }
  }

  static Future<dynamic> fetchPageWidgets(
      {required BuildContext context, required RoleType appModule}) async {
    try {
      List<Widget> pageWidgetList = [];
      return pageWidgetList;
    } catch (e) {
      SnackBarErrorWidget(context).show(message: "Page Widget Error");
      return null;
    }
  }

  static checkAppUpdate({required BuildContext context}) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;
      String buildNumber = packageInfo.buildNumber;
      String url =
          "http://unistal.smartgasnet.com/api/app-details?packageName=$packageName";
      var res = await ServerRequest.getGoogleData(url: Uri.parse(url));
      if (res != null &&
          res['status'] != null &&
          res['status'] == true &&
          res['data'] != null) {
        String versionCode = res['data']['app_version_code'];
        String appUrl = res['data']['app_url'];
        if (double.parse(buildNumber.toString()) <
            double.parse(versionCode.toString())) {
          AppUpdateMessage.showAlertDialog(
              context: !context.mounted ? context : context, url: appUrl);
        }
      }
    } catch (_) {}
  }
}
