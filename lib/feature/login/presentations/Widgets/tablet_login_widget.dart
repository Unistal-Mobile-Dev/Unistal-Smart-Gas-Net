import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/presentation/pages/forgot_password_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_state.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class TabletLoginWidget extends StatefulWidget {
  final FetchLoginStateData dataState;

  const TabletLoginWidget({super.key, required this.dataState});

  @override
  State<TabletLoginWidget> createState() => _TabletLoginWidgetState();
}

class _TabletLoginWidgetState extends State<TabletLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04),
              child: Center(child: _logoWithTextWidget()),
            ),
          ),
          Expanded(
            child: _rightRowWidget(dataState: widget.dataState),
          ),
        ],
      ),
    );
  }

  Widget _logoWithTextWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Card(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _logo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  _smartGasNetLogo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Hero(
      tag: 'logo',
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.27,
        child: Stack(
          children: [
            Positioned(
              left: 00.0,
              top: 00.0,
              right: 00.0,
              bottom: MediaQuery.of(context).size.height * 0.13,
              child: Image.asset(
                AppConfig.instanceInit()!.client == Client.mgl
                    ? AppIcon.appLogoMGL
                    : AppConfig.instanceInit()!.client == Client.purvaBharti
                    ? AppIcon.appLogoPurvaBharti
                    : AppConfig.instanceInit()!.client == Client.unistal
                    ? AppIcon.appLogoUnistal
                    : AppConfig.instanceInit()!.client == Client.oilIndia
                    ? AppIcon.oilIndiaLogo
                    : AppConfig.instanceInit()!.client == Client.vppl
                    ? AppIcon.vpplLogo
                    : AppConfig.instanceInit()!.client == Client.vrpl
                    ? AppIcon.vrplLogo
                    :  AppIcon.appLogoUnistal,
                width: MediaQuery.of(context).size.width * 0.30,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppIcon.colourStrip,
                color: EnvironmentConfig.of(context)!.primaryTheme,
                fit: BoxFit.cover,
/*                width: MediaQuery.of(context).size.width/2.3,*/
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smartGasNetLogo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Image.asset(AppIcon.smartgasnetLog),
    );
  }

  Widget _rightRowWidget({required FetchLoginStateData dataState}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailTextField(dataState: dataState),
          _verticalSpace(),
          _passwordTextField(dataState: dataState),
          _verticalSpace(),
/*          _forgotPassword(dataState: dataState),*/
          _loginButton(dataState: dataState),
        ],
      ),
    );
  }

  Widget _emailTextField({required FetchLoginStateData dataState}) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: TextFieldWidget(
        isRequired: true,
        labelText: AppString.emailPhoneNumber,
        textInputType: TextInputType.emailAddress,
        controller: dataState.userNameTextFiledController,
        onChanged: (value) => BlocProvider.of<LoginBloc>(context)
            .add(LoginSetEmailEvent(emailId: value)),
      ),
    );
  }

  Widget _passwordTextField({required FetchLoginStateData dataState}) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: TextFieldPasswordWidget(
        isRequired: true,
        labelText: AppString.password,
        obscureText: dataState.isPassword,
        isPasswordIcon: true,
        textEditingController: dataState.passwordTextFieldController,
        passwordOnPressed: () {
          BlocProvider.of<LoginBloc>(context).add(LoginPasswordHideShowEvent(
              isPassword: dataState.isPassword == true ? false : true));
        },
        onChanged: (value) => BlocProvider.of<LoginBloc>(context)
            .add(LoginSetPasswordEvent(password: value)),
      ),
    );
  }

  Widget _forgotPassword({required FetchLoginStateData dataState}) {
    return dataState.isLoader == false
        ? Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.00,
                    bottom: MediaQuery.of(context).size.width * 0.02),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()),
                    );
                  },
                  child: TextWidget("Forgot Password",
                      textDecoration: TextDecoration.underline,
                      color: AppColor.themeSecondary,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _loginButton({required FetchLoginStateData dataState}) {
    return dataState.isLoader == false
        ? Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: ButtonWidget(
                height: MediaQuery.of(context).size.height * 0.10,
                isLockIcon: true,
                text: AppString.login,
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LoginSubmitDataEvent(
                      context: context, isLoginPage: true));
                }),
          )
        : const DottedLoaderWidget();
  }

  _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
    );
  }
}
