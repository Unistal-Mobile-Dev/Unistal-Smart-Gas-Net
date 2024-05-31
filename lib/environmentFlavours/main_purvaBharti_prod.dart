import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/root.dart';
import 'package:flutter_unistal_smart_gas_net/utils/hive/hive_database.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*  await HiveDataBase().init();*/
  var configuredApp = const EnvironmentConfig(
      flavours: EnvironmentFlavours.productionPurvaBharti,
      child: Root(
        client: Client.purvaBharti,
      ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(configuredApp);
}
