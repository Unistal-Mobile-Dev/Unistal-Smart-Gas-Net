import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/bloc/add_back_filling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/bloc/add_bending_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/bloc/add_concrete_coating_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/bloc/add_crossing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/addCutPipe/domain/bloc/add_cut_pipe_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/restoreCutePipe/domain/bloc/restore_cut_pipe_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/domain/bloc/dashboard_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/drying/addDrying/domain/bloc/add_drying_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/domain/bloc/forgot_password_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeDutTesting/addHDPEDuctTesting/domain/bloc/add_hdpe_duct_testing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/domain/bloc/add_hdpe_duct_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/domain/bloc/add_hydrotest_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/bloc/add_joint_coating_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/levelling/addLevelling/domain/bloc/add_levelling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/bloc/add_lowering_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/domain/bloc/add_lpt_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/bloc/add_ndt_aut_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/bloc/add_ndt_mut_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/domain/bloc/add_ofc_splicing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/postHydrotest/addPostHydrotest/domain/bloc/add_post_hydrotest_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/preHydrotest/addPreHydrotest/domain/bloc/add_pre_hydrotest_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/bloc/add_radiography_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/domain/bloc/add_restoration_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/domain/add_rou_handover_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/bloc/add_route_survey_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/domain/bloc/add_soil_resistivity_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/splashScreen/page/splash_screen.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/bloc/add_stringing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/swabbing/addSwabbing/domain/bloc/add_swabbing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/tieIn/addTiein/domain/bloc/add_tiein_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/bloc/add_tren_ching_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/domain/bloc/add_welder_repair_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/bloc/add_welding_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';
import 'package:provider/provider.dart';

import 'ExportFile/app_export_file.dart';
import 'feature/HDD/hddCleanPass/addHDDCleanPass/domain/bloc/add_hdd_clean_pass_bloc.dart';
import 'feature/HDD/hddCrossing/addHDDCrossing/domain/bloc/add_hdd_crossing_bloc.dart';
import 'feature/HDD/hddPulling/addHDDPulling/domain/bloc/add_hdd_pulling_bloc.dart';
import 'feature/HDD/hddReaming/addHDDReaming/domain/bloc/add_hdd_reaming_bloc.dart';
import 'feature/HDD/pilotDrill/addPilotDrill/domain/bloc/add_pilot_drill_bloc.dart';
import 'feature/TCP/cableInstallation/addCableInstallation/domain/bloc/add_cable_installation_bloc.dart';
import 'feature/TCP/pinBrazzing/addPinBrazzing/domain/bloc/add_pin_brazzing_bloc.dart';
import 'feature/TCP/polarisationCoupan/addPolarisationCoupan/domain/bloc/add_polarisation_coupan_bloc.dart';
import 'feature/TCP/sacrificialAnode/addSacrificialAnode/domain/bloc/add_sacrificial_anode_bloc.dart';
import 'feature/TCP/ssd/addSSD/domain/bloc/add_ssd_bloc.dart';
import 'feature/TCP/surgeDiverter/addSurgeDiverter/domain/bloc/add_surge_diverter_bloc.dart';
import 'feature/TCP/testStationBoxs/addTestStationBoxs/domain/bloc/add_test_station_box_bloc.dart';
import 'feature/TCP/thermitWeld/addThermitWeld/domain/bloc/add_thermit_weld_bloc.dart';
import 'feature/TCP/znGroundingAnode/addZnGroundingAnode/domain/bloc/add_zn_grounding_anode_bloc.dart';
import 'feature/section_id/domain/bloc/section_id_bloc.dart';

class Root extends StatefulWidget {
  final Client client;

  const Root({super.key, required this.client});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  // MaterialColor primaryColor = MaterialColor(
  //   AppColor.theme_Color,
  //   <int, Color>{
  //     50: AppColor.themeColor,
  //     100: AppColor.themeColor,
  //     200: AppColor.themeColor,
  //     300: AppColor.themeColor,
  //     400: AppColor.themeColor,
  //     500: AppColor.themeColor,
  //     600: AppColor.themeColor,
  //     700: AppColor.themeColor,
  //     800: AppColor.themeColor,
  //     900: AppColor.themeColor,
  //   },
  // );
  //
  // MaterialColor primarySwatch = MaterialColor(
  //   AppColor.theme_LightColor,
  //   <int, Color>{
  //     50: AppColor.themeLightColor,
  //     100: AppColor.themeLightColor,
  //     200: AppColor.themeLightColor,
  //     300: AppColor.themeLightColor,
  //     400: AppColor.themeLightColor,
  //     500: AppColor.themeLightColor,
  //     600: AppColor.themeLightColor,
  //     700: AppColor.themeLightColor,
  //     800: AppColor.themeLightColor,
  //     900: AppColor.themeLightColor,
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    Singleton.instanceInit()?.context = context;
   /* SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));*/
    AppConfig.instanceInit()!.setClient(client: widget.client);

    return MultiProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginBloc()),
        BlocProvider(create: (BuildContext context) => ForgotPasswordBloc()),
        BlocProvider(create: (BuildContext context) => HomeBloc()),
        BlocProvider(create: (BuildContext context) => DashboardBloc()),
        BlocProvider(create: (BuildContext context) => AddRouteSurveyBloc()),
        BlocProvider(
            create: (BuildContext context) => AddClearingGradingBloc()),
        BlocProvider(
            create: (BuildContext context) => AddSoilResistivityBloc()),
        BlocProvider(create: (BuildContext context) => AddRouHandoverBloc()),
        BlocProvider(create: (BuildContext context) => AddTrenChingBloc()),
        BlocProvider(create: (BuildContext context) => AddStringingBloc()),
        BlocProvider(create: (BuildContext context) => AddBendingBloc()),
        BlocProvider(create: (BuildContext context) => AddWeldingBloc()),
        BlocProvider(create: (BuildContext context) => AddBackFillingBloc()),
        BlocProvider(create: (BuildContext context) => AddLoweringBloc()),
        BlocProvider(create: (BuildContext context) => AddHdpeDuctBloc()),
        BlocProvider(create: (BuildContext context) => AddOfcSplicingBloc()),
        BlocProvider(create: (BuildContext context) => AddRestorationBloc()),
        BlocProvider(create: (BuildContext context) => AddLevellingBloc()),
        BlocProvider(create: (BuildContext context) => AddDryingBloc()),
        BlocProvider(create: (BuildContext context) => AddRadiographyBloc()),
        BlocProvider(create: (BuildContext context) => AddNdtMutBloc()),
        BlocProvider(create: (BuildContext context) => AddLptBloc()),
        BlocProvider(create: (BuildContext context) => AddCutPipeBloc()),
        BlocProvider(create: (BuildContext context) => RestoreCutPipeBloc()),
        BlocProvider(
            create: (BuildContext context) => AddConcreteCoatingBloc()),
        BlocProvider(create: (BuildContext context) => AddPostHydrotestBloc()),
        BlocProvider(create: (BuildContext context) => AddPreHydrotestBloc()),
        BlocProvider(create: (BuildContext context) => AddHydrotestBloc()),
        BlocProvider(
            create: (BuildContext context) => AddHdpeDuctTestingBloc()),
        BlocProvider(create: (BuildContext context) => AddSwabbingBloc()),
        BlocProvider(create: (BuildContext context) => AddWelderRepairBloc()),
        BlocProvider(create: (BuildContext context) => AddNdtAutBloc()),
        BlocProvider(create: (BuildContext context) => AddJointCoatingBloc()),
        BlocProvider(create: (BuildContext context) => AddCrossingBloc()),
        BlocProvider(create: (BuildContext context) => AddTieinBloc()),
        BlocProvider(create: (BuildContext context) => AddHddCleanPassBloc()),
        BlocProvider(create: (BuildContext context) => AddHddCrossingBloc()),
        BlocProvider(create: (BuildContext context) => AddHddPullingBloc()),
        BlocProvider(create: (BuildContext context) => AddHddReamingBloc()),
        BlocProvider(create: (BuildContext context) => AddPilotDrillBloc()),
        BlocProvider(create: (BuildContext context) => AddCableInstallationBloc()),
        BlocProvider(create: (BuildContext context) => AddPinBrazzingBloc()),
        BlocProvider(create: (BuildContext context) => AddPolarisationCoupanBloc()),
        BlocProvider(create: (BuildContext context) => AddSacrificialAnodeBloc()),
        BlocProvider(create: (BuildContext context) => AddSurgeDiverterBloc()),
        BlocProvider(create: (BuildContext context) => AddTestStationBoxBloc()),
        BlocProvider(create: (BuildContext context) => AddThermitWeldBloc()),
        BlocProvider(create: (BuildContext context) => AddZnGroundingAnodeBloc()),
        BlocProvider(create: (BuildContext context) => AddSsdBloc()),
        BlocProvider(create: (BuildContext context) => SectionIdBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Smart Gas Net",
        theme: ThemeData(
          primaryColor: EnvironmentConfig.of(context)!.primaryTheme,
          hintColor: EnvironmentConfig.of(context)!.primaryTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: EnvironmentConfig.of(context)!.primaryTheme,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
