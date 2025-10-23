import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';



class DropDownSearchMultiSelectWidget<T> extends StatelessWidget {
  final List<T>? items;
  final ValueChanged<List<T>>? onChanged;
  final DropdownSearchItemAsString<T>? itemAsString;
  final String hint;
  final List<T>? selectedItem;

  const DropDownSearchMultiSelectWidget({
    super.key,
    this.items,
    this.onChanged,
    this.itemAsString,
    required this.hint,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownSearch<T>.multiSelection(
        selectedItems: selectedItem ?? [],
        onChanged: onChanged ?? (_) {},
        itemAsString: itemAsString,
        decoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(style: BorderStyle.none),
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: AppFont.font_14, color: AppColor.themeColor),
            contentPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.018,
              left: MediaQuery.of(context).size.height * 0.01,
            ),
            filled: false,
          ),
        ),
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(style: BorderStyle.none),
              ),
            ),
          ),
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
