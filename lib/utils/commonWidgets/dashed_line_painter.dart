import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class WaveLoaderWidget extends StatelessWidget {
  const WaveLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double size = AppConfig.getDeviceType(context: context) == DeviceType.phone
        ? MediaQuery.of(context).size.width * 0.10
        : MediaQuery.of(context).size.width * 0.05;
    return Center(
      child: SpinKitWaveSpinner(
        color: EnvironmentConfig.of(context)!.primaryTheme,
        size: size,
      ),
    );
  }
}
