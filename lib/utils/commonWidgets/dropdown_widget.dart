import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_font.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

import 'input_decoration_style.dart';

class DropdownWidget<T> extends StatelessWidget {
  final String hint;
  final bool isRequired;
  final T? dropdownValue;
  final List<T> items;
  final Function(T?) onChanged;
  final String? Function(T?)? validator;
  final VoidCallback? onPressed;

  const DropdownWidget({
    super.key,
    required this.hint,
    this.isRequired = false,
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
    this.validator,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: items.contains(dropdownValue) ? dropdownValue : null,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecorationStyle.inputDecoration(
        context,
        labelText: hint,
        isRequired: isRequired,
        suffixIcon: (onPressed != null && dropdownValue != null)
            ? IconButton(
          icon: const Icon(Icons.clear, size: 20),
          onPressed: onPressed,
        )
            : null,
      ),
      dropdownColor: Colors.white,
      isExpanded: true,
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString(), style: TextStyle(
            color: AppColor.black,
            fontSize: AppFont.font_14,
            fontWeight: FontWeight.w500,
          ),),
        );
      }).toList(),
    );
  }
}