import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';

class PhoneDashboardWidget extends StatefulWidget {
  const PhoneDashboardWidget({
    super.key,
  });

  @override
  State<PhoneDashboardWidget> createState() => _PhoneDashboardWidgetState();
}

class _PhoneDashboardWidgetState extends State<PhoneDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is FetchHomeDataState) {
        return _listBuilder(dataState: state);
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _listBuilder({required FetchHomeDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: dataState.drawerList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return index != 0
                ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(
                            HomeDrawerItemSelectedEvent(
                                isSelected: true,
                                index: index,
                                context: context));
                      },
                      icon: Icon(
                        dataState.drawerList[index].icon,
                        color: AppColor.themeColor,
                      ),
                      label: TextWidget(dataState.drawerList[index].label),
                    ),
                  ),
                ),
                dataState.drawerList[index].isSublistLoader == false ||
                    dataState.drawerList[index].isSublistLoader == null
                    ? dataState.drawerList[index].sublist.isNotEmpty && dataState.drawerList[index].isSelected == true
                    ? _subListBuilder(
                    context: context,
                    drawerData: dataState.drawerList[index],
                    listIndex: index)
                    : const SizedBox.shrink()
                    : const DottedLoaderWidget()
              ],
            )
                : const SizedBox.shrink();
          }),
    );
  }

  Widget _subListBuilder(
      {required BuildContext context,
        required DrawerModel drawerData,
        required int listIndex}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: drawerData.sublist.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(
                      HomeDrawerItemSubListSelectedEvent(
                          isSelected: true,
                          index: index,
                          listIndex: listIndex));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: MediaQuery.of(context).size.width * 0.03,
                      color: drawerData.sublist[index].isSelected == true
                          ? AppColor.themeColor
                          : AppColor.black,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Expanded(
                      child: TextWidget(
                        drawerData.sublist[index].label.toString(),
                        fontSize: AppFont.font_12,
                        color: drawerData.sublist[index].isSelected == true
                            ? AppColor.themeColor
                            : AppColor.black,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: AppColor.black,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}