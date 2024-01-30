
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/bloc/add_back_filling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/bloc/add_bending_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/domain/bloc/dashboard_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/drying/addDrying/domain/bloc/add_drying_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/domain/bloc/forgot_password_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeduct/addHDPEDuct/domain/bloc/add_hdpe_duct_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/levelling/addLevelling/domain/bloc/add_levelling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/bloc/add_lowering_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/domain/bloc/add_ofc_splicing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/domain/bloc/add_restoration_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/domain/add_rou_handover_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/bloc/add_route_survey_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/domain/bloc/add_soil_resistivity_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/splashScreen/page/splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/bloc/add_stringing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/bloc/add_tren_ching_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/bloc/add_welding_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:provider/provider.dart';
import 'ExportFile/app_export_file.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications',
    importance: Importance.high,
    playSound: true);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

   MaterialColor primaryColor =  MaterialColor(
     0xFF308133,
     <int, Color>{
       50: AppColor.themeColor,
       100: AppColor.themeColor,
       200: AppColor.themeColor,
       300: AppColor.themeColor,
       400: AppColor.themeColor,
       500: AppColor.themeColor,
       600: AppColor.themeColor,
       700: AppColor.themeColor,
       800: AppColor.themeColor,
       900: AppColor.themeColor,
    },
  );

  MaterialColor primarySwatch =  MaterialColor(
    0xFF308133,
    <int, Color>{
      50: AppColor.themeLightColor,
      100: AppColor.themeLightColor,
      200: AppColor.themeLightColor,
      300: AppColor.themeLightColor,
      400: AppColor.themeLightColor,
      500: AppColor.themeLightColor,
      600: AppColor.themeLightColor,
      700: AppColor.themeLightColor,
      800: AppColor.themeLightColor,
      900: AppColor.themeLightColor,
    },
  );

  @override
  Widget build(BuildContext context) {
    Singleton.instanceInit()?.context =  context;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    AppConfig.instanceInit()!.setClient(client: widget.client);
    return MultiProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginBloc()),
        BlocProvider(create: (BuildContext context) => ForgotPasswordBloc()),
        BlocProvider(create: (BuildContext context) => HomeBloc()),
        BlocProvider(create: (BuildContext context) => DashboardBloc()),
        BlocProvider(create: (BuildContext context) => AddRouteSurveyBloc()),
        BlocProvider(create: (BuildContext context) => AddClearingGradingBloc()),
        BlocProvider(create: (BuildContext context) => AddSoilResistivityBloc()),
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
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Apna App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: AppFont.rubik,
          appBarTheme: AppBarTheme(
            color: AppColor.themeLightColor,
            iconTheme: const IconThemeData(
                color: Colors.white
            ),
            foregroundColor: AppColor.themeColor,
          ),
          primaryColor: primaryColor,
          primarySwatch: primarySwatch,
        ),
        home: const SplashScreen(),
      ),
    );
  }

}
