import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/button_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_font.dart';

import '../res/app_string.dart';

class DropDownSearchMultiSelectWidget extends StatelessWidget {
  final List<dynamic> items;
  final ValueChanged<dynamic> onChanged;
  final DropdownSearchItemAsString<dynamic>? itemAsString;
  final String hint;
  final List<dynamic>? selectedItem;
  final bool? isBoardRemove;
  final bool? isLabelShow;
  final bool? isRequired;

  const DropDownSearchMultiSelectWidget({
    super.key,
    required this.items,
    required this.onChanged,
    required this.itemAsString,
    required this.hint,
    this.selectedItem,
    this.isBoardRemove,
    this.isLabelShow,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /*  height: MediaQuery.of(context).size.height * 0.07,*/
      child: DropdownSearch<dynamic>.multiSelection(
        selectedItems: selectedItem ?? [],
        compareFn: (i, s) => i.isEqual(s),
        decoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              border: isBoardRemove == true ? InputBorder.none : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 1.0,
                  color: AppColor.themeColor,
                ),
              ),
              enabledBorder: isBoardRemove == true ? InputBorder.none : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 1.0,
                  color: AppColor.themeColor,
                ),
              ),
              focusedBorder: isBoardRemove == true ? InputBorder.none : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 1.0,
                  color: AppColor.themeColor,
                ),
              ),
              hintText: isLabelShow == true ? null : hint.toString(),
              hintStyle: TextStyle(
                fontSize: isBoardRemove == true ? AppFont.font_14 : AppFont.font_13,
                fontWeight:
                isBoardRemove == true ? FontWeight.w700 : FontWeight.w500,
                color: AppColor.grey,
              ),
              label: isLabelShow == true ? Text.rich(TextSpan(children: [
                TextSpan(text: hint),
                TextSpan(
                  text: isRequired != null && isRequired == true ? ' *' : "",
                  style: const TextStyle(color: Colors.red),
                ),
              ])) : null,
              filled: true,
              fillColor: AppColor.themeColor
          ),
        ),
        items: (filter, infiniteScrollProps) => items,
        itemAsString: itemAsString,
        onChanged: onChanged,
        popupProps: PopupPropsMultiSelection.dialog(
          containerBuilder: (ctx, selectedItems) {
            return Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ButtonWidget(
                    onPressed: () {
                      onChanged.call(selectedItems);
                      Navigator.pop(context);
                    },
                    text: AppString.ok,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
