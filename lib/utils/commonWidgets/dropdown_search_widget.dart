import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class DropDownSearchWidget extends StatelessWidget {

  final List<dynamic> items;
  final ValueChanged<dynamic>? onChanged;
  final  DropdownSearchItemAsString<dynamic>? itemAsString;
  final String hint;
  final dynamic selectedItem;
  const DropDownSearchWidget({super.key,
    required this.items,
    this.onChanged,
    required this.itemAsString,
    required this.hint,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      child: DropdownSearch<dynamic>(
        selectedItem: selectedItem,
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintStyle: TextStyle(fontSize: AppFont.font_14, color: AppColor.themeColor),
            contentPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.018,
              left: MediaQuery.of(context).size.height * 0.01,),
            hintText: hint,
            filled: false,
          ),
        ),
        items: items,
        itemAsString: itemAsString,
        onChanged: onChanged,
        popupProps:  PopupProps.dialog(
            searchFieldProps: TextFieldProps(
              decoration:  InputDecoration(
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
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: ButtonWidget(
                          onPressed: () {
                            Navigator.pop(context);
                          }, text: AppString.cancel,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
