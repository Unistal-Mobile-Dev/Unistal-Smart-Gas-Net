import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          child,
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          EnvironmentConfig.of(context)!.secondaryTheme,
                          EnvironmentConfig.of(context)!.primaryTheme,]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                            AppString.companyName,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 10, color: AppColor.white),
                          )),
                      Text(
                        "Version - ${AppConfig.instanceInit()!.buildNumber.toString()}",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 10, color: AppColor.white),
                      ),
                    ],
                  )))
        ],
      ),
    );

  }
}