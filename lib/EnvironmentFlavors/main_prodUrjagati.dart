import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/root.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/enums.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var environmentConfig = EnvironmentConfig(
    flavours: EnvironmentFlavours.prodUrjagati,
    child: Root(client: Client.urjagati),
  );
  runApp(environmentConfig);
}