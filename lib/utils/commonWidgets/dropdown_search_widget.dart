import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';
import 'input_decoration_style.dart';

class DropDownSearchWidget<T> extends StatelessWidget {
  final List<T> items;
  final ValueChanged<dynamic>? onChanged;
  final DropdownSearchItemAsString<dynamic>? itemAsString;
  final String hint;
  final T? selectedItem;
  final bool isRequired;
  final bool enabled;

  const DropDownSearchWidget({
    super.key,
    required this.items,
    this.onChanged,
    required this.itemAsString,
    required this.hint,
    this.selectedItem,
    this.isRequired = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;
    final textColor = theme.colorScheme.onSurface;

    // ✅ Theme-aware fill colors
    final enabledFill = isDark
        ? theme.colorScheme.surfaceContainerHighest
        : Colors.white;
    final disabledFill = isDark
        ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.4)
        : Colors.grey.shade100;

    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      enabled: enabled,
      itemAsString: itemAsString,
      onChanged: onChanged,
      compareFn: (item, selected) => item == selected,

      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecorationStyle.inputDecoration(
          context,
          labelText: hint,
          isRequired: isRequired,
        ).copyWith(
          fillColor: enabled ? enabledFill : disabledFill, // ✅
        ),
      ),

      popupProps: PopupProps.dialog(
        showSearchBox: true,

        // ✅ Theme-aware dialog background
        dialogProps: DialogProps(
          backgroundColor: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // ✅ Theme-aware list items
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            title: Text(
              itemAsString?.call(item) ?? item.toString(),
              style: TextStyle(
                color: textColor, // ✅
                fontSize: 14,
              ),
            ),
            tileColor: isSelected
                ? primaryColor.withOpacity(isDark ? 0.2 : 0.08) // ✅
                : Colors.transparent,
            trailing: isSelected
                ? Icon(Icons.check, color: primaryColor, size: 18)
                : null,
          );
        },

        searchFieldProps: TextFieldProps(
          decoration: InputDecorationStyle.inputDecoration(
            context,
            labelText: "Search",
          ),
          style: TextStyle(
            color: textColor, // ✅ search text color
            fontSize: 14,
          ),
        ),

        containerBuilder: (context, popupWidget) {
          return Column(
            children: [
              Expanded(child: popupWidget),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: 120,
                    child: ButtonWidget(
                      fontSize: AppFont.font_12,
                      onPressed: () => Navigator.pop(context),
                      text: AppString.cancel,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}