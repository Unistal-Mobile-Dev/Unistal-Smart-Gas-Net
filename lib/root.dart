import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/splashScreen/page/splash_screen.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/multi_provider_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';
import 'ExportFile/app_export_file.dart';
import 'utils/res/app_theme.dart';

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

  @override
  Widget build(BuildContext context) {
    final primary = EnvironmentConfig.of(context)!.primaryTheme;
    Singleton.instanceInit()?.context = context;
   /* SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));*/
    AppConfig.instanceInit()!.setClient(client: widget.client);

    return multiBlocProvider(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        // title: "Steel",
        // theme: ThemeData(
        //   primaryColor: EnvironmentConfig.of(context)!.primaryTheme,
        //   hintColor: EnvironmentConfig.of(context)!.primaryTheme,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        //   useMaterial3: true,
        //   colorScheme: ColorScheme.fromSeed(
        //     seedColor: EnvironmentConfig.of(context)!.primaryTheme,
        //   ),
        // ),
        theme: AppTheme.lightTheme(primary),
        darkTheme: AppTheme.darkTheme(primary),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
