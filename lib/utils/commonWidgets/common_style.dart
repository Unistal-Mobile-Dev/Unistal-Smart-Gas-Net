import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/singleton.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class CommonStyle {
  static BuildContext? context = Singleton.instanceInit()?.context;

  static TextStyle text = TextStyle(
      fontSize: 14,
      color: EnvironmentConfig.of(context!)!.primaryTheme,);

  static TextStyle labels = TextStyle(

      fontSize: 14,
      color:EnvironmentConfig.of(context!)!.primaryTheme,
  );

  static TextStyle texts = const TextStyle(
      fontSize: 14, color: Colors.black);

  static TextStyle stars = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red);
  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
        color: EnvironmentConfig.of(context!)!.primaryTheme, style: BorderStyle.solid, width: 0.80),
  );

  static OutlineInputBorder borderGrey = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide:
        BorderSide(color: AppColor.grey, style: BorderStyle.solid, width: 0.80),
  );

  static OutlineInputBorder borderRed = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide:
        BorderSide(color: AppColor.red, style: BorderStyle.solid, width: 0.80),
  );

  static Widget vertical({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }

  static Widget widthSpace({required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.016,
    );
  }





}
