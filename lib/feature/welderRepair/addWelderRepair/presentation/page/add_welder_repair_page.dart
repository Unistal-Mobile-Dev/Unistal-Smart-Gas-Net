import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/domain/bloc/add_welder_repair_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddWelderRepairPage extends StatefulWidget {
  const AddWelderRepairPage({super.key});

  @override
  State<AddWelderRepairPage> createState() => _AddWelderRepairPageState();
}

class _AddWelderRepairPageState extends State<AddWelderRepairPage> {
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
    BlocProvider.of<AddWelderRepairBloc>(context)
        .add(AddWelderRepairLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddWelderRepairBloc, AddWelderRepairState>(
        builder: (context, state) {
          if (state is FetchAddWelderRepairDataState) {
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

  Widget _itemBuilder({required FetchAddWelderRepairDataState dataState}) {
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
          /*  _verticalSpace(),
            TextWidget(
              "Electrode/Filler Wire No.",
              color: EnvironmentConfig.of(context)!.primaryTheme,
              fontWeight: FontWeight.w600,
            ),
            const Divider(),
            _e6010Controller(dataState: dataState),
            _verticalSpace(),
            _e8010P1Controller(dataState: dataState),
            _verticalSpace(),
            _e9045P2Controller(dataState: dataState),
            _verticalSpace(),
            _er70s6Controller(dataState: dataState),
            _verticalSpace(),
            _e81TM21ABController(dataState: dataState),
            _verticalSpace(),
            const Divider(),*/
            _verticalSpace(),
          /*  _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _segmentDropdown(dataState: dataState),
            _verticalSpace(),
            _wpdTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _welderDropDown(dataState: dataState),
            _verticalSpace(),
            _preHeatingTemperatureController(dataState: dataState),
            _verticalSpace(),
            _weldVisualDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(AddWelderRepairSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }


  Widget _alignmentDropdown({required FetchAddWelderRepairDataState dataState}) {
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
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(AddWelderRepairMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _e6010Controller({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E6010",
      controller: dataState.e6010Controller,
    );
  }

  Widget _e8010P1Controller(
      {required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E8010P1",
      controller: dataState.e8010P1Controller,
    );
  }

  Widget _e9045P2Controller(
      {required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E9045P2",
      controller: dataState.e9045P2Controller,
    );
  }

  Widget _er70s6Controller({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "Er70s6",
      controller: dataState.er70s6Controller,
    );
  }

  Widget _e81TM21ABController(
      {required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "E81TM21AB",
      controller: dataState.e81TM21ABController,
    );
  }

  Widget _jointTypeDropDown(
      {required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      isRequired: true,
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairSelectJointTypeEvent(
                jointTypeModel: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _jointNumberDropDown(
      {required FetchAddWelderRepairDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      isRequired: true,
            hint: AppString.selectJointNumber,
            dropdownValue: dataState.jointNumberData.id != null
                ? dataState.jointNumberData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddWelderRepairBloc>(context).add(
                  AddWelderRepairSelectJointNumberEvent(
                      jointNumberData: value!));
            },
            items: dataState.jointNumberList
          )
        : const DottedLoaderWidget();
  }

  Widget _weldVisualDropDown({required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectWeldVisual,
      dropdownValue:
      dataState.weldVisualData.id != null ? dataState.weldVisualData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context)
            .add(AddWelderRepairSelectWeldVisualEvent(weldVisualData: value!));
      },
      items: dataState.weldVisualList
    );
  }

  Widget _segmentDropdown({required FetchAddWelderRepairDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      isRequired: true,
      selectedItem: dataState.selectedSegmentStatusList,
      hint: AppString.selectSegment,
      items: dataState.segmentStatusList,
      itemAsString: (segmentData) => segmentData.name.toString(),
      onChanged: (selectedItems) {
        List<SegmentModel> segmentStatusList = [];
        for (var data in selectedItems) {
          segmentStatusList.add(data);
        }
        BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairSelectSegmentEvent(
                selectedSegmentList: segmentStatusList));
      },
    );
  }

  Widget _wpdTypeDropDown({required FetchAddWelderRepairDataState dataState}) {
    return DropdownWidget<WPSModel>(
      hint: AppString.selectWPS,
      dropdownValue:
          dataState.wpsTypeData.id != null ? dataState.wpsTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairSelectWPSTypeEvent(
                wpsTypeData: value!, context: context));
      },
      items: dataState.wpsTypeList
    );
  }

  Widget _preHeatingTemperatureController({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.preHeatingTemperature,
      controller: dataState.preHeatingTemperatureController,
    );
  }

  Widget _welderDropDown({required FetchAddWelderRepairDataState dataState}) {
    return dataState.isWelderLoader == false
        ? DropdownWidget<WelderModel>(
            hint: AppString.selectWelder,
            dropdownValue:
                dataState.welderData.id != null ? dataState.welderData : null,
            onChanged: (value) {
              BlocProvider.of<AddWelderRepairBloc>(context)
                  .add(AddWelderRepairSelectWelderEvent(welderData: value!));
            },
            items: dataState.welderList
          )
        : const DottedLoaderWidget();
  }

  Widget _activityRemark({required FetchAddWelderRepairDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddWelderRepairDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddWelderRepairBloc>(context).add(
            AddWelderRepairAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddWelderRepairDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddWelderRepairBloc>(context)
                  .add(AddWelderRepairSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
