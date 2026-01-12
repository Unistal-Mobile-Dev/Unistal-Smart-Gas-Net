import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/restoreCutePipe/domain/bloc/restore_cut_pipe_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class RestoreCutPipePage extends StatefulWidget {
  const RestoreCutPipePage({super.key});

  @override
  State<RestoreCutPipePage> createState() => _RestoreCutPipePageState();
}

class _RestoreCutPipePageState extends State<RestoreCutPipePage> {
  @override
  void initState() {
    BlocProvider.of<RestoreCutPipeBloc>(context)
        .add(RestoreCutePipePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          "Restore Cut Pipe",
          color: AppColor.white,
          fontSize: AppFont.font_16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BlocBuilder<RestoreCutPipeBloc, RestoreCutPipeState>(
        builder: (context, state) {
          if (state is FetchRestoreCutPipeDataState) {
            return _listBuilder(dataState: state);
          } else {
            return const Center(
              child: CenterLoaderWidget(),
            );
          }
        },
      ),
    );
  }

  Widget _listBuilder({required FetchRestoreCutPipeDataState dataState}) {
    return dataState.pipeList.isNotEmpty
        ? Container(
            margin: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: dataState.pipeList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: EnvironmentConfig.of(context)!.primaryTheme,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              "Pipe Number : ${dataState.pipeList[index].pipeNumber}",
                              fontWeight: FontWeight.w700,
                            ),
                            TextWidget(
                                "Pipe Length : ${dataState.pipeList[index].pipeLength}"),
                          ],
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: dataState.pipeList[index].isSelected == false
                              ? ButtonWidget(
                                  text: AppString.restore,
                                  onPressed: () {
                                    BlocProvider.of<RestoreCutPipeBloc>(context)
                                        .add(RestoreCutePipeSubmitEvent(
                                            context: context, index: index));
                                  })
                              : const DottedLoaderWidget(),
                        ),
                      ],
                    ),
                  );
                }),
          )
        : const Center(
            child: TextWidget("No Cute Pipe Data Found"),
          );
  }
}
