import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/domain/bloc/forgot_password_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class TabletForgotPasswordWidget extends StatefulWidget {
  final FetchForgotPasswordDataState dataState;

  const TabletForgotPasswordWidget({super.key, required this.dataState});

  @override
  State<TabletForgotPasswordWidget> createState() =>
      _TabletForgotPasswordWidgetState();
}

class _TabletForgotPasswordWidgetState
    extends State<TabletForgotPasswordWidget> {
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
            child: _itemBuilder(dataState: widget.dataState),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder({required FetchForgotPasswordDataState dataState}) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _verticalSpace(),
            _emailTextField(dataState: dataState),
            _verticalSpace(),
            _submit(dataState: dataState),
            _verticalSpace(),
            _loginPage(),
            _verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTextWidget() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _logo(),
          _verticalSpace(),
          TextWidget(
            "Forgot Password!",
            fontSize: AppFont.font_14,
            fontWeight: FontWeight.w700,
          ),
        ],
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

  Widget _emailTextField({required FetchForgotPasswordDataState dataState}) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: TextFieldWidget(
        isRequired: true,
        labelText: AppString.emailPhoneNumber,
        controller: dataState.emailTextFieldController,
        textInputType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _submit({required FetchForgotPasswordDataState dataState}) {
    return dataState.isLoader == false
        ? Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: ButtonWidget(
                text: AppString.submit,
                height: MediaQuery.of(context).size.height * 0.10,
                onPressed: () {
                  BlocProvider.of<ForgotPasswordBloc>(context)
                      .add(ForgotPasswordSubmitEvent(context: context));
                }),
          )
        : const DottedLoaderWidget();
  }

  Widget _loginPage() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextWidget("Login",
            textDecoration: TextDecoration.underline,
            color: EnvironmentConfig.of(context)!.primaryTheme,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
    );
  }
}
