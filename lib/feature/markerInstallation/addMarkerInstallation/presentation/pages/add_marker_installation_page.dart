import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/domain/bloc/add_marker_installation_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/domain/model/marker_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/button_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/center_loader_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dotted_loader_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_search_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/text_field_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/text_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_font.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_string.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/enums.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddMarkerInstallationPage extends StatefulWidget {
  const AddMarkerInstallationPage({super.key});

  @override
  State<AddMarkerInstallationPage> createState() => _AddMarkerInstallationPageState();
}

class _AddMarkerInstallationPageState extends State<AddMarkerInstallationPage> {
  @override
  void initState() {
    BlocProvider.of<AddMarkerInstallationBloc>(context)
        .add(AddMarkerInstallationPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _descriptionController(dataState: dataState),
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

  Widget _dateController({required FetchAddMarkerInstallationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
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
    return  AppConfig.instanceInit()!.client == Client.vppl || AppConfig.instanceInit()!.client == Client.vrpl
        ?  DropDownSearchMultiSelectWidget(
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
    ) : DropDownSearchWidget(
      selectedItem:
      dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddMarkerInstallationBloc>(context)
            .add(AddMarkerInstallationSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddMarkerInstallationDataState dataState}) {
    return DropdownWidget<WeatherModel>(
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


  Widget _photo({required FetchAddMarkerInstallationDataState dataState}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      child: InkWell(
        onTap: () {
          mediaType(context: context);
        },
        child: DottedBorder(
          color: AppColor.grey,
          strokeWidth: 1,
          child: dataState.file.path.isEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(Icons.photo_camera_back_outlined),
              ),
              Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.02),
                child: TextWidget(
                  "Photo",
                  fontSize: AppFont.font_12,
                  color: AppColor.grey,
                ),
              ),
            ],
          )
              : Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dataState.file.path
                      .toString()
                      .toLowerCase()
                      .contains(".jpg") ||
                      dataState.file.path
                          .toString()
                          .toLowerCase()
                          .contains(".png") ||
                      dataState.file.path
                          .toString()
                          .toLowerCase()
                          .contains(".jpeg")
                      ? Image.file(
                    dataState.file,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 4.5,
                  )
                      : dataState.file.path
                      .toString()
                      .toLowerCase()
                      .contains(".pdf")
                      ? const Icon(Icons.picture_as_pdf_outlined)
                      : const Icon(Icons.document_scanner_outlined),
                  dataState.file.path
                      .toString()
                      .toLowerCase()
                      .contains(".pdf")
                      ? TextWidget(
                    dataState.file.path.split('/').last.toString(),
                    color:  EnvironmentConfig.of(context)!.primaryTheme,
                    fontSize: AppFont.font_12,
                  )
                      : const SizedBox.shrink(),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  color: Colors.white.withOpacity(0.6),
                  child: Center(
                      child: Icon(
                        Icons.refresh,
                        color:  EnvironmentConfig.of(context)!.primaryTheme,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void mediaType({required BuildContext context}) {
    showModalBottomSheet(
      context: context, // Also default
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddMarkerInstallationBloc>(context).add(
                        AddMarkerInstallationAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddMarkerInstallationBloc>(context).add(
                        AddMarkerInstallationAddImageEvent(
                            context: context, mediaType: 2));
                  },
                  child: TextWidget(
                    "Gallery",
                    fontSize: AppFont.font_16,
                  )),
            ],
          ),
        );
      },
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
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

