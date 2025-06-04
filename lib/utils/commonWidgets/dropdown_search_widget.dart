import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/button_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/text_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_font.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';

class DropDownSearchWidget extends StatelessWidget {
  final List<dynamic> items;
  final ValueChanged<dynamic>? onChanged;
  final DropdownSearchItemAsString<dynamic>? itemAsString;
  final String hint;
  final dynamic selectedItem;
  final bool? isRequired;
  final bool? enabled;
  final bool? isBoardRemove;
  final bool? isLabelShow;

  const DropDownSearchWidget({
    super.key,
    required this.items,
    this.onChanged,
    required this.itemAsString,
    required this.hint,
    this.selectedItem,
    this.isRequired,
    this.enabled,
    this.isBoardRemove,
    this.isLabelShow,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      child: DropdownSearch<dynamic>(
        selectedItem: selectedItem,
        enabled: enabled ?? true,
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
        dropdownBuilder: (context, selectedItem) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextWidget(
              selectedItem != null ? itemAsString!(selectedItem) : "",
              color: Colors.black, // 👈 Set selected text color here
            ),
          );
        },
        items: (filter, infiniteScrollProps) => items,
        itemAsString: itemAsString,
        onChanged: onChanged,
        popupProps: PopupProps.dialog(
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.black), // Search text color
            ),
            showSearchBox: true,
            dialogProps: const DialogProps(
              backgroundColor: Colors.white, // Set popup background color
            ),
            itemBuilder: (context, item, isSelected, isTru) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: isSelected ? Colors.grey[200] : Colors.white,
                child: TextWidget(
                  itemAsString!(item),
                  color: Colors.black,
                ),
              );
            },
            containerBuilder: (context, popupWidget) {
              return Column(
                children: [
                  Expanded(child: popupWidget),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.03),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: ButtonWidget(
                          fontSize: AppFont.font_12,
                          height: MediaQuery.of(context).size.height * 0.038,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: AppString.cancel,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
