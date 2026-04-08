import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'input_decoration_style.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final String labelText;
  final bool enabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final int? maxLength;
  final int maxLine;
  final Widget? suffixIcon;
  final bool isRequired;

  const TextFieldWidget({
    super.key,
    required this.labelText,
    this.enabled = true,
    this.readOnly = false,
    this.controller,
    this.onTap,
    this.onChanged,
    this.textInputType,
    this.maxLength,
    this.suffixIcon,
    this.maxLine = 1,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLine,

      style: TextStyle(
        fontSize: AppFont.font_14,
        color: AppColor.black,
      ),

      /// ✅ INPUT FORMATTER (optimized)
      inputFormatters: _getInputFormatter(),

      /// ✅ KEYBOARD TYPE FIX (cleaned logic)
      keyboardType: _getKeyboardType(),

      /// ✅ USE COMMON DECORATION
      decoration:  InputDecorationStyle.inputDecoration(
        context,
        labelText: labelText,
        isRequired: isRequired,
      ).copyWith(
        /// only override what is specific
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        // contentPadding: EdgeInsets.symmetric(
        //   horizontal: 10,
        //   vertical: maxLine > 1 ? 12 : 8,
        // ),
        counterText: "", // removes maxLength counter if needed
      ),
    );
  }

  /// 🔹 Extracted formatter logic (clean)
  List<TextInputFormatter>? _getInputFormatter() {
    if (textInputType == TextInputType.number) {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
      ];
    }
    return null;
  }

  /// 🔹 Clean keyboard handling
  TextInputType _getKeyboardType() {
    if (textInputType == null) return TextInputType.text;

    if (Platform.isIOS && textInputType == TextInputType.number) {
      return const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      );
    }

    return textInputType!;
  }
}