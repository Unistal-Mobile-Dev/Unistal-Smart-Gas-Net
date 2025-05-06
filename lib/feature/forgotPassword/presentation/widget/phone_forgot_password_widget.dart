import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/domain/bloc/forgot_password_bloc.dart';

class PhoneForgotPasswordWidget extends StatefulWidget {
  final FetchForgotPasswordDataState dataState;

  const PhoneForgotPasswordWidget({super.key, required this.dataState});

  @override
  State<PhoneForgotPasswordWidget> createState() =>
      _PhoneForgotPasswordWidgetState();
}

class _PhoneForgotPasswordWidgetState extends State<PhoneForgotPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return _itemBuilder(dataState: widget.dataState);
  }

  Widget _itemBuilder({required FetchForgotPasswordDataState dataState}) {
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
                _logo(),
                _horizontalSpace(),
                _emailTextField(dataState: dataState),
                _horizontalSpace(),
                _submit(dataState: dataState),
                _horizontalSpace(),
                _loginPage(),
                _horizontalSpace(),
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
              top: 00.0,
              right: 00.0,
              bottom: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset(
                AppConfig.instanceInit()!.client == Client.mgl
                    ? AppIcon.appLogoMGL
                    : AppConfig.instanceInit()!.client == Client.unistal
                        ? AppIcon.appLogoUnistal
                        : AppIcon.appLogoIgl,
                width: MediaQuery.of(context).size.width * 0.30,
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
        child: Text(
          "Login",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: AppFont.font_16,
              color: AppColor.themeSecondary,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  _horizontalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.07,
    );
  }
}
