import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/domain/bloc/dashboard_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/card_backgound.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/phone_dashboard_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/profile_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/report_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/service_center_network_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/tablet_dashboard_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/wave_backgorund.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_update_message_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  var platform = const MethodChannel('pbgsteel.flutter.dev/native');

  @override
  void initState() {
    callMethodeChannel();
    BlocProvider.of<DashboardBloc>(context).add(
         DashboardPageLoadEvent(context: context));
    super.initState();
  }

  callMethodeChannel() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String applicationId = packageInfo.packageName;
      String androidPlayStoreUrl =
          "https://play.google.com/store/apps/details?id=$applicationId&hl=en&gl=US";
      if (Platform.isAndroid) {
        final dynamic result = await platform.invokeMethod('getAppUpdate');
        if(result.toString() == "success"){
          if(context.mounted){
            AppUpdateMessage.showAlertDialog(context: context,url: androidPlayStoreUrl,);
          }
        }
      } else if (Platform.isIOS) {
        // iOS-specific code
      }
    } on PlatformException catch (e) {
      if(kDebugMode){
        print("Update Errorl  ------------${e.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if(state is FetchDashboardDataState){
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
