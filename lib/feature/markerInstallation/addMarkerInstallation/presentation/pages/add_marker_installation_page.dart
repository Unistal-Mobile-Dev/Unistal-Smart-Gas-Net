import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/domain/bloc/add_marker_installation_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/domain/model/marker_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
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

class AddMarkerInstallationPage extends StatefulWidget {
  const AddMarkerInstallationPage({super.key});

  @override
  State<AddMarkerInstallationPage> createState() => _AddMarkerInstallationPageState();
}

class _AddMarkerInstallationPageState extends State<AddMarkerInstallationPage> {
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
    BlocProvider.of<AddMarkerInstallationBloc>(context)
        .add(AddMarkerInstallationPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddMarkerInstallationBloc, AddMarkerInstallationState>(
        builder: (context, state) {
          if (state is FetchAddMarkerInstallationDataState) {
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

  Widget _itemBuilder({required FetchAddMarkerInstallationDataState dataState}) {
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
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _markerTypeDropDown(dataState: dataState),
            _verticalSpace(),
           if(!(_isHPCL || _isHPOIL))...[
             _chainageController(dataState: dataState),
             _verticalSpace(),
             _descriptionController(dataState: dataState),
             _verticalSpace(),
           ],
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

  Widget _dateController({required FetchAddMarkerInstallationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddMarkerInstallationBloc>(context)
            .add(AddMarkerInstallationSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddMarkerInstallationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddMarkerInstallationDataState dataState}) {
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
        BlocProvider.of<AddMarkerInstallationBloc>(context)
            .add(AddMarkerInstallationMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddMarkerInstallationDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerInstallationBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }


  Widget _jointNumberDropDown(
      {required FetchAddMarkerInstallationDataState dataState}) {
    return DropdownWidget<JointNumberModel>(
      hint: AppString.selectJointNumber,
      dropdownValue: dataState.jointValue.id != null
          ? dataState.jointValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerInstallationBloc>(context).add(
            SelectJointEvent(jointValue: value!));
      },
      items: dataState.listOfJoint
    );
  }

  Widget _markerTypeDropDown(
      {required FetchAddMarkerInstallationDataState dataState}) {
    return DropdownWidget<MarkerTypeModel>(
      hint: AppString.selectMarkerType,
      dropdownValue: dataState.markerTypeDataValue.id != null
          ? dataState.markerTypeDataValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddMarkerInstallationBloc>(context).add(
            SelectMarkerTypeEvent(markerTypeValue: value!));
      },
      items: dataState.listOfMarkerType
    );
  }



  Widget _chainageController({required FetchAddMarkerInstallationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _descriptionController({required FetchAddMarkerInstallationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.description,
      controller: dataState.descriptionController,
    );
  }



  Widget _activityRemark({required FetchAddMarkerInstallationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddMarkerInstallationDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>BlocProvider.of<AddMarkerInstallationBloc>(context).add(
            AddMarkerInstallationAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>BlocProvider.of<AddMarkerInstallationBloc>(context).add(
            AddMarkerInstallationAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddMarkerInstallationDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddMarkerInstallationBloc>(context)
              .add(AddMarkerInstallationSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}

