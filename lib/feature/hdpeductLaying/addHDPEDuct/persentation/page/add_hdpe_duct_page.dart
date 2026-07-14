import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/domain/bloc/add_hdpe_duct_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddHdpeDuctPage extends StatefulWidget {
  const AddHdpeDuctPage({super.key});

  @override
  State<AddHdpeDuctPage> createState() => _AddHdpeDuctPageState();
}

class _AddHdpeDuctPageState extends State<AddHdpeDuctPage> {
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
    BlocProvider.of<AddHdpeDuctBloc>(context)
        .add(AddHdpeDuctPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddHdpeDuctBloc, AddHdpeDuctState>(
        builder: (context, state) {
          if (state is FetchAddHdpeDuctDataState) {
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

  Widget _itemBuilder({required FetchAddHdpeDuctDataState dataState}) {
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
            if (!_isVPPL) ...[
              _coilNumberController(dataState: dataState),
              _verticalSpace(),
              _chainageFromController(dataState: dataState),
              _verticalSpace(),
              _chainageToController(dataState: dataState),
              _verticalSpace(),
            ],
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _paddingDropDown(dataState: dataState),
            _verticalSpace(),
            _warningDropDown(dataState: dataState),
            _verticalSpace(),

            _ductReadingFromController(dataState: dataState),
            _verticalSpace(),
            if (!_isVPPL) ...[
              _ductReadingToController(dataState: dataState),
              _verticalSpace(),
            ],
            // _jointPitController(dataState: dataState),
            // _verticalSpace(),

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

  Widget _dateController({required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHdpeDuctBloc>(context)
            .add(AddHdpeDuctSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddHdpeDuctDataState dataState}) {
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
        BlocProvider.of<AddHdpeDuctBloc>(context)
            .add(AddHdpeDuctMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddHdpeDuctDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
        hint: AppString.selectWeather,
        dropdownValue:
            dataState.weatherData.id != null ? dataState.weatherData : null,
        onChanged: (value) {
          BlocProvider.of<AddHdpeDuctBloc>(context)
              .add(SelectWeatherEvent(weatherData: value!));
        },
        items: dataState.weatherList);
  }

  Widget _jointTypeDropDown({required FetchAddHdpeDuctDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
        hint: AppString.selectJointType,
        dropdownValue:
            dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
        onChanged: (value) {
          BlocProvider.of<AddHdpeDuctBloc>(context).add(
              AddHdpeDuctSelectJointTypeDataEvent(
                  jointTypeData: value!, context: context));
        },
        items: dataState.jointTypeList);
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddHdpeDuctDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            isRequired: true,
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointData.id != null
                ? dataState.fromJointData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddHdpeDuctBloc>(context).add(
                  AddHdpeDuctSelectFromJointDataEvent(jointNumberData: value!));
            },
            items: dataState.jointFromList)
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown(
      {required FetchAddHdpeDuctDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            isRequired: true,
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddHdpeDuctBloc>(context).add(
                  AddHdpeDuctSelectToJointDataEvent(jointNumberData: value!));
            },
            items: dataState.jointToList)
        : const DottedLoaderWidget();
  }

  Widget _lengthController({required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.hdpeLayingLength,
      controller: dataState.lengthController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _coilNumberController({required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      labelText: "Coil No.",
      controller: dataState.coilNumberController,
    );
  }

  Widget _ductReadingFromController(
      {required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: _isVPPL || _isVRPL || _isBJPL ? false : true,
      textInputType: _isVPPL || _isVRPL  || _isBJPL ? TextInputType.text : TextInputType.number,
      labelText: _isVPPL || _isVRPL  || _isBJPL ? "Coupler/End Cap/Joint Pit" : AppString.ductReadingFrom,
      controller: dataState.ductLengthFromController,
    );
  }

  Widget _ductReadingToController({required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: _isVPPL || _isVRPL || _isBJPL ? false : true,
      textInputType: _isVPPL || _isVRPL || _isBJPL ? TextInputType.text : TextInputType.number,
      labelText: _isVPPL || _isVRPL || _isBJPL
            ? "Coupler/Joint Pit GPS Location"
          : AppString.ductReadingTo,
      controller: dataState.ductLengthToController,
    );
  }

  Widget _jointPitController({required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.couplerEndCapJointPit,
      controller: dataState.jointPitController,
    );
  }

  Widget _warningDropDown({required FetchAddHdpeDuctDataState dataState}) {
    return DropdownWidget<PaddingModel>(
        hint: AppString.selectWarningMatMeter,
        dropdownValue: dataState.warningMeterData.id != null
            ? dataState.warningMeterData
            : null,
        onChanged: (value) {
          BlocProvider.of<AddHdpeDuctBloc>(context).add(
              AddHdpeDuctSelectWarningMeterDataEvent(warningMeterData: value!));
        },
        items: dataState.warningMeterList);
  }

  Widget _paddingDropDown({required FetchAddHdpeDuctDataState dataState}) {
    return DropdownWidget<PaddingModel>(
        hint: AppString.selectPaddingMeter,
        dropdownValue:
            dataState.paddingData.id != null ? dataState.paddingData : null,
        onChanged: (value) {
          BlocProvider.of<AddHdpeDuctBloc>(context)
              .add(AddHdpeDuctSelectPaddingDataEvent(paddingData: value!));
        },
        items: dataState.paddingList);
  }

  Widget _activityRemark({required FetchAddHdpeDuctDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddHdpeDuctDataState dataState}) {
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddHdpeDuctBloc>(context)
            .add(AddHdpeDuctAddImageEvent(context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddHdpeDuctBloc>(context)
            .add(AddHdpeDuctAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddHdpeDuctDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddHdpeDuctBloc>(context)
                  .add(AddHdpeDuctSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
