import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/preHydrotest/addPreHydrotest/domain/bloc/add_pre_hydrotest_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddPreHydroTestPage extends StatefulWidget {
  const AddPreHydroTestPage({super.key});

  @override
  State<AddPreHydroTestPage> createState() => _AddPreHydroTestPageState();
}

class _AddPreHydroTestPageState extends State<AddPreHydroTestPage> {
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
    BlocProvider.of<AddPreHydrotestBloc>(context)
        .add(AddPreHydrotestPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddPreHydrotestBloc, AddPreHydrotestState>(
        builder: (context, state) {
          if (state is FetchAddPreHydrotestDataState) {
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

  Widget _itemBuilder({required FetchAddPreHydrotestDataState dataState}) {
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
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _pressureGaugeNoController(dataState: dataState),
            _verticalSpace(),
            _pressureGaugeCalibrationDateController(dataState: dataState),
            _verticalSpace(),
            _testPressureController(dataState: dataState),
            _verticalSpace(),
            _rangeController(dataState: dataState),
            _verticalSpace(),
            _pipeSizeController(dataState: dataState),
            _verticalSpace(),
            _durationController(dataState: dataState),
            _verticalSpace(),
            _timeOnController(dataState: dataState),
            _verticalSpace(),
            _timeOffController(dataState: dataState),
            _verticalSpace(),
/*            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chaingeToController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _timeInHoursController(dataState: dataState),
            _verticalSpace(),
            _pressureReading1KGController(dataState: dataState),
            _verticalSpace(),
            _pressureReading2KGController(dataState: dataState),
            _verticalSpace(),
            _tempController(dataState: dataState),
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
  Widget _dateController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(AddPreHydrotestSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddPreHydrotestDataState dataState}) {
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
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(AddPreHydrotestMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddPreHydrotestDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown(
      {required FetchAddPreHydrotestDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context).add(
            AddPreHydrotestSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddPreHydrotestDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.fromJointData.id != null ? dataState.fromJointData : null,
      hint: AppString.selectFromJointNumber,
      items: dataState.jointFromList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context).add(
            AddPreHydrotestSelectFromJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _toJointNumberDropDown(
      {required FetchAddPreHydrotestDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.toJointData.id != null ? dataState.toJointData : null,
      hint: AppString.selectToJointNumber,
      items: dataState.jointToList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(AddPreHydrotestSelectToJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _pressureGaugeNoController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: AppString.pressureGaugeNo,
      controller: dataState.pressureGaugeNoController,
    );
  }

  Widget _pressureGaugeCalibrationDateController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.pressureGaugeCalibrationDate,
      controller: dataState.pressureGaugeCalibrationDateController,
      onTap: () {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(AddPreHydrotestSelectPressureDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _testPressureController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: AppString.testPressure,
      controller: dataState.testPressureController,
    );
  }

  Widget _rangeController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.range,
      controller: dataState.rangeController,
    );
  }

  Widget _pipeSizeController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: AppString.pipeSize,
      controller: dataState.pipeSizeController,
    );
  }

  Widget _durationController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.duration,
      controller: dataState.durationController,
    );
  }

  Widget _timeOnController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.timeOn,
      controller: dataState.timeOnController,
    );
  }

  Widget _timeOffController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.timeOff,
      controller: dataState.timeOffController,
    );
  }

  Widget _timeInHoursController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.timeInHours,
      controller: dataState.timeInHoursController,
    );
  }

  Widget _pressureReading1KGController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.pressureReading1Kg,
      controller: dataState.pressureReading1KGController,
    );
  }

  Widget _pressureReading2KGController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.pressureReading2Kg,
      controller: dataState.pressureReading2KGController,
    );
  }

  Widget _tempController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.temp,
      controller: dataState.tempController,
    );
  }

  Widget _chainageFromController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: true, value: value, context: context));
      },
    );
  }

  Widget _chaingeToController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: true, value: value, context: context));
      },
    );
  }

  Widget _lengthController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.sectionLength,
      controller: dataState.lengthController,
    );
  }

  Widget _activityRemark({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddPreHydrotestDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddPreHydrotestBloc>(context).add(
            AddPreHydrotestAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddPreHydrotestBloc>(context).add(
            AddPreHydrotestAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddPreHydrotestDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddPreHydrotestBloc>(context)
                  .add(AddPreHydrotestSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
