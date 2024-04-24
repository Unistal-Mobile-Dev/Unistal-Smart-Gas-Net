import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/root.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/hive/hive_database.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*  await HiveDataBase().init();*/
  AppColor(themeColor: 0xFF1269AC,
      themeLightColor: 0xFF278AD7);
  var configuredApp = const EnvironmentConfig(
      flavours: EnvironmentFlavours.developmentAgcl,
      child: Root(client: Client.agcl,)
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom
  ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(configuredApp);
}
