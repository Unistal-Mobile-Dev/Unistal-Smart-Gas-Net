import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/widget/phone_home_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/widget/tablet_home_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/message_box_two_button_pop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AppConfig.getDeviceType(context: context) == DeviceType.phone
          ? const PhoneHomeWidget()
          : const TabletHomeWidget(),
    );
  }

  Future<bool> _onWillPop() async {
    final bloc = context.read<HomeBloc>();

    // ✅ If not on dashboard → go back
    if (bloc.showBackButton) {
      bloc.add(BackToHomeEvent());
      return false;
    }

    // ✅ If on dashboard → confirm exit
    return (await showDialog(
      context: context,
      builder: (BuildContext mContext) =>
          MessageBoxTwoButtonPopWidget(
            message: "Do you want to exit an App?",
            okButtonText: "Exit",
            onPressed: () => Navigator.of(context).pop(true),
          ),
    )) ??
        false;
  }
}
