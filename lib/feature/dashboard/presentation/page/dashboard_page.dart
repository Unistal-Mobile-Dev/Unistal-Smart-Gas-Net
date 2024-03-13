
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/domain/bloc/dashboard_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/phone_dashboard_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/tablet_dashboard_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var platform = const MethodChannel('pbgsteel.flutter.dev/native');

  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context)
        .add(DashboardPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is FetchDashboardDataState) {
          return AppConfig.getDeviceType(context: context) == DeviceType.phone
              ? const PhoneDashboardWidget()
              : const TabletDashboardWidget();
        } else {
          return const Center(child: CenterLoaderWidget());
        }
      },
    );
  }
}
