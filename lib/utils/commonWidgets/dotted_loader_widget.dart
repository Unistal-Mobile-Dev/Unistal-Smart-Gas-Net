import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class DottedLoaderWidget extends StatelessWidget {
  const DottedLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = AppConfig.getDeviceType(context: context) == DeviceType.phone
        ? MediaQuery.of(context).size.width * 0.12
        : MediaQuery.of(context).size.width * 0.05;
    return SpinKitThreeInOut(
      color: AppColor.themeColor,
      size: size,
    );
  }
}
