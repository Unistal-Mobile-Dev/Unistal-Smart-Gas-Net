import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/addCutPipe/domain/bloc/add_cut_pipe_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';

class AddCutPipePage extends StatefulWidget {
  const AddCutPipePage({super.key});

  @override
  State<AddCutPipePage> createState() => _AddCutPipePageState();
}

class _AddCutPipePageState extends State<AddCutPipePage> {
  @override
  void initState() {
    BlocProvider.of<AddCutPipeBloc>(context)
        .add(AddCutPipePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddCutPipeBloc, AddCutPipeState>(
        builder: (context, state) {
          if (state is FetchAddCutPipeDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return const Center(child: CenterLoaderWidget());
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddCutPipeDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            _pipeDropDown(dataState: dataState),
            _verticalSpace(),
            _cutPipeLengthController(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _pipeDropDown({required FetchAddCutPipeDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddCutPipeBloc>(context).add(
              AddCutPipeSearchPipeDataEvent(keyword: value, context: context));
        },
        onClick: (value) {
          BlocProvider.of<AddCutPipeBloc>(context)
              .add(AddCutPipeSelectPipeDataEvent(pipeData: value));
        },
        controller: dataState.searchPipeController,
        label: AppString.selectPipeNumber,
        list: dataState.searchPipeList);
  }

  Widget _cutPipeLengthController(
      {required FetchAddCutPipeDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.cutPipeLength,
      controller: dataState.cutPipeLengthController,
    );
  }

  Widget _button({required FetchAddCutPipeDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddCutPipeBloc>(context)
                  .add(AddCutPipeSubmitEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
