import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

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
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: dataState.drawerList.length,
      itemBuilder: (context, index) {
        final drawerItem = dataState.drawerList[index];

        // Skip dashboard (index 0) if needed
        if (index == 0) return const SizedBox.shrink();

        // ================= NO SUBLIST =================
        if (drawerItem.sublist.isEmpty) {
          return _singleDrawerItem(drawerItem, index);
        }

        // ================= WITH SUBLIST =================
        return _expandableDrawerItem(dataState: dataState,item: drawerItem);
      },
    );
  }
  Widget _singleDrawerItem(DrawerModel item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          BlocProvider.of<HomeBloc>(context).add(
            HomeDrawerItemSelectedEvent(
              isSelected: true,
              index: index,
              context: context,
            ),
          );
        },
        icon: Icon(
          item.icon, color: EnvironmentConfig.of(context)!.primaryTheme,
        ),
        label: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(item.label),
        ),
      ),
    );
  }
  Widget _expandableDrawerItem(
      {required DrawerModel item, required FetchHomeDataState dataState}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        leading: Icon(item.icon, color: EnvironmentConfig.of(context)!.primaryTheme,),
        title: TextWidget(item.label),
        children: item.sublist.map((subItem) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 60),
            title: TextWidget(subItem.label ?? ""),

            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(
                HomeDrawerItemSubListSelectedEvent(
                  isSelected: true,
                  index: item.sublist.indexOf(subItem),
                  listIndex: dataState.drawerList.indexOf(item),
                ),
              );
            },

            // onTap: () {
            //   if (subItem.widget != null) {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (_) => subItem.widget!),
            //     );
            //   }
            // },
          );
        }).toList(),
      ),
    );
  }

  // Widget _listBuilder({required FetchHomeDataState dataState}) {
  //   return Container(
  //     margin: const EdgeInsets.all(10.0),
  //     child: ListView.builder(
  //         itemCount: dataState.drawerList.length,
  //         itemBuilder: (context, index) {
  //           return index != 0
  //               ? SizedBox(
  //                   height: MediaQuery.of(context).size.height * 0.08,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: ElevatedButton.icon(
  //                       style: ButtonStyle(
  //                         backgroundColor:
  //                             MaterialStateProperty.all(Colors.white),
  //                       ),
  //                       onPressed: () {
  //                         BlocProvider.of<HomeBloc>(context).add(
  //                             HomeDrawerItemSelectedEvent(
  //                                 isSelected: true,
  //                                 index: index,
  //                                 context: context));
  //                       },
  //                       icon: Icon(
  //                         dataState.drawerList[index].icon,
  //                         color: EnvironmentConfig.of(context)!.primaryTheme,
  //                       ),
  //                       label: TextWidget(dataState.drawerList[index].label),
  //                     ),
  //                   ),
  //                 )
  //               : const SizedBox.shrink();
  //         }),
  //   );
  // }
}
