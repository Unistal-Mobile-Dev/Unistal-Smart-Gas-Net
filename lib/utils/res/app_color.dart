import 'package:flutter/material.dart';

class AppColor {

  static dynamic themeColor0 = 0xFF308133;
  static dynamic themeLightColor0 = 0xFF59a65c;

  AppColor({required dynamic themeColor, required dynamic themeLightColor}){
    themeColor0 =  themeColor;
    themeLightColor0 =  themeLightColor;
  }

  static get themeColor => Color(themeColor0);
  static get themeLightColor => Color(themeLightColor0);

  static get grey => Colors.grey;
  static get lightGrey => Colors.black12;
  static get black => Colors.black;
  static get white => Colors.white;
  static get red => Colors.red;
  static get cardBlue => const Color(0xFF48A9F8);
  static get cardGreen => const Color(0xFF1BD084);
  static get cardLightGreen => const Color(0xFF8BC740);

  static get themeSecondary => const Color(0xFFea8e11);
}