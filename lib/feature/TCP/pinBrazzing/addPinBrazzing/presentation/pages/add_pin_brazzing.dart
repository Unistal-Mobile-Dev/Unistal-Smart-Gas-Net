import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/pinBrazzing/addPinBrazzing/domain/bloc/add_pin_brazzing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddPinBrazzingPage extends StatefulWidget {
  const AddPinBrazzingPage({super.key});

  @override
  State<AddPinBrazzingPage> createState() => _AddPinBrazzingPageState();
}

class _AddPinBrazzingPageState extends State<AddPinBrazzingPage> {
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
    BlocProvider.of<AddPinBrazzingBloc>(context)
        .add(AddPinBrazzingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddPinBrazzingBloc, AddPinBrazzingState>(
        builder: (context, state) {
          if (state is FetchAddPinBrazzingState) {
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

  Widget _itemBuilder({required FetchAddPinBrazzingState dataState}) {
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
            _spacingController(dataState: dataState),
            _verticalSpace(),
            _cableController(dataState: dataState),
            _verticalSpace(),
            _epoxyController(dataState: dataState),
            _verticalSpace(),
            _cableSizeController(dataState: dataState),
            _verticalSpace(),
            _cableLengthController(dataState: dataState),
            _verticalSpace(),
            _pinBrazingDropDown(dataState: dataState),
            _verticalSpace(),
            _cableTrenchDropDown(dataState: dataState),
            _verticalSpace(),
            _restorationCheckDropDown(dataState: dataState),
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
  Widget _dateController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddPinBrazzingBloc>(context)
            .add(AddPinBrazzingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddPinBrazzingState dataState}) {
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
        BlocProvider.of<AddPinBrazzingBloc>(context)
            .add(AddPinBrazzingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddPinBrazzingState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddPinBrazzingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }
  Widget _chainageController(
      {required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddPinBrazzingState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPinBrazzingBloc>(context)
            .add(AddTestStationBoxTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }
  Widget _testStationLocationController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.testStationLocationController,
    );
  }
  Widget _testStationTypeController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestType,
      controller: dataState.testStationTypeController,
    );
  }
  Widget _spacingController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectSpacingConnection,
      controller: dataState.spacingController,
    );
  }
  Widget _cableController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCable,
      controller: dataState.cableController,
    );
  }  Widget _epoxyController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectEpoxy,
      controller: dataState.epoxyController,
    );
  }
  Widget _cableSizeController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCableSize,
      controller: dataState.cableSizeController,
    );
  }
  Widget _cableLengthController({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCableLength,
      controller: dataState.cableLengthController,
    );
  }

  Widget _pinBrazingDropDown({required FetchAddPinBrazzingState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectPinBrazing,
      dropdownValue:
      dataState.pinBrazingValue.id != null ? dataState.pinBrazingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPinBrazzingBloc>(context)
            .add(AddTestStationBoxPinBrazingEvent(pinBrazingValue: value!));
      },
      items: dataState.listOfPinBrazing
    );
  }

  Widget _cableTrenchDropDown({required FetchAddPinBrazzingState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCableTrench,
      dropdownValue:
      dataState.continuityCheckValue.id != null ? dataState.continuityCheckValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPinBrazzingBloc>(context)
            .add(AddTestStationBoxContinuityCheckEvent(continuityCheckValue: value!));
      },
      items: dataState.listOfContinuityCheck
    );
  }

  Widget _restorationCheckDropDown({required FetchAddPinBrazzingState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectRestorationCheck,
      dropdownValue:
      dataState.restorationCheckValue.id != null ? dataState.restorationCheckValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPinBrazzingBloc>(context)
            .add(AddTestStationBoxRestorationCheckEvent(restorationCheckValue: value!));
      },
      items: dataState.listOfRestorationCheck
    );
  }
  Widget _activityRemark({required FetchAddPinBrazzingState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddPinBrazzingState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>   BlocProvider.of<AddPinBrazzingBloc>(context).add(
            AddPinBrazzingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddPinBrazzingBloc>(context).add(
            AddPinBrazzingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddPinBrazzingState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddPinBrazzingBloc>(context)
              .add(AddPinBrazzingSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}