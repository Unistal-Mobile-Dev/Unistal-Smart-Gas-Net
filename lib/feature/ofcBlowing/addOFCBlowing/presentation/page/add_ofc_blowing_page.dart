import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcBlowing/addOFCBlowing/domain/add_ofc_blowing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddOFCBlowingPage extends StatefulWidget {
  const AddOFCBlowingPage({super.key});

  @override
  State<AddOFCBlowingPage> createState() => _AddOFCBlowingPageState();
}

class _AddOFCBlowingPageState extends State<AddOFCBlowingPage> {
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
    BlocProvider.of<AddOFCBlowingBloc>(context)
        .add(AddOFCBlowingPageLoadEvent(context: context));

  }

  final client = AppConfig.instanceInit()!.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddOFCBlowingBloc, AddOFCBlowingState>(
        builder: (context, state) {
          if (state is FetchAddOFCBlowingDataState) {
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

  Widget _itemBuilder({required FetchAddOFCBlowingDataState dataState}) {
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
            if(!(_isVPPL || _isBJPL))...[
              _chainageFromController(dataState: dataState),
              _verticalSpace(),
              _chainageToController(dataState: dataState),
              _verticalSpace(),
            ],
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _ofcDrumNoController(dataState: dataState),
            _verticalSpace(),
            _ofcDrumLengthController(dataState: dataState),
            _verticalSpace(),
            _smmController(dataState: dataState),
            _verticalSpace(),
            _pitCableLengthController(dataState: dataState),
            _verticalSpace(),
            _loopPitController(dataState: dataState),
            _verticalSpace(),
            _locationBPController(dataState: dataState),
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

  Widget _dateController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddOFCBlowingBloc>(context)
            .add(AddOFCBlowingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddOFCBlowingBloc>(context).add(CalculateLengthEvent(
            isChainageTo: false, value: value, context: context));
      },
    );
  }

  Widget _chainageToController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddOFCBlowingBloc>(context).add(CalculateLengthEvent(
            isChainageTo: true, value: value, context: context));
      },
    );
  }

  Widget _lengthController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      enabled: true,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddOFCBlowingDataState dataState}) {
    return DropdownWidget<JointNumberModel>(
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointValue.id != null
                ? dataState.fromJointValue
                : null,
            onChanged: (value) {
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(SelectFromJointEvent(fromJointValue: value!));
            },
            items: dataState.listOfFromJoint
          );
  }

  Widget _toJointNumberDropDown({required FetchAddOFCBlowingDataState dataState}) {
    return  DropdownWidget<JointNumberModel>(
            hint: AppString.selectToJointNumber,
            dropdownValue: dataState.toJointValue.id != null
                ? dataState.toJointValue
                : null,
            onChanged: (value) {
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(SelectToJointEvent(toJointValue: value!));
            },
            items: dataState.listOfToJoint
          );
  }

  Widget _ofcDrumNoController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "OFC Drum No.",
      controller: dataState.ofcDrumNoController,
    );
  }

  Widget _ofcDrumLengthController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "OFC Drum Length(Meter)",
      controller: dataState.ofcDrumLengthController,
    );
  }

  Widget _smmController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "Sequential Meter Marker on OFC(meter)",
      controller: dataState.smmController,
    );
  }

  Widget _pitCableLengthController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "Pit Cable Length(Meter)",
      controller: dataState.pitCableLengthController,
    );
  }

  Widget _loopPitController({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "Loop At Pit",
      controller: dataState.loopPitController,
    );
  }

  Widget _locationBPController(
      {required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "No. & Location of Blowing Pit",
      controller: dataState.locationBPController,
    );
  }

  Widget _activityRemark({required FetchAddOFCBlowingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddOFCBlowingDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
            selectedItem: dataState.multipleAlignmentData,
            hint: AppString.selectAlignment,
            items: dataState.alignmentList,
            itemAsString: (alignmentData) =>
                alignmentData.alignmentName.toString(),
            onChanged: (value) {
              List<AlignmentModel> selectedAlignmentDataList = [];
              for (var data in value) {
                selectedAlignmentDataList.add(data);
              }
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(AddOFCBlowingMultipleSelectAlignmentEvent(
                alignmentData: selectedAlignmentDataList,
              ));
            },
          );
  }

  Widget _weatherDropDown({required FetchAddOFCBlowingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddOFCBlowingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }
  Widget _photo({required FetchAddOFCBlowingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddOFCBlowingBloc>(context).add(
            AddOFCBlowingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>BlocProvider.of<AddOFCBlowingBloc>(context).add(
            AddOFCBlowingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddOFCBlowingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddOFCBlowingBloc>(context)
                  .add(AddOFCBlowingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
