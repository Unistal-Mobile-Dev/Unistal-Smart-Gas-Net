import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/Background/background_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_bar_widget.dart';
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
    return dataState.drawerList.first.label == "Dashboard" &&
            dataState.drawerList.length == 1
        ? Center(
            child: Text("No records found"),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: dataState.drawerList.length,
            itemBuilder: (context, index) {
              final drawerItem = dataState.drawerList[index];

              // Skip dashboard (index 0) if needed
           //   if (index == 0) return const SizedBox.shrink();

              // ================= NO SUBLIST =================
              if (drawerItem.sublist.isEmpty) {
                return _singleDrawerItem(drawerItem, index);
              }

              // ================= WITH SUBLIST =================
              return _expandableDrawerItem(dataState: dataState, item: drawerItem);
            },
          );
  }

  Widget _singleDrawerItem(DrawerModel item, int index) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBarWidget(
                  boolLeading: false,
                  title: item.label.toString(),
                ),
                body: BackgroundWidget(child: item.widget),
              ),
            ),
          );
        },
        icon: Icon(item.icon, color: EnvironmentConfig.of(context)!.primaryTheme),
        label: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(item.label,color: textColor, ),
        ),
      ),
    );
  }

  Widget _expandableDrawerItem({required DrawerModel item, required FetchHomeDataState dataState}) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        leading: Icon(
          item.icon,
          color: primaryColor
        ),
        title: TextWidget(item.label,  color: textColor, ),
        children: item.sublist.map((subItem, ) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 60),
            leading: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            title: TextWidget(subItem.label ?? "",  color: textColor, ),
            onTap: () {
              AppConfig.instanceInit()?.setActivitySection(
                newActivitySection: subItem.activityData,
              );
              print("activityData ==> ${subItem.activityData.appJoint}");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBarWidget(
                      boolLeading: true,
                      title: subItem.label ?? "",
                    ),
                    body: BackgroundWidget(child: subItem.widget),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
