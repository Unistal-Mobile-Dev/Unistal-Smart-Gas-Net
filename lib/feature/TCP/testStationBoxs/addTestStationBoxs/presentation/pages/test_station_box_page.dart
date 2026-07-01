import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/bloc/add_test_station_box_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddTestStationBoxPage extends StatefulWidget {
  const AddTestStationBoxPage({super.key});

  @override
  State<AddTestStationBoxPage> createState() => _AddTestStationBoxPageState();
}

class _AddTestStationBoxPageState extends State<AddTestStationBoxPage> {
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
    BlocProvider.of<AddTestStationBoxBloc>(context)
        .add(AddTestStationBoxPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddTestStationBoxBloc, AddTestStationBoxState>(
        builder: (context, state) {
          if (state is FetchAddTestStationBoxState) {
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

  Widget _itemBuilder({required FetchAddTestStationBoxState dataState}) {
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
            _areaController(dataState: dataState),
            _verticalSpace(),
            _tlpTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _testStationLocationController(dataState: dataState),
            _verticalSpace(),
            _testStationTypeController(dataState: dataState),
            _verticalSpace(),
            _distanceDropDown(dataState: dataState),
            _verticalSpace(),
            _foundationCheckDropDown(dataState: dataState),
            _verticalSpace(),
            _testLocationDropDown(dataState: dataState),
            _verticalSpace(),
            _tsDoorsDropDown(dataState: dataState),
            _verticalSpace(),
            _cableEntrySealingDropDown(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _namePlateDropDown(dataState: dataState),
            _verticalSpace(),
            _individualResistorDropDown(dataState: dataState),
            _verticalSpace(),
            _compactionDropDown(dataState: dataState),
            _verticalSpace(),
            _cableSealingDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddTestStationBoxState dataState}) {
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
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _chainageController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }
  Widget _tlpTypeDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }

  Widget _testStationLocationController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.testStationLocationController,
    );
  }

  Widget _testStationTypeController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectTestType,
      controller: dataState.testStationTypeController,
    );
  }

  Widget _distanceDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.distanceValue.id != null ? dataState.distanceValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxDistanceEvent(distanceValue: value!));
      },
      items: dataState.listOfDistance
    );
  }

  Widget _foundationCheckDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectFoundation,
      dropdownValue:
      dataState.foundationCheckValue.id != null ? dataState.foundationCheckValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxFoundationCheckEvent(foundationCheckValue: value!));
      },
      items: dataState.listOfFoundationCheck
    );
  }

  Widget _testLocationDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectTestLocation,
      dropdownValue:
      dataState.tsMountingValue.id != null ? dataState.tsMountingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxTestStationMountingEvent(tsMountingValue: value!));
      },
      items: dataState.listOfTSMounting
    );
  }

  Widget _tsDoorsDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.tsDoorsValue.id != null ? dataState.tsDoorsValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxTestStationDoorsEvent(tsDoorsValue: value!));
      },
      items: dataState.listOfTSDoors
    );
  }

  Widget _cableEntrySealingDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCable,
      dropdownValue:
      dataState.cableEntrySealingValue.id != null ? dataState.cableEntrySealingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCableEntrySealingEvent(cableEntrySealingValue: value!));
      },
      items: dataState.listOfCableEntrySealing
    );
  }
  Widget _cableTerminationDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCableTerminationEvent(cableTerminationValue: value!));
      },
      items: dataState.listOfCableTermination
    );
  }
  Widget _namePlateDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectNamePlate,
      dropdownValue:
      dataState.namePlateValue.id != null ? dataState.namePlateValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxNamePlateEvent(namePlateValue: value!));
      },
      items: dataState.listOfNmePlate
    );
  }
  Widget _individualResistorDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.individualResistorValue.id != null ? dataState.individualResistorValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxIndividualResistorEvent(individualResistorValue: value!));
      },
      items: dataState.listOfIndividualResistor
    );
  }
  Widget _compactionDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCompaction,
      dropdownValue:
      dataState.compactionValue.id != null ? dataState.compactionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCompactionEvent(compactionValue: value!));
      },
      items: dataState.listOfCompaction
    );
  }
  Widget _cableSealingDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCableSealing,
      dropdownValue:
      dataState.cableSealingValue.id != null ? dataState.cableSealingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCableSealingEvent(cableSealingValue: value!));
      },
      items: dataState.listOfCableSealing
    );
  }

  Widget _activityRemark({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddTestStationBoxState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddTestStationBoxBloc>(context).add(
            AddTestStationBoxAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddTestStationBoxBloc>(context).add(
            AddTestStationBoxAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }


  Widget _button({required FetchAddTestStationBoxState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddTestStationBoxBloc>(context)
              .add(AddTestStationBoxSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}


