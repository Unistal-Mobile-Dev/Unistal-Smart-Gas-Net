import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class DottedLoaderWidget extends StatelessWidget {
  const DottedLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double size = AppConfig.getDeviceType(context: context) == DeviceType.phone
        ? MediaQuery.of(context).size.width * 0.12
        : MediaQuery.of(context).size.width * 0.05;
    return SpinKitThreeInOut(
      color: EnvironmentConfig.of(context)!.primaryTheme,
      size: size,
    );
  }
}
