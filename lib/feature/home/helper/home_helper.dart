import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/page/add_back_filling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/presentation/page/add_crossing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/addCutPipe/presentation/page/add_cut_pipe_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/restoreCutePipe/presentation/page/restore_cut_pipe_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dpt/addDpt/presentation/page/add_dpt_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/persentation/page/add_hdpe_duct_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/presentation/page/add_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/presentation/page/add_joint_coating_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/presentation/page/add_lowering_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/marker/addMarker/presentation/page/add_marker_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/molling/addMolling/presentation/page/add_molling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/persentation/page/add_ndt_mut_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/postHydrotest/addPostHydrotest/presentation/page/add_post_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/preHydrotest/addPreHydrotest/presentation/page/add_pre_hydrotest_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/persentation/page/add_radiography_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/steelStructure/addStreelStructure/presentation/page/add_steel_structure_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/presentation/page/add_stringing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/swabbing/addSwabbing/presentation/page/add_swabbing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/presentation/page/add_tren_ching_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/valveChamber/addValveChamber/presentation/page/add_valve_chamber_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/presentation/page/add_welding_page.dart';

class HomeHelper {


  static Future<dynamic> fetchDrawerList({required BuildContext context}) async {

    try{
       List<DrawerModel> drawerList = [];
       drawerList.add(DrawerModel(widget: const DashboardPage(), icon: Icons.home_outlined,
           label: AppString.dashboard, sublist: [], isSelected: true));

      /* List<DrawerSubModel> systemAdminList = await fetchSystemAdminSubList();*/

/*       drawerList.add(DrawerModel(widget: const AddRouteSurveyPage(), icon: Icons.alt_route_sharp,
           label: AppString.routeSurvey, sublist: [],  isSelected: false, actionButtonWidget: null));

       if(AppConfig.instanceInit()!.client != Client.iglMZ){
         drawerList.add(DrawerModel(widget: const AddRouHandoverPage(), icon: Icons.handshake_outlined,
             label: AppString.rouHandover, sublist: [],  isSelected: false, actionButtonWidget: null));
       }

       drawerList.add(DrawerModel(widget: const AddClearingGradingPage(), icon: Icons.auto_graph,
           label: AppString.clearingGrading, sublist: [],  isSelected: false, actionButtonWidget: null));*/

/*       drawerList.add(DrawerModel(widget: const AddSoilResistivityPage(), icon: Icons.account_tree_outlined,
           label: AppString.soilResistivity, sublist: [],  isSelected: false, actionButtonWidget: null));*/

       drawerList.add(DrawerModel(widget: const AddTrenChingPage(), icon: Icons.comment_bank_outlined,
           label: AppString.trenChing, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddStringingPage(), icon: Icons.stream,
           label: AppString.stringing, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddCutPipePage(), icon: Icons.panorama_horizontal_rounded,
          label: AppString.cutPipe, sublist: [],  isSelected: false, actionButtonWidget: _restoreActionWidget(context: context.mounted ? context :context)));

      drawerList.add(DrawerModel(widget: const AddWeldingPage(), icon: Icons.transgender_outlined,
          label: AppString.welding, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddRadioGraphyPage(), icon: Icons.graphic_eq,
          label: AppString.radiography, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddNdtMutPage(), icon: Icons.nearby_error_rounded,
          label: AppString.ndtMut, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddJointCoatingPage(), icon: Icons.join_inner_outlined,
          label: AppString.jointCoating, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddLoweringPage(), icon: Icons.bookmark_added_outlined,
          label: AppString.lowering, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddHdpeDuctPage(), icon: Icons.padding_outlined,
          label: AppString.hdpeDuctLaying, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddDptPage(), icon: Icons.dashboard_customize_outlined,
          label: AppString.dpt, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddBackFillingPage(), icon: Icons.newspaper,
          label: AppString.backFilling, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddCrossingPage(), icon: Icons.format_line_spacing_sharp,
          label: AppString.crossing, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddMarkerPage(), icon: Icons.location_disabled,
          label: AppString.marker, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddPreHydroTestPage(), icon: Icons.precision_manufacturing,
          label: AppString.preHydrotest, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddPostHydroTestPage(), icon: Icons.fire_hydrant_alt_outlined,
          label: AppString.postHydrotest, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddHydroTestPage(), icon: Icons.fire_hydrant,
          label: AppString.hydrotest, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddMollingPage(), icon: Icons.auto_awesome_mosaic_outlined,
          label: AppString.molling, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddSwabbingPage(), icon: Icons.swap_horizontal_circle_outlined,
          label: AppString.swabbing, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddValveChamberPage(), icon: Icons.calendar_view_month_sharp,
          label: AppString.valveChamber, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddSteelStructurePage(), icon: Icons.streetview,
          label: AppString.steelStructure, sublist: [],  isSelected: false, actionButtonWidget: null));

/*        drawerList.add(DrawerModel(widget: const AddBendingPage(), icon: Icons.webhook_rounded,
            label: AppString.bending, sublist: [],  isSelected: false, actionButtonWidget: null));*/

    /*  drawerList.add(DrawerModel(widget: const AddWeldingPage(), icon: Icons.transgender_outlined,
          label: AppString.welding, sublist: [],  isSelected: false, actionButtonWidget: null));


        drawerList.add(DrawerModel(widget: const AddWelderRepairPage(), icon: Icons.tire_repair_sharp,
            label: AppString.weldRepair, sublist: [],  isSelected: false, actionButtonWidget: null));


      drawerList.add(DrawerModel(widget: const AddLptPage(), icon: Icons.local_play_outlined,
          label: AppString.lpt, sublist: [],  isSelected: false, actionButtonWidget: null));

        drawerList.add(DrawerModel(widget: const AddNdtAutPage(), icon: Icons.auto_awesome_mosaic_outlined,
            label: AppString.ndtAut, sublist: [],  isSelected: false, actionButtonWidget: null));


        drawerList.add(DrawerModel(widget: const AddConcreteCoatingPage(), icon: Icons.business,
            label: AppString.concreteCoating, sublist: [],  isSelected: false, actionButtonWidget: null));


        drawerList.add(DrawerModel(widget: const AddHDPEDuctTestingPage(), icon: Icons.pages_outlined,
            label: AppString.hdpeDuctTesting, sublist: [],  isSelected: false, actionButtonWidget: null));


        drawerList.add(DrawerModel(widget: const AddOfcSplicingPage(), icon: Icons.offline_share,
            label: AppString.ofcSplicing, sublist: [],  isSelected: false, actionButtonWidget: null));


      drawerList.add(DrawerModel(widget: const AddLevellingPage(), icon: Icons.file_present,
          label: AppString.levelling, sublist: [],  isSelected: false, actionButtonWidget: null));


        drawerList.add(DrawerModel(widget: const AddRestorationPage(), icon: Icons.present_to_all_sharp,
            label: AppString.restoration, sublist: [],  isSelected: false, actionButtonWidget: null));

        drawerList.add(DrawerModel(widget: const AddDryingPage(), icon: Icons.dry_outlined,
            label: AppString.drying, sublist: [],  isSelected: false, actionButtonWidget: null));
*/
       return drawerList;
    }catch(e){
      return null;
    }
  }


  static Widget _restoreActionWidget({required BuildContext context}) {
    return Row(
      children: [
        TextButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  RestoreCutPipePage()));
        }, child: TextWidget(AppString.restore, color: AppColor.white,)),
      ],
    );
  }

  static Future<dynamic> fetchSystemAdminSubList() async {

    try{
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
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> fetchAppBottomBarItems({required BuildContext context, 
            required RoleType appModule}) async {
     try{
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
     }catch(e){
       SnackBarErrorWidget(context).show(message: "Bottom Bar Error");
       return null;
     }
  }

  static Future<dynamic> fetchPageWidgets({required BuildContext context,
    required RoleType appModule}) async {
    try{
      List<Widget> pageWidgetList = [];
      return pageWidgetList;
    }catch(e){
      SnackBarErrorWidget(context).show(message: "Page Widget Error");
      return null;
    }
  }

}