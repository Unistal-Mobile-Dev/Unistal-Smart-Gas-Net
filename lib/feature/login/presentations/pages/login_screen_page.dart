import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/presentations/Widgets/phone_login_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/presentations/Widgets/tablet_login_widget.dart';

import '../../domain/bloc/login_bloc.dart';
import '../../domain/bloc/login_event.dart';
import '../../domain/bloc/login_state.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
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
    BlocProvider.of<LoginBloc>(context).add(LoginPageLoadingEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is FetchLoginStateData) {
            return Center(
              child:
                  AppConfig.getDeviceType(context: context) == DeviceType.phone
                      ? PhoneLoginWidget(dataState: state)
                      : TabletLoginWidget(
                          dataState: state,
                        ),
            );
          } else {
            return const Center(
              child: CenterLoaderWidget(),
            );
          }
        },
      ),
    );
  }
}
