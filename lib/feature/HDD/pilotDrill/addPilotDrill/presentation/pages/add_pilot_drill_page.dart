import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/pilotDrill/addPilotDrill/domain/bloc/add_pilot_drill_bloc.dart';
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

class AddPilotDrillPage extends StatefulWidget {
  const AddPilotDrillPage({super.key});

  @override
  State<AddPilotDrillPage> createState() => _AddPilotDrillPageState();
}

class _AddPilotDrillPageState extends State<AddPilotDrillPage> {
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
    BlocProvider.of<AddPilotDrillBloc>(context)
        .add(AddPilotDrillPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddPilotDrillBloc, AddPilotDrillState>(
        builder: (context, state) {
          if (state is FetchAddPilotDrillDataState) {
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

  Widget _itemBuilder({required FetchAddPilotDrillDataState dataState}) {
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
            _startDateOfPilotHoleController(dataState: dataState),
            _verticalSpace(),
            _endDateOfPilotHoleController(dataState: dataState),
            _verticalSpace(),
            _machineCapacityController(dataState: dataState),
            _verticalSpace(),
            _sizeOfPilotBitSizeController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _rodNoController(dataState: dataState),
            _verticalSpace(),
            _totalLengthController(dataState: dataState),
            _verticalSpace(),
            _pitchController(dataState: dataState),
            _verticalSpace(),
            _degreeController(dataState: dataState),
            _verticalSpace(),
            _depthController(dataState: dataState),
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

  Widget _dateController({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddPilotDrillBloc>(context)
            .add(AddPilotDrillSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddPilotDrillDataState dataState}) {
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
        BlocProvider.of<AddPilotDrillBloc>(context)
            .add(AddPilotDrillMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddPilotDrillDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddPilotDrillBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddPilotDrillDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
      dataState.jointTypeDataValue.id != null ? dataState.jointTypeDataValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPilotDrillBloc>(context).add(
            SelectJointTypeDataEvent(
                jointTypeDataValue: value!, context: context));
      },
      items: dataState.listOfJointType
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddPilotDrillDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointValue.id != null
          ? dataState.fromJointValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddPilotDrillBloc>(context).add(
            SelectFromJointEvent(fromJointValue: value!));
      },
      items: dataState.listOfFromJoint
    )
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown(
      {required FetchAddPilotDrillDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      hint: AppString.selectToJointNumber,
      dropdownValue:
      dataState.toJointValue.id != null ? dataState.toJointValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPilotDrillBloc>(context).add(
            SelectToJointEvent(toJointValue: value!));
      },
      items: dataState.listOfToJoint
    )
        : const DottedLoaderWidget();
  }

  Widget _startDateOfPilotHoleController({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectStartDateOfPilotHole,
      controller: dataState.startDateOfPilotHoleController,
      onTap: () {
        BlocProvider.of<AddPilotDrillBloc>(context)
            .add(AddPilotDrillStartingDateOfPilotHoleEvent(
          context: context,
        ));
      },
    );
  }

  Widget _endDateOfPilotHoleController({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectEndDateOfPilotHole,
      controller: dataState.endDateOfPilotHoleController,
      onTap: () {
        BlocProvider.of<AddPilotDrillBloc>(context)
            .add(AddPilotDrillEndDateOfPilotHoleEvent(
          context: context,
        ));
      },
    );
  }

  Widget _machineCapacityController(
      {required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectHDDMachineCapacity,
      controller: dataState.machineCapacityController,
    );
  }

  Widget _sizeOfPilotBitSizeController({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectSizePilotBitSize,
      controller: dataState.sizeOfPilotBitSizeController,
    );
  }

  Widget _lengthController(
      {required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectLength,
      textInputType: TextInputType.number,
      controller: dataState.lengthController,
    );
  }

  Widget _rodNoController({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectRodNo,
      controller: dataState.rodNoController,
    );
  }

  Widget _totalLengthController({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectTotalLength,
      textInputType: TextInputType.number,
      controller: dataState.totalLengthController,
    );
  }

  Widget _pitchController({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectPitch,
      controller: dataState.pitchController,
    );
  }

  Widget _degreeController(
      {required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDegree,
      controller: dataState.degreeController,
    );
  }

  Widget _depthController(
      {required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDepth,
      controller: dataState.depthController,
    );
  }

  Widget _activityRemark({required FetchAddPilotDrillDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddPilotDrillDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddPilotDrillBloc>(context).add(
            AddPilotDrillAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddPilotDrillBloc>(context).add(
            AddPilotDrillAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddPilotDrillDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddPilotDrillBloc>(context)
              .add(AddPilotDrillSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

