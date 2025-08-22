import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/widget/home_drawer_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';

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
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is FetchHomeDataState) {
                return state.actionButtonWidget;
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is FetchHomeDataState) {
              return Column(
                children: [
                  Container(
                    color: AppColor.themeLightColor,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${UserInfo.instance!.userData!.sectionName}\n (Dia - ${UserInfo.instance!.userData!.diameter}${UserInfo.instance!.userData!.diauom})",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Expanded(child: state.childWidget),
                  Container(
                    color: AppColor.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                                AppString.companyName,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10,
                                ),

                              )),
                          Flexible(
                              child: Text(
                                AppString.version,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              )),
                        ],
                      ),
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
}
