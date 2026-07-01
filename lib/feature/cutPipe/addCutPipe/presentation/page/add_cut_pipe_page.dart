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
    BlocProvider.of<AddCutPipeBloc>(context)
        .add(AddCutPipePageLoadEvent(context: context));

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
/*            _verticalSpace(),
            _reportNumberController(dataState: dataState),*/
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

  Widget _reportNumberController(
      {required FetchAddCutPipeDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
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
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
