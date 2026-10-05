import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/helper/offline_auto_sync.dart';
import 'package:flutter_unistal_smart_gas_net/root.dart';
import 'package:flutter_unistal_smart_gas_net/utils/HiveDatabase/hive_database.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/enums.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDataBase().init();
  OfflineAutoSync.start();
  var environmentConfig = EnvironmentConfig(
    flavours: EnvironmentFlavours.prodUrjagati,
    child: Root(client: Client.urjagati),
  );
  runApp(environmentConfig);
}