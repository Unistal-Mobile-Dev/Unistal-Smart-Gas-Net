import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_state.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class PhoneLoginWidget extends StatefulWidget {
  final FetchLoginStateData dataState;

  const PhoneLoginWidget({super.key, required this.dataState});

  @override
  State<PhoneLoginWidget> createState() => _PhoneLoginWidgetState();
}

class _PhoneLoginWidgetState extends State<PhoneLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return _itemBuilder(dataState: widget.dataState);
  }

  Widget _itemBuilder({required FetchLoginStateData dataState}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          reverse: true,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Card(
            elevation: 2,
            shadowColor: EnvironmentConfig.of(context)!.primaryTheme,
            color: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _verticalSpace(),
                _logo(),
                _verticalSpace(),
                AppConfig.instanceInit()!.client == Client.urjagati ? SizedBox.shrink() :_smartGasNetLogo(),
/*                TextWidget("Login to your account",
                  fontSize: AppFont.font_18, fontWeight: FontWeight.w700,),*/
                _verticalSpace(),
                _emailTextField(dataState: dataState),
                _verticalSpace(),
                _passwordTextField(dataState: dataState),
                _verticalSpace(),
                // _forgotPassword(dataState: dataState),
                _loginButton(dataState: dataState),
                _verticalSpace(),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.4),
                  // padding: EdgeInsets.only(bottom: 100),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    final size = MediaQuery.sizeOf(context); // more efficient

    return Hero(
      tag: 'logo',
      child: SizedBox(
        height: size.height * 0.2,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Logo (centered upper portion)
            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                heightFactor: 0.7, // replaces manual bottom calculation
                child: Image.asset(
                  AppIcon.appLogo(),
                  width: size.width * 0.6,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            // Bottom strip
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppIcon.colourStrip,
                width: size.width,
                fit: BoxFit.cover,
                color: EnvironmentConfig.of(context)!.primaryTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smartGasNetLogo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Image.asset(AppIcon.smartLogo()),
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

  Widget _loginButton({required FetchLoginStateData dataState}) {
    return dataState.isLoader == false
        ? Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: ButtonWidget(
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
      height: MediaQuery.of(context).size.width * 0.07,
    );
  }
}
