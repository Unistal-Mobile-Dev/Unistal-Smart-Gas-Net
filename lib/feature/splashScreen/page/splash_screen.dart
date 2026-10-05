import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_event.dart';

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
    _getData();
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

  Future<LoginDataModel?> _getData() async {
    try {
      final String userJson =
      await SharedPreferencesUtils.getString(key: PreferencesName.userInfo);
      if (userJson.isEmpty) return null;

      final Map<String, dynamic> saved = jsonDecode(userJson);
      final loginModel = loginResponse(saved['user']);   // same parser as login
      loginModel.token = saved['token'] ?? "";

      await AppConfig.instanceInit()?.setLoginData(newLoginData: loginModel);
      AppConfig.instanceInit()?.roleType = loginModel.roleType;
      UserInfo.instanceInit()?.userData = loginModel;

      return loginModel;
    } catch (e) {
      debugPrint("Error in _getData: $e");
      return null;
    }
  }

  Future<void> pageOpen() async {
    final String userName = await SharedPreferencesUtils.getString(key: PreferencesName.userName,);
    final String password = await SharedPreferencesUtils.getString(key: PreferencesName.password,);
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;

    AppConfig.instanceInit()?.setBuildNumber(buildNumber: "$buildNumber($version)",);
    final String oldVersion = await SharedPreferencesUtils.getString(key: PreferencesName.buildNumber,);

    print("newVersion -- $buildNumber");
    print("oldVersion -- $oldVersion");
    print("username -- $userName");
    print("password available -- ${password.isNotEmpty}");

    Timer(const Duration(seconds: 3), () async {
      if (!mounted) return;

      if (oldVersion == buildNumber && userName.isNotEmpty && password.isNotEmpty) {
        if (_isURJAGATI) {
          final user = await _getData();
          if (!mounted) return;

          if (user == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreenPage()),
            );
            return;
          }

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false,
          );
        } else {
          final loginBloc = BlocProvider.of<LoginBloc>(context);
          loginBloc.add(LoginSetPasswordEvent(password: password));
          loginBloc.add(LoginSetEmailEvent(emailId: userName));
          loginBloc.add(LoginSubmitDataEvent(context: context, isLoginPage: false));
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreenPage()),
        );
      }
    });
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
