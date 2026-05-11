import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: child),

            /// BOTTOM BAR
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 2,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    EnvironmentConfig.of(context)!.primaryTheme,
                    EnvironmentConfig.of(context)!.secondaryTheme,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppString.companyName,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),

                  Flexible(
                    child: Text(
                      "Version - ${AppConfig.instanceInit()!.buildNumber}",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}