import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/feature/splashScreen/page/splash_screen.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/multi_provider_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_navigator.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';
import 'ExportFile/app_export_file.dart';
import 'utils/res/app_theme.dart';

class Root extends StatefulWidget {
  final Client client;

  const Root({super.key, required this.client});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppConfig.init(context);
    ServerRequest.init();
    AppConfig.instanceInit()!.setClient(client: widget.client);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: EnvironmentConfig.of(context)?.primaryTheme,
      ),
    );
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // listen for system changes
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) setState(() {}); // rebuild when dark/light toggles
    super.didChangePlatformBrightness();
  }


  @override
  Widget build(BuildContext context) {
    final primary = EnvironmentConfig.of(context)!.primaryTheme;
    final secondary = EnvironmentConfig.of(context)!.secondaryTheme;
    Singleton.instanceInit()?.context = context;
    AppConfig.instanceInit()!.setClient(client: widget.client);

    return multiBlocProvider(
      child: MaterialApp(
        navigatorKey: AppNavigator.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Steel",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primary,
          hintColor: primary,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primary,
            brightness: Brightness.light,
            primary: primary,
            secondary: secondary,
          ),
        ),

        // ✅ Dark theme (was missing!)
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: primary,
          hintColor: primary,
          scaffoldBackgroundColor: const Color(0xFF121212),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primary,
            brightness: Brightness.dark,
            primary: primary,
            secondary: secondary,
          ),
        ),

        // ✅ Follows system dark/light setting
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
