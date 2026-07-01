import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class SearchTextField extends StatelessWidget {
  final void Function(dynamic) onChange;
  final void Function(dynamic) onClick;
  final List<dynamic> list;
  final String label;
  final double? height;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isLoader;

  const SearchTextField(
      {super.key,
      required this.onChange,
      required this.onClick,
      required this.label,
      this.height,
      this.maxLines,
      this.isLoader,
      required this.list,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return _searchTextField(searchController: controller, context: context);
  }

  Widget _searchTextField(
      {TextEditingController? searchController,
      required BuildContext context}) {
    return Column(
      children: [
        TextFieldWidget(
            labelText: label,
            isRequired: true,
            controller: controller,
            onChanged: (keyWord) {
              onChange.call(keyWord);
            }),
        isLoader == true
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: const DottedLoaderWidget(),
              )
            : _list(list: list, context: context),
      ],
    );
  }

  Widget _list({required dynamic list, required BuildContext context}) {
    final textColor = Theme.of(context).colorScheme.onSurface; // ✅

    return list.isNotEmpty
        ? SizedBox(
      height: _listHeight(list.length, context),
      child: Card(
        color: Theme.of(context).cardColor, // ✅
        child: ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.02),
              child: InkWell(
                onTap: () => onClick.call(list[index]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${list[index].pipeNumber}|${list[index].heatNumber}|${list[index].pipeLength}",
                      style: TextStyle( // ✅ removed const
                        color: textColor, // ✅ was Colors.black
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (index != list.length - 1) const Divider(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    )
        : const SizedBox.shrink();
  }

  double _listHeight(int length, BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    if (length == 1) return h * 0.07;
    if (length == 2) return h * 0.12;
    if (length == 3) return h * 0.19;
    if (length == 4) return h * 0.26; // ✅ was 0.16
    return h / 3;
  }
}
