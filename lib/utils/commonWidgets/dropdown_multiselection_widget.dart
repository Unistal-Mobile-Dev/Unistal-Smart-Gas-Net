import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class DropDownSearchMultiSelectWidget extends StatelessWidget {
  final List<dynamic> items;
  final ValueChanged<dynamic> onChanged;
  final DropdownSearchItemAsString<dynamic>? itemAsString;
  final String hint;
  final bool? isRequired;
  final List<dynamic>? selectedItem;

  const DropDownSearchMultiSelectWidget({
    super.key,
    required this.items,
    required this.onChanged,
    required this.itemAsString,
    required this.hint,
     this.isRequired,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /*  height: MediaQuery.of(context).size.height * 0.07,*/
      child: DropdownSearch<dynamic>.multiSelection(
        selectedItems: selectedItem ?? [],
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
            label: Text.rich(TextSpan(children: [
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
           /* hintStyle: TextStyle(
                fontSize: AppFont.font_14, color: EnvironmentConfig.of(context)!.primaryTheme),*/
            contentPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.018,
              left: MediaQuery.of(context).size.height * 0.01,
            ),
           // hintText: "$hint ${star}",
            filled: false,
          ),
        ),
        items: items,
        itemAsString: itemAsString,
        onChanged: onChanged,
        popupProps: PopupPropsMultiSelection.dialog(
          validationWidgetBuilder: (ctx, selectedItems) {
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
