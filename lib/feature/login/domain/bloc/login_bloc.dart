import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
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

  LoginDataModel loginData = LoginDataModel();

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

  /// Login ke baad user + token save karta hai, taaki splash pe restore ho sake.
  Future<void> _saveUserSession(dynamic user, String token) async {
    final value = jsonEncode({'user': user, 'token': token});
    await SharedPreferencesUtils.setString(
      key: PreferencesName.userInfo,
      value: value,
    );
    debugPrint("userInfo saved -> $value");
  }

  /// Sirf successful login pe credentials + build number save karo.
  Future<void> _saveCredentials() async {
    await SharedPreferencesUtils.setString(
        key: PreferencesName.userName, value: email);
    await SharedPreferencesUtils.setString(
        key: PreferencesName.password, value: password);

    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await SharedPreferencesUtils.setString(
      key: PreferencesName.buildNumber,
      value: packageInfo.buildNumber,
    );
    AppConfig.instanceInit()?.setBuildNumber(
      buildNumber: "${packageInfo.buildNumber}(${packageInfo.version})",
    );
  }

  _submitLoginData(LoginSubmitDataEvent event, emit) async {
    bool isUrjaGati = await  AppConfig.instanceInit()!.client == Client.urjagati;


    loginData = LoginDataModel();
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
      SharedPreferencesUtils.setString(key: PreferencesName.userName, value: email.toString());
      SharedPreferencesUtils.setString(key: PreferencesName.password, value: password.toString());
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      await SharedPreferencesUtils.setString(key: PreferencesName.buildNumber, value: packageInfo.buildNumber,);
      AppConfig.instanceInit()?.setBuildNumber(buildNumber: "$buildNumber($version)");
      _eventCompleted(emit);
     // if (res != null && (res['roleId'] == null || res['roleId'] == "43"|| res['roleId'] == "44")) {
      if (res != null && isUrjaGati == true && res['user']['roleId'] == null) {
        loginData = loginResponse(res['user']);
        String token = res['token'] ?? "";
        loginData.token = token;
        AppConfig.instanceInit()?.roleType = loginData.roleType;
        UserInfo.instanceInit()?.userData = loginData;

        await _saveCredentials();
        await _saveUserSession(res['user'], token);

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

        loginData = loginResponse(res['user']);

        String token = res['token'] ?? "";
        loginData.token = token;
        if (!isAllowedRole(loginData.roleType ?? RoleType.unknown)) {
          SnackBarErrorWidget(event.context)
              .show(message: "Invalid user");
          return;
        }

        SharedPreferencesUtils.setString(key: PreferencesName.userName, value: email.toString());
        SharedPreferencesUtils.setString(key: PreferencesName.password, value: password.toString());

        AppConfig.instanceInit()?.roleType = loginData.roleType;
        UserInfo.instanceInit()?.userData = loginData;
        await _saveCredentials();
        await _saveUserSession(res['user'], token);
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

