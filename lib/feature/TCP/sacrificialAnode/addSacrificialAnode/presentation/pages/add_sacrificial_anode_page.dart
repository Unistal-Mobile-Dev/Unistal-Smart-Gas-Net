import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/sacrificialAnode/addSacrificialAnode/domain/bloc/add_sacrificial_anode_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddSacrificialAnodePage extends StatefulWidget {
  const AddSacrificialAnodePage({super.key});

  @override
  State<AddSacrificialAnodePage> createState() => _AddSacrificialAnodePageState();
}

class _AddSacrificialAnodePageState extends State<AddSacrificialAnodePage> {
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
    BlocProvider.of<AddSacrificialAnodeBloc>(context)
        .add(AddSacrificialAnodePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddSacrificialAnodeBloc, AddSacrificialAnodeState>(
        builder: (context, state) {
          if (state is FetchAddSacrificialAnodeState) {
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

  Widget _itemBuilder({required FetchAddSacrificialAnodeState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL  ||_isVRPL || _isBJPL)...[
              _formatNoField(),
              _verticalSpace(),
            ],
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _tlpTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _areaController(dataState: dataState),
            _verticalSpace(),
            _testStationLocationController(dataState: dataState),
            _verticalSpace(),
            _testStationTypeController(dataState: dataState),
            _verticalSpace(),
            _testStationController(dataState: dataState),
            _verticalSpace(),
            _sacrificialAnodeDropDown(dataState: dataState),
            _verticalSpace(),
            _distanceController(dataState: dataState),
            _verticalSpace(),
            _noAnodesController(dataState: dataState),
            _verticalSpace(),
            _spacingAnodesController(dataState: dataState),
            _verticalSpace(),
            _outputAnodesController(dataState: dataState),
            _verticalSpace(),
            _anodeConditionDropDown(dataState: dataState),
            _verticalSpace(),
            _anode(dataState: dataState),
            _verticalSpace(),
            _anodeCircuitController(dataState: dataState),
            _verticalSpace(),
            _beforeAnodeController(dataState: dataState),
            _verticalSpace(),
            _afterAnodeController(dataState: dataState),
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

  Widget _dateController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddSacrificialAnodeSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddSacrificialAnodeState dataState}) {
    return DropDownSearchMultiSelectWidget(
      isRequired: true,
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddSacrificialAnodeMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _chainageController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }
  Widget _tlpTypeDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddTestStationBoxTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }

  Widget _testStationLocationController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectAnodeLocation,
      controller: dataState.testStationLocationController,
    );
  }

  Widget _testStationTypeController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestType,
      controller: dataState.testStationTypeController,
    );
  }

  Widget _testStationController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestStation,
      controller: dataState.testStationController,
    );
  }

  Widget _sacrificialAnodeDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectSacrificialAnode,
      dropdownValue:
      dataState.sacrificialAnodeValue.id != null ? dataState.sacrificialAnodeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddTestStationBoxSacrificialAnodeTypeEvent(sacrificialAnodeValue: value!));
      },
      items: dataState.listOfSacrificialAnode
    );
  }

  Widget _distanceController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectDistance,
      controller: dataState.distanceController,
    );
  }

  Widget _noAnodesController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectAnode,
      controller: dataState.noAnodesController,
    );
  }

  Widget _spacingAnodesController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectSpacingAnode,
      controller: dataState.spacingAnodesController,
    );
  }

  Widget _outputAnodesController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectOutputAnode,
      controller: dataState.outputAnodesController,
    );
  }

  Widget _anodeConditionDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectAnodeCondition,
      dropdownValue:
      dataState.anodeConditionValue.id != null ? dataState.anodeConditionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddTestStationBoxAnodeConditionEvent(anodeConditionValue: value!));
      },
      items: dataState.listOfAnodeCondition
    );
  }

  Widget _anode({required FetchAddSacrificialAnodeState dataState}){
    return DottedBorderWidget(
      title: "Anode Tail Cable Length(mtr)",
      children: [
        _verticalSpace(),
        _a1Controller(dataState: dataState),
        _verticalSpace(),
        _a2Controller(dataState: dataState),
        _verticalSpace(),
        _a3Controller(dataState: dataState),
      ],
    );
  }

  Widget _a1Controller({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA1,
      controller: dataState.a1Controller,
    );
  }

  Widget _a2Controller({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA2,
      controller: dataState.a2Controller,
    );
  }

  Widget _a3Controller({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA3,
      controller: dataState.a3Controller,
    );
  }

  Widget _anodeCircuitController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectAnodeCircuit,
      controller: dataState.anodeCircuitController,
    );
  }

  Widget _beforeAnodeController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectBeforePSP,
      controller: dataState.beforeAnodeController,
    );
  }

  Widget _afterAnodeController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectAfterPSP,
      controller: dataState.afterAnodeController,
    );
  }



  Widget _activityRemark({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddSacrificialAnodeState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddSacrificialAnodeBloc>(context).add(
            AddSacrificialAnodeAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddSacrificialAnodeBloc>(context).add(
            AddSacrificialAnodeAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }


  Widget _button({required FetchAddSacrificialAnodeState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddSacrificialAnodeBloc>(context)
              .add(AddSacrificialAnodeSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}


