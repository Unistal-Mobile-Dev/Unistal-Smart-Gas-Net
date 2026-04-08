import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

import 'input_decoration_style.dart';

class DropDownSearchMultiSelectWidget extends StatelessWidget {
  final List<dynamic> items;
  final ValueChanged<List<dynamic>> onChanged;
  final DropdownSearchItemAsString<dynamic>? itemAsString;
  final String hint;
  final bool isRequired;
  final List<dynamic>? selectedItem;

  const DropDownSearchMultiSelectWidget({
    super.key,
    required this.items,
    required this.onChanged,
    required this.itemAsString,
    required this.hint,
    this.isRequired = false,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>.multiSelection(
      items: items,
      selectedItems: selectedItem ?? [],
      itemAsString: itemAsString,
      onChanged: onChanged,

      /// ✅ USE COMMON DECORATION HERE
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecorationStyle.inputDecoration(
          context,
          labelText: hint,
          isRequired: isRequired,
        ),
      ),

      /// ✅ CLEAN POPUP UI
      popupProps: PopupPropsMultiSelection.dialog(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecorationStyle.inputDecoration(
            context,
            labelText: "Search",
          ),
        ),

        validationWidgetBuilder: (ctx, selectedItems) {
          return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 120,
                child: ButtonWidget(
                  onPressed: () {
                    onChanged(selectedItems);
                    Navigator.pop(context);
                  },
                  text: AppString.ok,
                ),
              ),
            ),
          );
        },
      ),

      /// ✅ BETTER UX
      dropdownButtonProps: DropdownButtonProps(
        icon: Icon(
          Icons.arrow_drop_down,
          color: EnvironmentConfig.of(context)!.primaryTheme,
        ),
      ),
    );
  }
}