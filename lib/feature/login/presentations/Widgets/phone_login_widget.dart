import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/presentation/pages/forgot_password_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/bloc/login_state.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';

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
            shadowColor: AppColor.themeLightColor,
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
                _smartGasNetLogo(),
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
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom * 0.4),
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
    return Hero(
      tag: 'logo',
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.27,
        child: Stack(
          children: [
            Positioned(
              left: 00.0,
              top:  00.0,
              right: 00.0,
              bottom: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding: EdgeInsets.all(AppConfig.instanceInit()!.client == Client.agcl
                    ? MediaQuery.of(context).size.width * 0.10
                    : 0.0),
                child: Image.asset(
		               AppConfig.instanceInit()!.client == Client.purvaBharti
                     ? AppIcon.appLogoPurvaBharti
                   :AppConfig.instanceInit()!.client == Client.unistal
                     ? AppIcon.appLogoUnistal
                     : AppConfig.instanceInit()!.client == Client.agcl ?
                      AppIcon.appLogoAgcl : AppIcon.appLogoIgl,
                  width: MediaQuery.of(context).size.width * 0.30,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppIcon.colourStrip,
                color: AppColor.themeColor,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smartGasNetLogo(){
    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      child: Image.asset(AppIcon.smartgasnetLog),
    );
  }

  Widget _emailTextField({required FetchLoginStateData dataState}) {
    return Padding(
      padding:  EdgeInsets.only(left : MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05,),
      child: TextFieldWidget(
        isRequired: true,
        labelText: AppString.userName,
        textInputType: TextInputType.emailAddress,
        controller: dataState.userNameTextFiledController,
        onChanged: (value) => BlocProvider.of<LoginBloc>(context).add(LoginSetEmailEvent(emailId: value)),
      ),
    );
  }

  Widget _passwordTextField({required FetchLoginStateData dataState}) {
    return Padding(
      padding:  EdgeInsets.only(left : MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05,),
      child: TextFieldPasswordWidget(
        isRequired: true,
        labelText: AppString.password,
        obscureText: dataState.isPassword,
        isPasswordIcon: true,
        textEditingController: dataState.passwordTextFieldController,
        passwordOnPressed: () {
          BlocProvider.of<LoginBloc>(context).add(
              LoginPasswordHideShowEvent(
                  isPassword:  dataState.isPassword == true ? false : true));
        },
        onChanged: (value) => BlocProvider.of<LoginBloc>(context).add(LoginSetPasswordEvent(password: value)),
      ),
    );
  }

  Widget _forgotPassword({required FetchLoginStateData dataState}) {
    return dataState.isLoader == false ?
    Padding(
      padding:  EdgeInsets.only(left : MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05,),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.00,
              bottom: MediaQuery.of(context).size.width * 0.02),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
              );
            },
            child: Text(
              "Forgot Password",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColor.themeSecondary,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    ): const SizedBox.shrink();
  }

  Widget _loginButton({required FetchLoginStateData dataState}) {
    return dataState.isLoader == false ?
    Padding(
      padding:  EdgeInsets.only(left : MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05,),
      child: ButtonWidget(
          isLockIcon: true,
          text: AppString.login,
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(LoginSubmitDataEvent(context: context, isLoginPage: true));
          }),
    ): const DottedLoaderWidget();
  }

  _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.07,
    );
  }
}
