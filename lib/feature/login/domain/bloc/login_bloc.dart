import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/page/home_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/helper/login_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/presentations/pages/login_screen_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/web_dashboard/presenation/web_dashboard_page.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/connectivity_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginStateInit()) {
    on<LoginPageLoadingEvent>(_pageLoad);
    on<LoginSetEmailEvent>(_setEmailId);
    on<LoginSetPasswordEvent>(_setPassword);
    on<LoginPasswordHideShowEvent>(_passwordHideShow);
    on<LoginSubmitDataEvent>(_submitLoginData);
  }

  String email = "";
  String password = "";

  bool _isLoader = false;

  bool get isLoader => _isLoader;

  bool _isPassword = true;

  bool get isPassword => _isPassword;

  bool _appLogoLoader = false;

  bool get appLogoLoader => _appLogoLoader;

  String _appLogo = "";

  String get appLogo => _appLogo;

  LoginDataModel _loginData = LoginDataModel();

  LoginDataModel get loginData => _loginData;

  TextEditingController userNameTextFiledController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();


  _setEmailId(LoginSetEmailEvent event, emit) {
    email = event.emailId.replaceAll("", "");
  }

  _setPassword(LoginSetPasswordEvent event, emit) {
    password = event.password.replaceAll("", "");
  }

  _passwordHideShow(LoginPasswordHideShowEvent event, emit) {
    _isPassword = event.isPassword;
    _eventCompleted(emit);
  }

  _pageLoad(LoginPageLoadingEvent event, emit) async {
    email = "";
    password = "";
    _isPassword = true;
    _isLoader = false;
    _appLogoLoader = true;
    _appLogo =
        "https://unistal.hrmmitra.in/uploads/logo/signin/signin_logo_1569825597.png";
    userNameTextFiledController.text = "";
    passwordTextFieldController.text = "";

    _eventCompleted(emit);
  }

  bool isAllowedRole(RoleType role) {
    return [
      RoleType.engineer,
      RoleType.admin,
      RoleType.siteFieldEngineer,
    ].contains(role);
  }

  _submitLoginData(LoginSubmitDataEvent event, emit) async {
    bool isUrjaGati = await  AppConfig.instanceInit()!.client == Client.urjagati;
    if (await ConnectivityHelper.allConnectivityCheck(context: event.context) ==
        false) {
      return;
    }

    _loginData = LoginDataModel();
    var textFieldValidationCheck = await LoginHelper.textFieldValidation(
        emilId: email,
        password: password,
        context: !event.context.mounted ? event.context : event.context);
    if (textFieldValidationCheck == true) {
      _isLoader = true;
      _eventCompleted(emit);
      var res = await LoginHelper.getLoginData(
          emilId: email,
          password: password,
          context: !event.context.mounted ? event.context : event.context);
      _isLoader = false;
      _eventCompleted(emit);
     // if (res != null && (res['roleId'] == null || res['roleId'] == "43"|| res['roleId'] == "44")) {
      if (res != null && isUrjaGati == true && res['user']['roleId'] == null) {
        _loginData = loginResponse(res['user']);

        String token = res['token'] ?? "";
        _loginData.token = token;

        SharedPreferencesUtils.setString(key: PreferencesName.userName, value: email.toString());
        SharedPreferencesUtils.setString(key: PreferencesName.password, value: password.toString());

        AppConfig.instanceInit()?.roleType = loginData.roleType;
        UserInfo.instanceInit()?.userData = loginData;

        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        String version = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;
        AppConfig.instanceInit()?.setBuildNumber(buildNumber: "$buildNumber($version)");
        var dashboardLink = await LoginHelper.loginURL(
          context: event.context,
          token: res['token'],
        );


      if (dashboardLink != null) {
        String cookie = ServerRequest.header['cookie'] ?? '';
        Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(
            builder: (_) => WebDashboardPage(
              url: dashboardLink["redirect_url"],
              token: dashboardLink["token"],
              cookie: cookie,
            ),
          ),
              (route) => false,
        );
        print("Token: ${dashboardLink["token"]}");
        print("Cookie: $cookie");
        print("URL: ${dashboardLink["redirect_url"]}");
      }

    } else if (res != null) {

        _loginData = loginResponse(res['user']);

        String token = res['token'] ?? "";
        _loginData.token = token;
        if (!isAllowedRole(_loginData.roleType ?? RoleType.unknown)) {
          SnackBarErrorWidget(event.context)
              .show(message: "Invalid user");
          return;
        }

        SharedPreferencesUtils.setString(key: PreferencesName.userName, value: email.toString());
        SharedPreferencesUtils.setString(key: PreferencesName.password, value: password.toString());

        AppConfig.instanceInit()?.roleType = loginData.roleType;
        UserInfo.instanceInit()?.userData = loginData;

        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        String version = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;

        AppConfig.instanceInit()?.setBuildNumber(buildNumber: "$buildNumber($version)");

        Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
        );

      } else {
        if (event.isLoginPage == false) {
          Navigator.pushAndRemoveUntil(
            event.context,
            MaterialPageRoute(
              builder: (_) => const LoginScreenPage(),
            ),
                (route) => false,
          );
        }

      }
    }
  }

  _eventCompleted(Emitter<LoginState> emit) {
    emit(FetchLoginStateData(
      isLoader: isLoader,
      isPassword: isPassword,
      appLogoLoader: appLogoLoader,
      appLogo: appLogo,
      userNameTextFiledController: userNameTextFiledController,
      passwordTextFieldController: passwordTextFieldController,
    ));
  }
  }

