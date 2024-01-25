import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/profile_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/report_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/service_center_network_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/table_report_widget.dart';

class TabletDashboardWidget extends StatefulWidget {
  const TabletDashboardWidget({super.key});

  @override
  State<TabletDashboardWidget> createState() => _TabletDashboardWidgetState();
}

class _TabletDashboardWidgetState extends State<TabletDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
    /*      ProfileWidget(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),*/
          const TabletReportWidget(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          const ServiceCenterNetworkWidget(),
        ],
      ),
    );
  }
}
