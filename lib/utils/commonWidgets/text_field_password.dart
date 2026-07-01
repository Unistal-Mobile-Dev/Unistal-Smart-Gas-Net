import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class TextFieldPasswordWidget extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final bool? obscureText;
  final bool? isPasswordIcon;
  final TextInputType? inputType;
  final int? maxLength;
  final VoidCallback? passwordOnPressed;
  final GestureTapCallback? onTap;
  final bool? enabled;
  final bool? isRequired;

  const TextFieldPasswordWidget(
      {super.key,
        required this.labelText,
        this.hintText,
        this.textEditingController,
        this.obscureText,
        this.onChanged,
        this.inputType,
        this.isPasswordIcon,
        this.maxLength,
        this.passwordOnPressed,
        this.onTap,
        this.enabled,
        this.isRequired});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;

// ✅ Theme-aware colors
    final fillColor = isDark
        ? theme.colorScheme.surfaceContainerHighest
        : Colors.white;
    final textColor = theme.colorScheme.onSurface;
    final iconColor = theme.colorScheme.onSurfaceVariant; // ✅ was AppColor.grey

    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        onTap: onTap,
        enabled: enabled ?? true,
        maxLength: maxLength,
        onChanged: onChanged,
        keyboardType: inputType ?? TextInputType.text,
        controller: textEditingController,
        obscureText: obscureText ?? false,
        style: TextStyle(
          fontSize: AppFont.font_14,
          color: textColor, // ✅ typed text color
        ),
        decoration: InputDecoration(
          label: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: labelText,
                  style: TextStyle(
                    fontSize: AppFont.font_14,
                    color: textColor, // ✅ label color
                  ),
                ),
                TextSpan(
                  text: isRequired == true ? ' *' : "",
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          labelStyle: TextStyle(
            fontSize: AppFont.font_14,
            color: primaryColor,
          ),
          floatingLabelStyle: TextStyle(
            fontSize: AppFont.font_12,
            color: primaryColor, // ✅ when focused/floating
          ),
          fillColor: fillColor, // ✅ was Colors.white
          filled: true,
          contentPadding: const EdgeInsets.all(15),

// ✅ Consistent borders matching InputDecorationStyle
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? primaryColor.withOpacity(0.6) : primaryColor,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
            ),
          ),

          suffixIcon: isPasswordIcon != null
              ? IconButton(
            onPressed: passwordOnPressed,
            icon: Icon(
              obscureText == true
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: iconColor, // ✅ was AppColor.grey
            ),
          )
              : null,
        ),
      ),
    );
  }
}