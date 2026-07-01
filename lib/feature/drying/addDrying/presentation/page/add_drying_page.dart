import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/drying/addDrying/domain/bloc/add_drying_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddDryingPage extends StatefulWidget {
  const AddDryingPage({super.key});

  @override
  State<AddDryingPage> createState() => _AddDryingPageState();
}

class _AddDryingPageState extends State<AddDryingPage> {
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
    BlocProvider.of<AddDryingBloc>(context)
        .add(AddDryingPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddDryingBloc, AddDryingState>(
        builder: (context, state) {
          if (state is FetchAddDryingDataState) {
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

  Widget _itemBuilder({required FetchAddDryingDataState dataState}) {
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
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
           /* _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
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

  Widget _dateController({required FetchAddDryingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddDryingBloc>(context).add(AddDryingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddDryingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddDryingDataState dataState}) {
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
        BlocProvider.of<AddDryingBloc>(context)
            .add(AddDryingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddDryingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddDryingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddDryingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddDryingBloc>(context).add(
            AddDryingSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddDryingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointData.id != null
                ? dataState.fromJointData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddDryingBloc>(context).add(
                  AddDryingSelectFromJointDataEvent(jointNumberData: value!));
            },
            items: dataState.jointFromList
          )
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown({required FetchAddDryingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddDryingBloc>(context)
                  .add(AddDryingSelectToJointDataEvent(jointNumberData: value!));
            },
            items: dataState.jointToList
          )
        : const DottedLoaderWidget();
  }

  Widget _chainageFromController({required FetchAddDryingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddDryingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _lengthController({required FetchAddDryingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _activityRemark({required FetchAddDryingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddDryingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>   BlocProvider.of<AddDryingBloc>(context).add(
            AddDryingAddImageEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddDryingBloc>(context).add(
            AddDryingAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddDryingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddDryingBloc>(context)
                  .add(AddDryingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
