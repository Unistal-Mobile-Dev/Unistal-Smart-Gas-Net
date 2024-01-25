import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/profile_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/report_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/service_center_network_widget.dart';

class PhoneDashboardWidget extends StatefulWidget {
  const PhoneDashboardWidget({super.key});

  @override
  State<PhoneDashboardWidget> createState() => _PhoneDashboardWidgetState();
}

class _PhoneDashboardWidgetState extends State<PhoneDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ProfileWidget(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
          const ReportWidget(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
          const ServiceCenterNetworkWidget(),
        ],
      ),
    );
  }
}
