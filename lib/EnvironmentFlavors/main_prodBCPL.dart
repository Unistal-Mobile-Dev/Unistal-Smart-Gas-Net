import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/root.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/enums.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var environmentConfig = EnvironmentConfig(
    flavours: EnvironmentFlavours.prodBCPL,
    child: Root(client: Client.bcpl),
  );
  runApp(environmentConfig);
}

