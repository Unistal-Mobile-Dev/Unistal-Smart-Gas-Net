import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/presentation/widget/phone_forgot_password_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/presentation/widget/tablet_forgot_password_widget.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/domain/bloc/forgot_password_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  @override
  void initState() {
    BlocProvider.of<ForgotPasswordBloc>(context).add(
        ForgotPasswordPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF2F2F2),
      body:
      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          if(state is FetchForgotPasswordDataState){
            return  AppConfig.getDeviceType(context: context) == DeviceType.phone
            ? PhoneForgotPasswordWidget(dataState: state)
             : TabletForgotPasswordWidget(dataState: state);
          } else if (state is ForgotPasswordPageLoadState){
            return const Center(child: CenterLoaderWidget(),);
          } else{
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }


}
