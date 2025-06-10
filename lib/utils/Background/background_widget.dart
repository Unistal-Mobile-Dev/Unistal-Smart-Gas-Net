import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
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
                          Colors.green.shade800
                          /*EnvironmentConfig.of(context)!.secondaryTheme,
                          EnvironmentConfig.of(context)!.primaryTheme,*/
                        ]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                            AppString.companyName,
                            textAlign: TextAlign.start,

                          )),
                      Flexible(
                          child: Text(
                            AppString.version,
                            textAlign: TextAlign.start,
                          )),
                    ],
                  )))
        ],
      ),
    );
  }
}