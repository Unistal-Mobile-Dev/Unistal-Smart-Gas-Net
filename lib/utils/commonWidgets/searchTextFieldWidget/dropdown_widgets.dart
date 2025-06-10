import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/common_style.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';

class DropdownWidgets<T> extends StatelessWidget {
  final T? dropdownValue;
  final String hint;
  final String? label;
  final String? star;
  final void Function(T?)? onChanged;
  final List<T> items;

  const DropdownWidgets({
    Key? key,
    required this.dropdownValue,
    required this.onChanged,
    required this.items,
    required this.hint,
    this.label,
    this.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
        hint: Text(hint, style: CommonStyle.labels),
        style: CommonStyle.texts,
        isExpanded: true,
        isDense: true,
        elevation: 16,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.white,
          isDense: true,
         // contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
          enabledBorder:CommonStyle.borderGrey,
          disabledBorder:CommonStyle.borderGrey,
          border: CommonStyle.borderGrey,
          focusedBorder: CommonStyle.borderGrey,
          errorBorder: CommonStyle.borderGrey,
          label: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text(star ?? "",  style:CommonStyle.stars)),
                Flexible(child: Text(label  ?? "", style:CommonStyle.labels),
                ),
              ],
            ),
          ),
        ),
        value: dropdownValue != null ? dropdownValue : null,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString(), style: CommonStyle.texts,),
          );
        }).toList(),
        onChanged: onChanged
    );
  }
}
