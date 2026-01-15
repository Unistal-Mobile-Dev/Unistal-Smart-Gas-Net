import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/cableInstallation/addCableInstallation/domain/bloc/add_cable_installation_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddCableInstallationPage extends StatefulWidget {
  const AddCableInstallationPage({super.key});

  @override
  State<AddCableInstallationPage> createState() => _AddCableInstallationPageState();
}

class _AddCableInstallationPageState extends State<AddCableInstallationPage> {
  @override
  void initState() {
    BlocProvider.of<AddCableInstallationBloc>(context)
        .add(AddCableInstallationPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddCableInstallationBloc, AddCableInstallationState>(
        builder: (context, state) {
          if (state is FetchAddCableInstallationState) {
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

  Widget _itemBuilder({required FetchAddCableInstallationState dataState}) {
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
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _tlpTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _areaController(dataState: dataState),
            _verticalSpace(),
            _cableSizeController(dataState: dataState),
            _verticalSpace(),
            _cableTrenchDropDown(dataState: dataState),
            _verticalSpace(),
            _depthController(dataState: dataState),
            _verticalSpace(),
            _sandDropDown(dataState: dataState),
            _verticalSpace(),
            _warningDropDown(dataState: dataState),
            _verticalSpace(),
            _backfillingDown(dataState: dataState),
            _verticalSpace(),
            _taggingDown(dataState: dataState),
            _verticalSpace(),
            _routeMarkingDown(dataState: dataState),
            _verticalSpace(),
            _irDown(dataState: dataState),
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

  Widget _dateController({required FetchAddCableInstallationState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddCableInstallationSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddCableInstallationState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddCableInstallationState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
      dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddCableInstallationSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(SelectWeatherEvent(weatherData: value));
      },
      items: dataState.weatherList
          .map<DropdownMenuItem<WeatherModel>>((WeatherModel weatherData) {
        return DropdownMenuItem<WeatherModel>(
          value: weatherData,
          child: Text(weatherData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _chainageController(
      {required FetchAddCableInstallationState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxTLPTypeEvent(tlpTypeValue: value));
      },
      items: dataState.listOfTLPType
          .map<DropdownMenuItem<TlpTypeModel>>((TlpTypeModel tlpTypeData) {
        return DropdownMenuItem<TlpTypeModel>(
          value: tlpTypeData,
          child: Text(tlpTypeData.name.toString()),
        );
      }).toList(),
    );
  }


  Widget _areaController({required FetchAddCableInstallationState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }

  Widget _cableSizeController({required FetchAddCableInstallationState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCableSize,
      controller: dataState.cableSizeController,
    );
  }

  Widget _cableTrenchDropDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCableTrench,
      dropdownValue:
      dataState.cableTrenchValue.id != null ? dataState.cableTrenchValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxCableTrenchEvent(cableTrenchValue: value));
      },
      items: dataState.listOfCableTrench
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _depthController({required FetchAddCableInstallationState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDepth,
      controller: dataState.depthController,
    );
  }

  Widget _sandDropDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectSand,
      dropdownValue:
      dataState.sandValue.id != null ? dataState.sandValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxSandEvent(sandValue: value));
      },
      items: dataState.listOfSand
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _warningDropDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWarning,
      dropdownValue:
      dataState.warningValue.id != null ? dataState.warningValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxWarningEvent(warningValue: value));
      },
      items: dataState.listOfWarning
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _backfillingDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectBackfilling,
      dropdownValue:
      dataState.backfillingValue.id != null ? dataState.backfillingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxBackfillingEvent(backfillingValue: value));
      },
      items: dataState.listOfBackfilling
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _taggingDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTagging,
      dropdownValue:
      dataState.taggingValue.id != null ? dataState.taggingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxTaggingEvent(taggingValue: value));
      },
      items: dataState.listOfTagging
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _routeMarkingDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectRoute,
      dropdownValue:
      dataState.routeMarkingValue.id != null ? dataState.routeMarkingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxRouteMarkingEvent(routeMarkingValue: value));
      },
      items: dataState.listOfRouteMarking
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _irDown({required FetchAddCableInstallationState dataState}) {
    return DropdownWidget(
      hint: AppString.selectIR,
      dropdownValue:
      dataState.irValue.id != null ? dataState.irValue : null,
      onChanged: (value) {
        BlocProvider.of<AddCableInstallationBloc>(context)
            .add(AddTestStationBoxIREvent(irValue: value));
      },
      items: dataState.listOfIR
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _activityRemark({required FetchAddCableInstallationState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddCableInstallationState dataState}) {
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
                    BlocProvider.of<AddCableInstallationBloc>(context).add(
                        AddCableInstallationAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddCableInstallationBloc>(context).add(
                        AddCableInstallationAddImageEvent(
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

  Widget _button({required FetchAddCableInstallationState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddCableInstallationBloc>(context)
              .add(AddCableInstallationSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


