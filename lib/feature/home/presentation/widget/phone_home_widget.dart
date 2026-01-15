import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/widget/home_drawer_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class PhoneHomeWidget extends StatefulWidget {
  const PhoneHomeWidget({super.key});

  @override
  State<PhoneHomeWidget> createState() => _PhoneHomeWidgetState();
}

class _PhoneHomeWidgetState extends State<PhoneHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: HomeDrawerWidget(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: EnvironmentConfig.of(context)!.primaryTheme,
          title: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is FetchHomeDataState) {
              return TextWidget(
                state.title,
                color: AppColor.white,
                fontSize: AppFont.font_16,
                fontWeight: FontWeight.w700,
              );
            } else {
              return TextWidget(
                AppString.appName,
                color: AppColor.white,
                fontSize: AppFont.font_16,
                fontWeight: FontWeight.w700,
              );
            }
          }),
          actions: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is FetchHomeDataState) {
                  return state.actionButtonWidget;
                }
                return const SizedBox.shrink();
              },
            ),
          ],

          // actions: [
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Flexible(
          //         child: Container(
          //           width: MediaQuery.of(context).size.width * 0.2,
          //           // height: MediaQuery.of(context).size.height * 0.05,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(12),
          //             child: Padding(
          //               padding: const EdgeInsets.all(4.0),
          //               child: Image.network(
          //                 UserInfo.instance!.userData!.projectLogo ?? "",
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Flexible(
          //         child: Container(
          //           width: MediaQuery.of(context).size.width * 0.2,
          //           // height: MediaQuery.of(context).size.height * 0.05,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(12),
          //             child: Padding(
          //               padding: const EdgeInsets.all(4.0),
          //               child: Image.network(
          //                 UserInfo.instance!.userData!.smartLogo ?? "",
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          //   // Image.asset(
          //   //   AppConfig.instanceInit()!.client == Client.mgl
          //   //       ? AppIcon.appLogoMGL
          //   //       : AppConfig.instanceInit()!.client == Client.purvaBharti
          //   //       ? AppIcon.appLogoPurvaBharti
          //   //       : AppConfig.instanceInit()!.client == Client.unistal
          //   //       ? AppIcon.appLogoUnistal
          //   //       : AppConfig.instanceInit()!.client == Client.oilIndia
          //   //       ? AppIcon.oilIndiaLogo
          //   //       : AppConfig.instanceInit()!.client == Client.vppl
          //   //       ? AppIcon.vpplLogo
          //   //       : AppConfig.instanceInit()!.client == Client.vrpl
          //   //       ? AppIcon.vrplLogo
          //   //       :  AppIcon.appLogoUnistal,
          //   //   fit: BoxFit.cover,
          //   //   width: MediaQuery.of(context).size.width * 0.2,
          //   //   height: MediaQuery.of(context).size.height * 0.2,
          //   // ),
          //
          //   BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          //     if (state is FetchHomeDataState) {
          //       return state.actionButtonWidget;
          //     } else {
          //       return const SizedBox.shrink();
          //     }
          //   }),
          // ],
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is FetchHomeDataState) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    color: EnvironmentConfig.of(context)!.primaryTheme,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _logoContainer(
                          context,
                          UserInfo.instance!.userData!.projectLogo,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${UserInfo.instance!.userData!.sectionName}\n (Dia - ${UserInfo.instance!.userData!.diameter}${UserInfo.instance!.userData!.diauom})",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        _logoContainer(
                          context,
                          UserInfo.instance!.userData!.smartLogo,
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   color: EnvironmentConfig.of(context)!.primaryTheme,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Text(
                  //     "${UserInfo.instance!.userData!.sectionName}\n (Dia - ${UserInfo.instance!.userData!.diameter}${UserInfo.instance!.userData!.diauom})",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontSize: 12,
                  //         color: AppColor.white,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Expanded(child: state.childWidget),
                  Container(
                    color: EnvironmentConfig.of(context)!.primaryTheme,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          AppString.companyName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColor.white
                          ),
                        )),
                        Flexible(
                            child: Text(
                          AppString.version,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                              color: AppColor.white
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CenterLoaderWidget(),
              );
            }
          }),
        ));
  }

  Widget _logoContainer(BuildContext context, String? url) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      // FIXED width (important)
      height:  MediaQuery.of(context).size.width * 0.11,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url ?? "",
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
