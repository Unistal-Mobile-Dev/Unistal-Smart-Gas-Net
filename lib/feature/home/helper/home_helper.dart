import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/bloc/add_back_filling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/page/add_back_filling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/bloc/add_bending_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/presentation/page/add_bending_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/presentation/page/add_clearing_grading_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/drying/addDrying/presentation/page/add_drying_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeduct/addHDPEDuct/persentation/page/add_hdpe_duct_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/levelling/addLevelling/presentation/page/add_levelling_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/presentation/page/add_lpt_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/persentation/page/add_ndt_mut_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/persentation/page/add_ofc_splicing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/persentation/page/add_radiography_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/presentation/page/add_restoration_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/domain/add_rou_handover_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/presentation/page/add_rou_handover_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/bloc/add_route_survey_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/presentation/page/route_survey_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/domain/bloc/add_soil_resistivity_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/presentation/page/add_soil_resistivity_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/bloc/add_stringing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/presentation/page/add_stringing_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/bloc/add_tren_ching_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/presentation/page/add_tren_ching_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/bloc/add_welding_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/presentation/page/add_welding_page.dart';

class HomeHelper {


  static Future<dynamic> fetchDrawerList({required BuildContext context}) async {

    try{
       List<DrawerModel> drawerList = [];
       drawerList.add(DrawerModel(widget: const DashboardPage(), icon: Icons.home_outlined,
           label: AppString.dashboard, sublist: [], isSelected: true));

       List<DrawerSubModel> systemAdminList = await fetchSystemAdminSubList();

       drawerList.add(DrawerModel(widget: const AddRouteSurveyPage(), icon: Icons.alt_route_sharp,
           label: AppString.routeSurvey, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddRouHandoverPage(), icon: Icons.handshake_outlined,
           label: AppString.rouHandover, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddClearingGradingPage(), icon: Icons.auto_graph,
           label: AppString.clearingGrading, sublist: [],  isSelected: false, actionButtonWidget: null));

/*       drawerList.add(DrawerModel(widget: const AddSoilResistivityPage(), icon: Icons.account_tree_outlined,
           label: AppString.soilResistivity, sublist: [],  isSelected: false, actionButtonWidget: null));*/

       drawerList.add(DrawerModel(widget: const AddTrenChingPage(), icon: Icons.comment_bank_outlined,
           label: AppString.trenChing, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddStringingPage(), icon: Icons.stream,
           label: AppString.stringing, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddBendingPage(), icon: Icons.webhook_rounded,
           label: AppString.bending, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddWeldingPage(), icon: Icons.transgender_outlined,
           label: AppString.welding, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddRadioGraphyPage(), icon: Icons.graphic_eq,
          label: AppString.radiography, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddNdtMutPage(), icon: Icons.nearby_error_rounded,
          label: AppString.ndtMut, sublist: [],  isSelected: false, actionButtonWidget: null));

      drawerList.add(DrawerModel(widget: const AddLptPage(), icon: Icons.local_play_outlined,
          label: AppString.lpt, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddHdpeDuctPage(), icon: Icons.padding_outlined,
           label: AppString.hdpeDuctLaying, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddBackFillingPage(), icon: Icons.newspaper,
           label: AppString.backFilling, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddOfcSplicingPage(), icon: Icons.offline_share,
           label: AppString.ofcSplicing, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddLevellingPage(), icon: Icons.file_present,
           label: AppString.levelling, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddRestorationPage(), icon: Icons.present_to_all_sharp,
           label: AppString.restoration, sublist: [],  isSelected: false, actionButtonWidget: null));

       drawerList.add(DrawerModel(widget: const AddDryingPage(), icon: Icons.dry_outlined,
           label: AppString.drying, sublist: [],  isSelected: false, actionButtonWidget: null));

/*       drawerList.add(DrawerModel(widget: Container(), icon: Icons.layers_outlined,
           label: AppString.serviceCenter, sublist: serviceCenterList,  isSelected: false));*/

       return drawerList;
    }catch(e){
      return null;
    }
  }


  static Widget _rousurveyInsertAction({required BuildContext context}) {
    return Row(
      children: [
         IconButton(onPressed: () {
           BlocProvider.of<AddRouteSurveyBloc>(context).add(AddRouteSurveyPageLoadEvent(context: context));
           Navigator.push(context,
               MaterialPageRoute(builder: (_) => const  AddRouteSurveyPage()));
         }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _bendingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddBendingBloc>(context).add(AddBendingPageLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddBendingPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _weldingActionButton({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddWeldingBloc>(context).add(AddWeldingPageLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddWeldingPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _backFillingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddBackFillingBloc>(context).add(AddBackFillingPageLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddBackFillingPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }


  static Widget _clearingGradingAction({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddClearingGradingBloc>(context).add(AddClearingGradingPageLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddClearingGradingPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _soilresistivityinsertActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddSoilResistivityBloc>(context).add(AddSoilResistivityPageLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddSoilResistivityPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _rouHandoverActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddRouHandoverBloc>(context).add(AddRouHandoverLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddRouHandoverPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _trenchingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddTrenChingBloc>(context).add(AddTrenChingPageLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddTrenChingPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }

  static Widget _stringingActionWidget({required BuildContext context}) {
    return Row(
      children: [
        IconButton(onPressed: () {
          BlocProvider.of<AddStringingBloc>(context).add(AddStringingPageLoadEvent(context: context));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const  AddStringingPage()));
        }, icon: const Icon(Icons.add)),

        IconButton(onPressed: () {

        }, icon: const Icon(Icons.filter_alt_outlined)),
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