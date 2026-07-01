import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/presentations/pages/login_screen_page.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_update_message_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    pageOpen();
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

  pageOpen() async {
    String userName =
        await SharedPreferencesUtils.getString(key: PreferencesName.userName);
    if (userName.isEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(
          !context.mounted ? context : context,
          MaterialPageRoute(builder: (_) => const LoginScreenPage()),
          (route) => false);
    } else {
      String password = await SharedPreferencesUtils.getString(key: PreferencesName.password);
      BlocProvider.of<LoginBloc>(!context.mounted ? context : context)
          .add(LoginSetPasswordEvent(password: password));
      BlocProvider.of<LoginBloc>(!context.mounted ? context : context)
          .add(LoginSetEmailEvent(emailId: userName));
      BlocProvider.of<LoginBloc>(!context.mounted ? context : context).add(
          LoginSubmitDataEvent(
              context: !context.mounted ? context : context,
              isLoginPage: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppIcon.appLogo(),
              height: MediaQuery.of(context).size.width * 0.30,
              width: MediaQuery.of(context).size.width * 0.30,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.10,
            left: 0.0,
            right: 0.0,
            child: const CenterLoaderWidget(),
          )
        ],
      ),
    );
  }
}
