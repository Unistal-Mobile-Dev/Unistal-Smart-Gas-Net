import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class DropdownWidget<T> extends StatelessWidget {
  final T? dropdownValue;
  final String hint;
  final String? label;
  final String? star;
  final void Function(T?)? onChanged;
  final List<T> items;
  final bool isEditable;
  final String? Function(T?)? validator;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final bool? isRequired;
  final VoidCallback? onPressed;

  const DropdownWidget({
    super.key,
    this.dropdownValue,
    required this.hint,
    this.label,
    this.star,
    this.onChanged,
    required this.items,
    this.isEditable = true,
    this.validator,
    this.selectedItemBuilder,
    this.isRequired,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: dropdownValue,
      onChanged: isEditable ? onChanged : null,
      validator: validator,
      isExpanded: true,
      decoration: InputDecoration(
        suffixIcon: (onPressed != null && dropdownValue != null)
            ? IconButton(
          icon: const Icon(Icons.clear, size: 20),
          onPressed: onPressed,
        )
            : null,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.grey, style: BorderStyle.solid, width: 0.80)
        ),
        errorStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w800),
        hintText: hint,
        label:  dropdownValue != null
            ? Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: hint,
                style: TextStyle(
                  color: EnvironmentConfig.of(context)!.primaryTheme,
                  fontSize: AppFont.font_14,
                )),
            TextSpan(
                text: isRequired == true ? " *" : '',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: AppFont.font_14,
                )),
          ])),
        )
            : const SizedBox.shrink(),
      ),
      selectedItemBuilder : selectedItemBuilder,
      items: items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
