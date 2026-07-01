import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/domain/bloc/dashboard_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/phone_dashboard_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/presentation/widget/tablet_dashboard_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_update_message_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const platform = MethodChannel('steelApp');

  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdate();
    });
    BlocProvider.of<DashboardBloc>(context)
        .add(DashboardPageLoadEvent(context: context));

  }

  Future<void> checkForUpdate() async {
    try {
      final result = await platform.invokeMethod('getAppUpdate');

      if (result == null) return;

      final Map<dynamic, dynamic> data = result;

      final bool updateAvailable = data['update'] ?? false;

      if (!updateAvailable) return;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;

      String url = "";
      if (Platform.isAndroid) {
        url = "https://play.google.com/store/apps/details?id=$packageName";
      } else if (Platform.isIOS) {
        String appId = data['appId'].toString();
        url = "https://apps.apple.com/app/id$appId";
      }

      AppUpdateMessage.showAlertDialog(
        context: context,
        url: url,
        isLater: false,
      );

    } on PlatformException catch (e) {
      debugPrint("PlatformException: ${e.message}");
    }
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
