import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_font.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/enums.dart';
import 'button_widget.dart';

class DropDownSearchWidget<T> extends StatelessWidget {
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final DropdownSearchItemAsString<T>? itemAsString;
  final String hint;
  final T? selectedItem;

  const DropDownSearchWidget({
    super.key,
    required this.items,
    this.onChanged,
    required this.itemAsString,
    required this.hint,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConfig.getDeviceType(context: context) == DeviceType.phone
          ? MediaQuery.of(context).size.height * 0.07
          : MediaQuery.of(context).size.height * 0.15,
      child: DropdownSearch<T>(
        items: (filter, infiniteScrollProps) => items,
        selectedItem: selectedItem,
        itemAsString: itemAsString,
        onChanged: onChanged,
        decoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintStyle: TextStyle(
              fontSize: AppFont.font_14,
              color: AppColor.themeColor,
            ),
            contentPadding: EdgeInsets.only(
              top: AppConfig.getDeviceType(context: context) == DeviceType.phone
                  ? MediaQuery.of(context).size.height * 0.018
                  : MediaQuery.of(context).size.height * 0.03,
              left: AppConfig.getDeviceType(context: context) == DeviceType.phone
                  ? MediaQuery.of(context).size.height * 0.01
                  : MediaQuery.of(context).size.height * 0.02,
            ),
            hintText: hint,
            filled: false,
          ),
        ),
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
          ),
          showSearchBox: true,
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
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: ButtonWidget(
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
          },
        ),
      ),
    );
  }
}
