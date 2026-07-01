import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'input_decoration_style.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
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
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextFieldWidget({
    super.key,
    required this.labelText,
    this.enabled = true,
    this.readOnly = false,
    this.controller,
    this.initialValue,
    this.onTap,
    this.onChanged,
    this.textInputType,
    this.maxLength,
    this.suffixIcon,
    this.maxLine = 1,
    this.isRequired = false,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final textColor = Theme
        .of(context)
        .colorScheme
        .onSurface; // ✅ auto light/dark

    // ✅ Dynamic fill colors based on theme
    final enabledFill = isDark
        ? Theme
        .of(context)
        .colorScheme
        .surfaceContainerHighest
        : Colors.white;
    final disabledFill = isDark
        ? Theme
        .of(context)
        .colorScheme
        .surfaceContainerHighest
        .withOpacity(0.4)
        : Colors.grey.shade100;

    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLine,

      // ✅ Theme-aware text color
      style: TextStyle(
        fontSize: AppFont.font_14,
        color: textColor,
      ),

      inputFormatters: _getInputFormatter(),
      keyboardType: _getKeyboardType(),

      decoration: InputDecorationStyle.inputDecoration(
        context,
        labelText: labelText,
        isRequired: isRequired,
      ).copyWith(
        fillColor: enabled ? enabledFill : disabledFill,
        counterText: "",
      ),
    );
  }

  List<TextInputFormatter>? _getInputFormatter() {
    if (textInputType == TextInputType.number) {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
      ];
    }
    return null;
  }

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