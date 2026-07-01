import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/bloc/add_concrete_coating_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddConcreteCoatingPage extends StatefulWidget {
  const AddConcreteCoatingPage({super.key});

  @override
  State<AddConcreteCoatingPage> createState() => _AddConcreteCoatingPageState();
}

class _AddConcreteCoatingPageState extends State<AddConcreteCoatingPage> {
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
    BlocProvider.of<AddConcreteCoatingBloc>(context)
        .add(AddConcreteCoatingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddConcreteCoatingBloc, AddConcreteCoatingState>(
        builder: (context, state) {
          if (state is FetchAddConcreteCoatingDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return const Center(
              child: CenterLoaderWidget(),
            );
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddConcreteCoatingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL || _isVRPL || _isBJPL)...[
              _formatNoField(),
              _verticalSpace(),
            ],
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _pipeDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _concreteCoatingThicknessDropDown(dataState: dataState),
            _verticalSpace(),
            _concreteCoatingLengthController(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue: AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }

  Widget _reportNumberController({
    required FetchAddConcreteCoatingDataState dataState,
  }) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _dateController(
      {required FetchAddConcreteCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddConcreteCoatingBloc>(context)
            .add(AddConcreteCoatingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _pipeDropDown({required FetchAddConcreteCoatingDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddConcreteCoatingBloc>(context).add(
              AddConcreteCoatingAddSearchPipeDataEvent(
                  keyword: value, context: context));
        },
        onClick: (value) {
          BlocProvider.of<AddConcreteCoatingBloc>(context).add(
              AddConcreteCoatingSelectSelectPipeDataEvent(pipeData: value));
        },
        controller: dataState.searchPipeController,
        label: AppString.selectPipeNumber,
        list: dataState.searchPipeList);
  }

  Widget _chainageController(
      {required FetchAddConcreteCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _concreteCoatingThicknessDropDown(
      {required FetchAddConcreteCoatingDataState dataState}) {
    return DropdownWidget<ThicknessModel>(
      hint: AppString.concreteCoatingThickness,
      dropdownValue:
          dataState.thicknessData.id != null ? dataState.thicknessData : null,
      onChanged: (value) {
        BlocProvider.of<AddConcreteCoatingBloc>(context).add(
            AddConcreteCoatingSelectSelectThicknessDataEvent(
                thicknessData: value!));
      },
      items: dataState.thicknessList,
    );
  }

  Widget _concreteCoatingLengthController(
      {required FetchAddConcreteCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.concreteCoatingLength,
      controller: dataState.concreteCoatingLengthController,
    );
  }

  Widget _activityRemark(
      {required FetchAddConcreteCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddConcreteCoatingDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddConcreteCoatingBloc>(context)
            .add(AddConcreteCoatingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddConcreteCoatingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddConcreteCoatingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList,
    );
  }
  Widget _photo({required FetchAddConcreteCoatingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddConcreteCoatingBloc>(context).add(
            AddConcreteCoatingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddConcreteCoatingBloc>(context).add(
            AddConcreteCoatingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddConcreteCoatingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddConcreteCoatingBloc>(context)
                  .add(AddConcreteCoatingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
