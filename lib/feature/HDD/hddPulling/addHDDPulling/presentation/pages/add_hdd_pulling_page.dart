import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddPulling/addHDDPulling/domain/bloc/add_hdd_pulling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddHddPullingPage extends StatefulWidget {
  const AddHddPullingPage({super.key});

  @override
  State<AddHddPullingPage> createState() => _AddHddPullingPageState();
}

class _AddHddPullingPageState extends State<AddHddPullingPage> {
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
    BlocProvider.of<AddHddPullingBloc>(context)
        .add(AddHddPullingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddHddPullingBloc, AddHddPullingState>(
        builder: (context, state) {
          if (state is FetchAddHddPullingDataState) {
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

  Widget _itemBuilder({required FetchAddHddPullingDataState dataState}) {
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
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _startDatePullingController(dataState: dataState),
            _verticalSpace(),
            _endDateOfPullingController(dataState: dataState),
            _verticalSpace(),
            _machineCapacityController(dataState: dataState),
            _verticalSpace(),
            _sizePullingController(dataState: dataState),
            _verticalSpace(),
            _reamerSizeController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _rodNoController(dataState: dataState),
            _verticalSpace(),
            _totalLengthController(dataState: dataState),
            _verticalSpace(),
            _rigOutputLoad(dataState: dataState),
            _verticalSpace(),
            _pumpRateController(dataState: dataState),
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

  Widget _dateController({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHddPullingBloc>(context)
            .add(AddHddPullingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddHddPullingDataState dataState}) {
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
        BlocProvider.of<AddHddPullingBloc>(context)
            .add(AddHddPullingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddHddPullingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddHddPullingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddHddPullingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
      dataState.jointTypeDataValue.id != null ? dataState.jointTypeDataValue : null,
      onChanged: (value) {
        BlocProvider.of<AddHddPullingBloc>(context).add(
            SelectJointTypeDataEvent(
                jointTypeDataValue: value!, context: context));
      },
      items: dataState.listOfJointType
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddHddPullingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointValue.id != null
          ? dataState.fromJointValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddHddPullingBloc>(context).add(
            SelectFromJointEvent(fromJointValue: value!));
      },
      items: dataState.listOfFromJoint
    )
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown(
      {required FetchAddHddPullingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      hint: AppString.selectToJointNumber,
      dropdownValue:
      dataState.toJointValue.id != null ? dataState.toJointValue : null,
      onChanged: (value) {
        BlocProvider.of<AddHddPullingBloc>(context).add(
            SelectToJointEvent(toJointValue: value!));
      },
      items: dataState.listOfToJoint
    )
        : const DottedLoaderWidget();
  }

  Widget _startDatePullingController({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectStartDatePulling,
      controller: dataState.startDatePullingController,
      onTap: () {
        BlocProvider.of<AddHddPullingBloc>(context)
            .add(AddHddPullingStartingDateOfPilotHoleEvent(
          context: context,
        ));
      },
    );
  }

  Widget _endDateOfPullingController({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectEndDatePulling,
      controller: dataState.endDateOfPullingController,
      onTap: () {
        BlocProvider.of<AddHddPullingBloc>(context)
            .add(AddHddPullingEndDateOfPilotHoleEvent(
          context: context,
        ));
      },
    );
  }

  Widget _machineCapacityController(
      {required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectHDDMachineCapacity,
      controller: dataState.machineCapacityController,
    );
  }

  Widget _sizePullingController({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectSizePulling,
      controller: dataState.sizePullingController,
    );
  }

  Widget _reamerSizeController({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectReamerSize,
      controller: dataState.reamerSizeController,
    );
  }

  Widget _lengthController(
      {required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectLength,
      textInputType: TextInputType.number,
      controller: dataState.lengthController,
    );
  }

  Widget _rodNoController({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectRodNo,
      controller: dataState.rodNoController,
    );
  }

  Widget _totalLengthController({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectTotalReamingLength,
      textInputType: TextInputType.number,
      controller: dataState.totalLengthController,
    );
  }

  Widget _rigOutputLoad({required FetchAddHddPullingDataState dataState}){
    return DottedBorderWidget(
      title: "Rig Output Load",
      children: [
        TextFieldWidget(
          isRequired: true,
          textInputType: TextInputType.number,
          labelText: AppString.selectPullBackPressure,
          controller: dataState.pullBackPressureController,
        ),
        _verticalSpace(),
        TextFieldWidget(
          isRequired: true,
          textInputType: TextInputType.number,
          labelText: AppString.selectRotaryPressure,
          controller: dataState.pullBackPressureController,
        ),
      ],
    );
  }


  Widget _pumpRateController({required FetchAddHddPullingDataState dataState}){
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectPumpRate,
      controller: dataState.pumpRateController,
    );
  }

  Widget _activityRemark({required FetchAddHddPullingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddHddPullingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddHddPullingBloc>(context).add(
            AddHddPullingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddHddPullingBloc>(context).add(
            AddHddPullingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddHddPullingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddHddPullingBloc>(context)
              .add(AddHddPullingSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

