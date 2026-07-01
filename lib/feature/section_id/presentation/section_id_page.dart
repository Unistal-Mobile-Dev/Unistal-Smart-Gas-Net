import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/page/home_page.dart';
import 'package:flutter_unistal_smart_gas_net/feature/section_id/domain/bloc/section_id_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/section_id/domain/bloc/section_id_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/section_id/domain/bloc/section_id_state.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/text_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_font.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class SectionIdPage extends StatefulWidget {
  const SectionIdPage({super.key});

  @override
  State<SectionIdPage> createState() => _SectionIdPageState();
}

class _SectionIdPageState extends State<SectionIdPage> {

  @override
  void initState() {
    BlocProvider.of<SectionIdBloc>(context)
        .add(SectionIdPageLoadEvent(context: context));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: EnvironmentConfig.of(context)!.primaryTheme,
        title: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is FetchHomeDataState) {
            return TextWidget(
              state.title,
              color: AppColor.white,
              fontSize: AppFont.font_16,
              fontWeight: FontWeight.w700,
            );
          } else {
            return TextWidget(
              AppString.appName,
              color: AppColor.white,
              fontSize: AppFont.font_16,
              fontWeight: FontWeight.w700,
            );
          }
        }),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is FetchHomeDataState) {
                return state.actionButtonWidget;
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<SectionIdBloc, SectionIdState>(
          builder: (context, state) {
            if (state is SectionIdDataState) {
              final list = state.listActivityData;

              if (list.isEmpty) {
                return const Center(child: Text('No activities found'));
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.sectionName.toString()),
                      subtitle: Text(item.sectionId.toString()),
                      onTap: (){
                        AppConfig.instanceInit()?.setSectionId(newSectionId: item.sectionId.toString());
                        Navigator.push(
                         context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        )

      ),
    );
  }
}
