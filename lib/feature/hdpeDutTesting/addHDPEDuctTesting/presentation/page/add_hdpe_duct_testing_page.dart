import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeDutTesting/addHDPEDuctTesting/domain/bloc/add_hdpe_duct_testing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddHDPEDuctTestingPage extends StatefulWidget {
  const AddHDPEDuctTestingPage({super.key});

  @override
  State<AddHDPEDuctTestingPage> createState() => _AddHDPEDuctTestingPageState();
}

class _AddHDPEDuctTestingPageState extends State<AddHDPEDuctTestingPage> {
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
    BlocProvider.of<AddHdpeDuctTestingBloc>(context)
        .add(AddHdpeDuctTestingPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddHdpeDuctTestingBloc, AddHdpeDuctTestingState>(
        builder: (context, state) {
          if (state is FetchAddHdpeDuctTestingDataState) {
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

  Widget _itemBuilder({required FetchAddHdpeDuctTestingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL || _isVRPL)...[
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
          /*  _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _ductCleaningController(dataState: dataState),
            _verticalSpace(),
            _ductIntegrityTestController(dataState: dataState),
            _verticalSpace(),
            _airPressureTestController(dataState: dataState),
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

  Widget _dateController({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context)
            .add(AddHdpeDuctTestingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddHdpeDuctTestingDataState dataState}) {
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
        BlocProvider.of<AddHdpeDuctTestingBloc>(context)
            .add(AddHdpeDuctTestingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddHdpeDuctTestingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointData.id != null
                ? dataState.fromJointData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
                  AddHdpeDuctTestingSelectFromJointDataEvent(
                      jointNumberData: value!));
            },
            items: dataState.jointFromList
          )
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
                  AddHdpeDuctTestingSelectToJointDataEvent(
                      jointNumberData: value!));
            },
            items: dataState.jointToList
          )
        : const DottedLoaderWidget();
  }

  Widget _lengthController(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.hdpeLayinglength,
      controller: dataState.lengthController,
    );
  }

  Widget _ductCleaningController(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ductCleaning,
      controller: dataState.ductCleaningController,
    );
  }

  Widget _ductIntegrityTestController(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.ductIntegrityTest,
      controller: dataState.ductIntegrityTestController,
    );
  }

  Widget _airPressureTestController(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.airPressureTest,
      controller: dataState.airPressureTestController,
    );
  }

  Widget _activityRemark(
      {required FetchAddHdpeDuctTestingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddHdpeDuctTestingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddHdpeDuctTestingBloc>(context).add(
            AddHdpeDuctTestingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddHdpeDuctTestingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddHdpeDuctTestingBloc>(context)
                  .add(AddHdpeDuctTestingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
