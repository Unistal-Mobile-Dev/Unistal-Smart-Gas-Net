import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class DropdownWidget extends StatelessWidget {

  final dynamic dropdownValue;
  final String hint;
  final ValueChanged<dynamic>? onChanged;
  final List<DropdownMenuItem<dynamic>>? items;

  const DropdownWidget({
    required this.dropdownValue,
    required this.onChanged,
    required this.items,
    required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppColor.grey, style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButton<dynamic>(
        hint: TextWidget("$hint", color: AppColor.themeColor,),
        underline: SizedBox(),
        isExpanded: true,
        value: dropdownValue,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
