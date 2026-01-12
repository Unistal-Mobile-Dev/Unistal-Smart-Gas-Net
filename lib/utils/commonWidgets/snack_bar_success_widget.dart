import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class SnackBarSuccessWidget {
  final BuildContext context;

  SnackBarSuccessWidget(this.context);

  show({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: TextWidget(
        message,
        fontSize: AppFont.font_14,
        color: AppColor.white,
      ),
      backgroundColor: EnvironmentConfig.of(context)!.primaryTheme,
    ));
  }
}
