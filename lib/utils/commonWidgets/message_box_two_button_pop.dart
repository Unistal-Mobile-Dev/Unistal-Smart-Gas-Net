import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class MessageBoxTwoButtonPopWidget extends StatelessWidget {
  final String message;
  final String? okButtonText;
  final VoidCallback onPressed;
  final double? width;

  const MessageBoxTwoButtonPopWidget(
      {super.key,
      required this.message,
      required this.onPressed,
      this.okButtonText,
      this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;

    // ✅ Theme-aware divider color
    final dividerColor = isDark ? Colors.grey.shade700 : Colors.grey.shade400;

    return Center(
      child: Wrap(
        children: [
          SizedBox(
            width: width ?? MediaQuery.of(context).size.width * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _closeButton(context: context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: TextWidget(
                      message,
                      color: theme.colorScheme.onSurface, // ✅ was AppColor.black
                      textAlign: TextAlign.center,
                      fontSize: AppFont.font_13,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // ✅ was Colors.grey[350]
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width,
                    color: dividerColor,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: TextWidget(
                              "Cancel",
                              color: primaryColor,
                              fontSize: AppFont.font_16,
                            ),
                          ),
                        ),

                        // ✅ was Colors.grey[350]
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: 1.0,
                          color: dividerColor,
                        ),

                        Expanded(
                          child: TextButton(
                            onPressed: onPressed,
                            child: TextWidget(
                              okButtonText ?? "OK",
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                              fontSize: AppFont.font_16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _closeButton({required BuildContext context}) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.width * 0.05,
            ),
            child: TextWidget(
              "Alert !",
              fontSize: AppFont.font_18,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              color: textColor, // ✅ was AppColor.black
            ),
          ),
        ),
      ],
    );
  }
}
