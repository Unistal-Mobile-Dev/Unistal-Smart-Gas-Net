import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/root.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*  await HiveDataBase().init();*/
 // AppColor(themeColor: 0xFF0077bd, themeLightColor: 0xFF1AABFF);
  var configuredApp = const EnvironmentConfig(
      flavours: EnvironmentFlavours.prodVRPL,
      child: Root(
        client: Client.vrpl,
      ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(configuredApp);
}
