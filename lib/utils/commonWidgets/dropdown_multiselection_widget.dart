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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;

    // ✅ Theme-aware popup background
    final popupBackground = isDark
        ? theme.colorScheme.surfaceContainerHigh
        : Colors.white;

    // ✅ Theme-aware text color
    final textColor = theme.colorScheme.onSurface;

    return DropdownSearch<dynamic>.multiSelection(
      items: items,
      selectedItems: selectedItem ?? [],
      itemAsString: itemAsString,
      onChanged: onChanged,


      // ✅ Selected chip styling
      dropdownBuilder: (context, selectedItems) {
        if (selectedItems.isEmpty) return const SizedBox.shrink();
        return Wrap(
          spacing: 6,
          runSpacing: 4,
          children: selectedItems.map((item) {
            return Chip(
              label: Text(
                itemAsString?.call(item) ?? item.toString(),
                style: TextStyle(
                  color: isDark ? Colors.white : primaryColor,
                  fontSize: 12,
                ),
              ),
              backgroundColor: isDark
                  ? primaryColor.withValues(alpha: 0.3) // ✅ dark chip
                  : primaryColor.withValues(alpha: 0.1), // ✅ light chip
              side: BorderSide(color: primaryColor.withValues(alpha: 0.5)),
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        );
      },

      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecorationStyle.inputDecoration(
          context,
          labelText: hint,
          isRequired: isRequired,
        ),
      ),

      popupProps: PopupPropsMultiSelection.dialog(
        showSearchBox: true,

        // ✅ Theme-aware dialog background
        dialogProps: DialogProps(
          backgroundColor: popupBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // ✅ Theme-aware search box
        searchFieldProps: TextFieldProps(
          decoration: InputDecorationStyle.inputDecoration(
            context,
            labelText: "Search",
          ),
          style: TextStyle(
            color: textColor, // ✅ was default (black in dark mode)
            fontSize: 14,
          ),
        ),

        // ✅ Theme-aware list items
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            title: Text(
              itemAsString?.call(item) ?? item.toString(),
              style: TextStyle(
                color: textColor, // ✅ auto light/dark
                fontSize: 14,
              ),
            ),
            tileColor: isSelected
                ? primaryColor.withOpacity(isDark ? 0.2 : 0.08) // ✅
                : Colors.transparent,
          );
        },

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
    );
  }
}