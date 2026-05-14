import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/text_widget.dart';

class DottedBorderWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const DottedBorderWidget({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(title),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
