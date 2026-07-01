import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/surgeDiverter/addSurgeDiverter/domain/bloc/add_surge_diverter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddSurgeDiverterPage extends StatefulWidget {
  const AddSurgeDiverterPage({super.key});

  @override
  State<AddSurgeDiverterPage> createState() => _AddSurgeDiverterPageState();
}

class _AddSurgeDiverterPageState extends State<AddSurgeDiverterPage> {
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
    BlocProvider.of<AddSurgeDiverterBloc>(context)
        .add(AddSurgeDiverterPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddSurgeDiverterBloc, AddSurgeDiverterState>(
        builder: (context, state) {
          if (state is FetchAddSurgeDiverterState) {
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

  Widget _itemBuilder({required FetchAddSurgeDiverterState dataState}) {
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
            _locationController(dataState: dataState),
            _verticalSpace(),
            _surgeDiverterController(dataState: dataState),
            _verticalSpace(),
            _installationDropDown(dataState: dataState),
            _verticalSpace(),
            _cableConnectionDropDown(dataState: dataState),
            _verticalSpace(),
            _pspReadingProtectionController(dataState: dataState),
            _verticalSpace(),
            _pspReadingOtherController(dataState: dataState),
            _verticalSpace(),
            _polarityCheckController(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _backfillDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddSurgeDiverterState dataState}) {
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
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _chainageController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }

  Widget _locationController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.locationController,
    );
  }

  Widget _surgeDiverterController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.routeSurvey,
      controller: dataState.surgeDiverterController,
    );
  }

  Widget _installationDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectInstallation,
      dropdownValue:
      dataState.installationValue.id != null ? dataState.installationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterInstallationEvent(installationValue: value!));
      },
      items: dataState.listOfInstallation
    );
  }

  Widget _cableConnectionDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCableConnection,
      dropdownValue:
      dataState.cableConnectionValue.id != null ? dataState.cableConnectionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterCableConnectionEvent(cableConnectionValue: value!));
      },
      items: dataState.listOfCableConnection
    );
  }

  Widget _pspReadingProtectionController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPSPReadingProtection,
      controller: dataState.pspReadingProtectionController,
    );
  }

  Widget _pspReadingOtherController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPSPReadingOther,
      controller: dataState.pspReadingOtherController,
    );
  }

  Widget _polarityCheckController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPolarityCheck,
      controller: dataState.polarityCheckController,
    );
  }

  Widget _cableTerminationDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCableTermination,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterCableTerminationEvent(cableTerminationValue: value!));
      },
      items: dataState.listOfCableTermination
    );
  }
  Widget _backfillDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectBackfilling,
      dropdownValue:
      dataState.backfillValue.id != null ? dataState.backfillValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterBackfillEvent(backfillValue: value!));
      },
      items: dataState.listOfBackfill
    );
  }

  Widget _activityRemark({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddSurgeDiverterState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddSurgeDiverterBloc>(context).add(
            AddSurgeDiverterAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddSurgeDiverterBloc>(context).add(
            AddSurgeDiverterAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddSurgeDiverterState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddSurgeDiverterBloc>(context)
              .add(AddSurgeDiverterSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}


