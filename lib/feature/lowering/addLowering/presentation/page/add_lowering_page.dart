import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/bloc/add_lowering_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddLoweringPage extends StatefulWidget {
  const AddLoweringPage({super.key});

  @override
  State<AddLoweringPage> createState() => _AddLoweringPageState();
}

class _AddLoweringPageState extends State<AddLoweringPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;

  bool get _isVRPL => _client == Client.vrpl;

  bool get _isBJPL => _client == Client.bjpl;

  bool get _isHPCL => _client == Client.hpcl;

  bool get _isHPOIL => _client == Client.hpoil;

  bool get _isGJPL => _client == Client.gjpl;

  bool get _isURJAGATI => _client == Client.urjagati;

  bool get _isMGL => _client == Client.mgl;

  // bool get _isAllClient => _isVppl || _isURJAGATI || _isGJPL;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddLoweringBloc>(context)
        .add(AddLoweringPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddLoweringBloc, AddLoweringState>(
        builder: (context, state) {
          if (state is FetchAddLoweringDataState) {
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

  Widget _itemBuilder({required FetchAddLoweringDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if (_isVPPL || _isVRPL || _isBJPL) ...[
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
            if (_isVPPL) ...[
              _dewateringDropDown(dataState: dataState),
              _verticalSpace(),
              _paddingDropDown(dataState: dataState),
              _verticalSpace(),
              _paddingMaterialDropDown(dataState: dataState),
              _verticalSpace(),
              _loweringClearanceDropDown(dataState: dataState),
              _verticalSpace(),
              _approvedPipeDropDown(dataState: dataState),
              _verticalSpace(),
            ],
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            if(!_isVPPL)...[
              _holidayDetectorDetailsController(dataState: dataState),
              _verticalSpace(),
              _modelController(dataState: dataState),
              _verticalSpace(),
              _testVoltageController(dataState: dataState),
              _verticalSpace(),
              if (_isMGL || _isVPPL || _isVRPL) ...[
                _calibarationDateController(dataState: dataState),
                _verticalSpace(),
              ],
              _repairCoatingController(dataState: dataState),
              _verticalSpace(),
              _locatinController(dataState: dataState),
              _verticalSpace(),

            ],
            _postPaddingController(dataState: dataState),
            _verticalSpace(),
            if (_isMGL || _isVPPL || _isVRPL) ...[
              _holidayChecksDropDown(dataState: dataState),
              _verticalSpace(),
            ],
            _nightCapDropDown(dataState: dataState),
            _verticalSpace(),
            _postPaddingCtrl(dataState: dataState),
            _verticalSpace(),
            _postPaddingController(dataState: dataState),
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
      initialValue:
          AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }

  Widget _dateController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddLoweringDataState dataState}) {
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
        BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
        hint: AppString.selectWeather,
        dropdownValue:
            dataState.weatherData.id != null ? dataState.weatherData : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context)
              .add(SelectWeatherEvent(weatherData: value!));
        },
        items: dataState.weatherList);
  }

  Widget _pipeDiaDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<PipeDiaModel>(
        hint: AppString.selectPipeDia,
        dropdownValue:
            dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context)
              .add(AddLoweringSelectPipeDiaDataEvent(pipeDiaData: value!));
        },
        items: dataState.pipeDialList);
  }

  Widget _thicknessDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<ThicknessModel>(
        hint: AppString.selectPipeThickness,
        dropdownValue:
            dataState.thicknessData.id != null ? dataState.thicknessData : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context)
              .add(AddLoweringSelectThicknessDataEvent(thicknessData: value!));
        },
        items: dataState.thicknessList);
  }

  Widget _locatinController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.location,
      controller: dataState.locationController,
    );
  }


  Widget _postPaddingCtrl({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      labelText:  "Post Padding",
      controller: dataState.postPaddingCtrl,
    );
  }


  Widget _holidayDetectorDetailsController(
      {required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.holidayDetectorDetails,
      controller: dataState.holidayDetectorDetailsController,
    );
  }

  Widget _modelController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI || _isGJPL
          ? "Repair Of Coating Damage"
          : AppString.makeModel,
      controller: dataState.modelController,
    );
  }

  Widget _testVoltageController(
      {required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.testVoltage,
      controller: dataState.testVoltageController,
    );
  }

  Widget _lengthController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _calibarationDateController(
      {required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      enabled: true,
      readOnly: true,
      labelText: AppString.calibarationDate,
      controller: dataState.calibarationDateController,
      onTap: () {
        BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringCalibarationDataEvent(
          context: context,
        ));
      },
    );
  }

  Widget _repairCoatingController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI || _isGJPL
          ? "Calibaration Done On"
          : AppString.repairCoatingDamage,
      controller: dataState.repairCoatingController,
    );
  }

  Widget _jointTypeDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
        hint: AppString.selectJointType,
        dropdownValue:
            dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context).add(
              AddLoweringSelectJointTypeDataEvent(
                  jointTypeData: value!, context: context));
        },
        items: dataState.jointTypeList);
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddLoweringDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.fromJointData.id != null ? dataState.fromJointData : null,
      hint: AppString.selectFromJointNumber,
      items: dataState.jointFromList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringSelectFromJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _toJointNumberDropDown(
      {required FetchAddLoweringDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.toJointData.id != null ? dataState.toJointData : null,
      hint: AppString.selectToJointNumber,
      items: dataState.jointToList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringSelectToJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _chainageFromController(
      {required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: false, value: value));
      },
    );
  }

  Widget _chainageToController({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: true, value: value));
      },
    );
  }

  Widget _postPaddingController(
      {required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI || _isGJPL
          ? "Padding"
          : _isVPPL || _isVRPL
              ? "Padding Over OFC / Trench Cleaning"
              : AppString.postPadding,
      controller: dataState.postPaddingController,
    );
  }

  Widget _dewateringDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Dewatering",
        dropdownValue: dataState.dewateringValue.id != null
            ? dataState.dewateringValue
            : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context)
              .add(AddLoweringSelectDewateringEvent(dewateringValue: value!));
        },
        items: dataState.listOfDewatering);
  }

  Widget _paddingDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Padding",
        dropdownValue:
            dataState.paddingValue.id != null ? dataState.paddingValue : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context)
              .add(AddLoweringSelectPaddingEvent(paddingValue: value!));
        },
        items: dataState.listOfPadding);
  }

  Widget _paddingMaterialDropDown(
      {required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Padding Material for Seismic Zone",
        dropdownValue: dataState.paddingMaterialValue.id != null
            ? dataState.paddingMaterialValue
            : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context).add(
              AddLoweringSelectPaddingMaterialEvent(
                  paddingMaterialValue: value!));
        },
        items: dataState.listOfPaddingMaterial);
  }

  Widget _loweringClearanceDropDown(
      {required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Lowering Clearance",
        dropdownValue: dataState.loweringClearanceValue.id != null
            ? dataState.loweringClearanceValue
            : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context).add(
              AddLoweringSelectLoweringClearanceEvent(
                  loweringClearanceValue: value!));
        },
        items: dataState.listOfLoweringClearance);
  }

  Widget _approvedPipeDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint:
            "Approved pipe book part A for pipeline lowering section is available",
        dropdownValue: dataState.approvedPipeValue.id != null
            ? dataState.approvedPipeValue
            : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context).add(
              AddLoweringSelectApprovedPipeEvent(approvedPipeValue: value!));
        },
        items: dataState.listOfApprovedPipe);
  }

  Widget _nightCapDropDown({required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Night Cap Providing",
        dropdownValue: dataState.nightCapValue.id != null
            ? dataState.nightCapValue
            : null,
        onChanged: (value) {
          BlocProvider.of<AddLoweringBloc>(context).add(
              AddLoweringSelectNightCapEvent(nightCapValue: value!));
        },
        items: dataState.listOfNightCap);
  }

  Widget _holidayChecksDropDown(
      {required FetchAddLoweringDataState dataState}) {
    return DropdownWidget<HolidayChecksModel>(
      isRequired: true,
      hint: _isURJAGATI || _isGJPL
          ? "Holiday Test"
          : AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null
          ? dataState.holidayChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringSelectHolidayDataEvent(holidayChecksData: value!));
      },
      items: dataState.holidayCheckList,
    );
  }

  Widget _activityRemark({required FetchAddLoweringDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddLoweringDataState dataState}) {
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringAddImageEvent(context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddLoweringBloc>(context)
            .add(AddLoweringAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddLoweringDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddLoweringBloc>(context)
                  .add(AddLoweringSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
