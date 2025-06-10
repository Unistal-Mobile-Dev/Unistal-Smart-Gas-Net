import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/root.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var configuredApp = const EnvironmentConfig(
    flavours: EnvironmentFlavours.productionMgl,
    child: Root(
      client: Client.mgl,
    ),
  );


  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(configuredApp);
}
