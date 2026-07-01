import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddCleanPass/addHDDCleanPass/domain/bloc/add_hdd_clean_pass_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/button_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/center_loader_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dotted_loader_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/text_field_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/enums.dart';

class AddHddCleanPassPage extends StatefulWidget {
  const AddHddCleanPassPage({super.key});

  @override
  State<AddHddCleanPassPage> createState() => _AddHddCleanPassPageState();
}

class _AddHddCleanPassPageState extends State<AddHddCleanPassPage> {
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
    BlocProvider.of<AddHddCleanPassBloc>(context)
        .add(AddHddCleanPassPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddHddCleanPassBloc, AddHddCleanPassState>(
        builder: (context, state) {
          if (state is FetchAddHddCleanPassDataState) {
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

  Widget _itemBuilder({required FetchAddHddCleanPassDataState dataState}) {
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
            _startDateCleanPassController(dataState: dataState),
            _verticalSpace(),
            _endDateOfCleanPassController(dataState: dataState),
            _verticalSpace(),
            _machineCapacityController(dataState: dataState),
            _verticalSpace(),
            _sizeCleanPassController(dataState: dataState),
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

  Widget _dateController({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHddCleanPassBloc>(context)
            .add(AddHddCleanPassSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddHddCleanPassDataState dataState}) {
    return  DropDownSearchMultiSelectWidget(
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
        BlocProvider.of<AddHddCleanPassBloc>(context)
            .add(AddHddCleanPassMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddHddCleanPassDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCleanPassBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddHddCleanPassDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
      dataState.jointTypeDataValue.id != null ? dataState.jointTypeDataValue : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCleanPassBloc>(context).add(
            SelectJointTypeDataEvent(
                jointTypeDataValue: value!, context: context));
      },
      items: dataState.listOfJointType
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddHddCleanPassDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointValue.id != null
          ? dataState.fromJointValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCleanPassBloc>(context).add(
            SelectFromJointEvent(fromJointValue: value!));
      },
      items: dataState.listOfFromJoint
    )
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown(
      {required FetchAddHddCleanPassDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      hint: AppString.selectToJointNumber,
      dropdownValue:
      dataState.toJointValue.id != null ? dataState.toJointValue : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCleanPassBloc>(context).add(
            SelectToJointEvent(toJointValue: value!));
      },
      items: dataState.listOfToJoint
    )
        : const DottedLoaderWidget();
  }

  Widget _startDateCleanPassController({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectStartDateCleanPass,
      controller: dataState.startDateCleanPassController,
      onTap: () {
        BlocProvider.of<AddHddCleanPassBloc>(context)
            .add(AddHddCleanPassStartingDateOfPilotHoleEvent(
          context: context,
        ));
      },
    );
  }

  Widget _endDateOfCleanPassController({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectEndDateCleanPass,
      controller: dataState.endDateOfCleanPassController,
      onTap: () {
        BlocProvider.of<AddHddCleanPassBloc>(context)
            .add(AddHddCleanPassEndDateOfPilotHoleEvent(
          context: context,
        ));
      },
    );
  }

  Widget _machineCapacityController(
      {required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectHDDMachineCapacity,
      controller: dataState.machineCapacityController,
    );
  }

  Widget _sizeCleanPassController({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectSizeCleanPass,
      controller: dataState.sizeCleanPassController,
    );
  }

  Widget _reamerSizeController({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectReamerSize,
      controller: dataState.reamerSizeController,
    );
  }

  Widget _lengthController(
      {required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectLength,
      textInputType: TextInputType.number,
      controller: dataState.lengthController,
    );
  }

  Widget _rodNoController({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectRodNo,
      controller: dataState.rodNoController,
    );
  }

  Widget _totalLengthController({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectTotalReamingLength,
      textInputType: TextInputType.number,
      controller: dataState.totalLengthController,
    );
  }

  Widget _rigOutputLoad({required FetchAddHddCleanPassDataState dataState}){
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
          controller: dataState.rotaryPressureController,
        ),
      ],
    );
  }


  Widget _pumpRateController({required FetchAddHddCleanPassDataState dataState}){
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectPumpRate,
      controller: dataState.pumpRateController,
    );
  }

  Widget _activityRemark({required FetchAddHddCleanPassDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddHddCleanPassDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddHddCleanPassBloc>(context).add(
            AddHddCleanPassAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddHddCleanPassBloc>(context).add(
            AddHddCleanPassAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddHddCleanPassDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddHddCleanPassBloc>(context)
              .add(AddHddCleanPassSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

