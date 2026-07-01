import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/ssd/addSSD/domain/bloc/add_ssd_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddSsdPage extends StatefulWidget {
  const AddSsdPage({super.key});

  @override
  State<AddSsdPage> createState() => _AddSsdPageState();
}

class _AddSsdPageState extends State<AddSsdPage> {
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
    BlocProvider.of<AddSsdBloc>(context)
        .add(AddSsdPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddSsdBloc, AddSsdState>(
        builder: (context, state) {
          if (state is FetchAddSsdState) {
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

  Widget _itemBuilder({required FetchAddSsdState dataState}) {
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
            _voltageController(dataState: dataState),
            _verticalSpace(),
            _htTowerController(dataState: dataState),
            _verticalSpace(),
            _installationDropDown(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _checkACVolDropDown(dataState: dataState),
            _verticalSpace(),
            _pspDropDown(dataState: dataState),
            _verticalSpace(),
            _finalRestorationDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddSsdState dataState}) {
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
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _chainageController(
      {required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }
  Widget _locationController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.locationController,
    );
  }

  Widget _voltageController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectVoltageRating,
      controller: dataState.voltageController,
    );
  }
  Widget _htTowerController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectHTTower,
      controller: dataState.htTowerController,
    );
  }

  Widget _installationDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectInstallation,
      dropdownValue:
      dataState.installationValue.id != null ? dataState.installationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdInstallationEvent(installationValue: value!));
      },
      items: dataState.listOfInstallation
    );
  }

  Widget _cableTerminationDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCableTermination,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdCableTerminationEvent(cableTerminationValue: value!));
      },
      items: dataState.listOfCableTermination
    );
  }

  Widget _checkACVolDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCheckACVol,
      dropdownValue:
      dataState.checkACVolValue.id != null ? dataState.checkACVolValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdCheckACVolEvent(checkACVolValue: value!));
      },
      items: dataState.listOfCheckACVol
    );
  }

  Widget _pspDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectPSP,
      dropdownValue:
      dataState.pspValue.id != null ? dataState.pspValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdPSPEvent(pspValue: value!));
      },
      items: dataState.listOfPSP
    );
  }

  Widget _finalRestorationDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectFinalRestoration,
      dropdownValue:
      dataState.finalRestorationValue.id != null ? dataState.finalRestorationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdFinalRestorationEvent(finalRestorationValue: value!));
      },
      items: dataState.listOfFinalRestoration
    );
  }

  Widget _activityRemark({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddSsdState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddSsdBloc>(context).add(
            AddSsdAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddSsdBloc>(context).add(
            AddSsdAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }


  Widget _button({required FetchAddSsdState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddSsdBloc>(context)
              .add(AddSsdSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}


