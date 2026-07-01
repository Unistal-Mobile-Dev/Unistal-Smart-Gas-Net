import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/levelling/addLevelling/domain/bloc/add_levelling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddLevellingPage extends StatefulWidget {
  const AddLevellingPage({super.key});

  @override
  State<AddLevellingPage> createState() => _AddLevellingPageState();
}

class _AddLevellingPageState extends State<AddLevellingPage> {
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
    BlocProvider.of<AddLevellingBloc>(context)
        .add(AddLevellingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddLevellingBloc, AddLevellingState>(
        builder: (context, state) {
          if (state is FetchAddLevellingDataState) {
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

  Widget _itemBuilder({required FetchAddLevellingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    TextWidget(
                      "Accuracy :  ",
                      color: EnvironmentConfig.of(context)!.primaryTheme,
                    ),
                    TextWidget(
                      dataState.accuracy.isNotEmpty
                          ? double.parse(dataState.accuracy.toString())
                              .toStringAsFixed(2)
                          : "0.0",
                      color: AppColor.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                )),
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
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            northCoordinateWidget(dataState: dataState),
            _verticalSpace(),
            _elevationPipetopController(dataState: dataState),
            _verticalSpace(),
            _pipeCoverController(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
            _verticalSpace(),
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


  Widget _dateController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddLevellingBloc>(context)
            .add(AddLevellingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddLevellingDataState dataState}) {
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
        BlocProvider.of<AddLevellingBloc>(context)
            .add(AddLevellingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddLevellingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddLevellingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddLevellingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddLevellingBloc>(context).add(
            AddLevellingSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _jointNumberDropDown({required FetchAddLevellingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.jointData.id != null ? dataState.jointData : null,
      hint: AppString.selectJointNumber,
      items: dataState.jointList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddLevellingBloc>(context)
            .add(AddLevellingSelectJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _northCoordinateButton({required FetchAddLevellingDataState dataState}) {
    return dataState.isLoader == false
        ? IconButton(
         icon: Icon(Icons.location_on_outlined),
            onPressed: () {
              BlocProvider.of<AddLevellingBloc>(context).add(
                  AddLevellingCaptureNorthingLocationEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget northCoordinateWidget({required FetchAddLevellingDataState dataState}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: _northingLatController(dataState: dataState)),
        Flexible(child: _northingLongController(dataState: dataState)),
        Flexible(child: _northCoordinateButton(dataState: dataState)),
      ],
    );
  }

  Widget _northingLatController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.northing,
      controller: dataState.northingLatController,
    );
  }

  Widget _northingLongController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.easting,
      controller: dataState.northingLongController,
    );
  }

  Widget _elevationPipetopController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.elevationPipeTop,
      controller: dataState.elevationPipetopController,
    );
  }

  Widget _natureGroundLeveController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.naturalGroundLeve,
      controller: dataState.natureGroundLeveController,
    );
  }

  Widget _pipeCoverController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: _isVRPL || _isVPPL || _isGJPL ?"Top Cover":AppString.pipeCover,
      controller: dataState.coverController,
    );
  }

  Widget _chainageFromController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _activityRemark({required FetchAddLevellingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddLevellingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddLevellingBloc>(context).add(
            AddLevellingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddLevellingBloc>(context).add(
            AddLevellingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddLevellingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddLevellingBloc>(context)
                  .add(AddLevellingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
