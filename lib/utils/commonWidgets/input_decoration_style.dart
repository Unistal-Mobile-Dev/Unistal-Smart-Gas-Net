import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_font.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class InputDecorationStyle {
  static InputDecoration inputDecoration(
      BuildContext context, {
        String? labelText,
        bool isRequired = false,
        Widget? suffixIcon,
        IconData? prefixIcon,
      }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto, // 👈 add this
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),

      prefixIcon: prefixIcon != null
          ? Icon(
        prefixIcon,
        color: EnvironmentConfig.of(context)!.primaryTheme,
      )
          : null,

      suffixIcon: suffixIcon,

      label: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: labelText ?? '',
              style: TextStyle(
              //  color: EnvironmentConfig.of(context)!.primaryTheme,
              //  fontSize: AppFont.font_14,
              ),
            ),
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),

      hintText: labelText,
      hintStyle: TextStyle(
        color: AppColor.black,
        fontSize: AppFont.font_14,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: TextStyle(
        color: AppColor.black,
        fontSize: AppFont.font_14,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: EnvironmentConfig.of(context)!.primaryTheme,
          width: 1.2,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: EnvironmentConfig.of(context)!.primaryTheme,
          width: 1.2,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: EnvironmentConfig.of(context)!.primaryTheme,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }


}