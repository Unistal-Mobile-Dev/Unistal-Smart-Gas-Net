import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/surgeDiverter/addSurgeDiverter/domain/bloc/add_surge_diverter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';

class AddSurgeDiverterPage extends StatefulWidget {
  const AddSurgeDiverterPage({super.key});

  @override
  State<AddSurgeDiverterPage> createState() => _AddSurgeDiverterPageState();
}

class _AddSurgeDiverterPageState extends State<AddSurgeDiverterPage> {
  @override
  void initState() {
    BlocProvider.of<AddSurgeDiverterBloc>(context)
        .add(AddSurgeDiverterPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddSurgeDiverterBloc, AddSurgeDiverterState>(
        builder: (context, state) {
          if (state is FetchAddSurgeDiverterState) {
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

  Widget _itemBuilder({required FetchAddSurgeDiverterState dataState}) {
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
            _locationController(dataState: dataState),
            _verticalSpace(),
            _surgeDiverterController(dataState: dataState),
            _verticalSpace(),
            _installationDropDown(dataState: dataState),
            _verticalSpace(),
            _cableConnectionDropDown(dataState: dataState),
            _verticalSpace(),
            _pspReadingProtectionController(dataState: dataState),
            _verticalSpace(),
            _pspReadingOtherController(dataState: dataState),
            _verticalSpace(),
            _polarityCheckController(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _backfillDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddSurgeDiverterState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
      dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
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

  Widget _chainageController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterTLPTypeEvent(tlpTypeValue: value));
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


  Widget _areaController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }

  Widget _locationController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.locationController,
    );
  }

  Widget _surgeDiverterController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.routeSurvey,
      controller: dataState.surgeDiverterController,
    );
  }

  Widget _installationDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget(
      hint: AppString.selectInstallation,
      dropdownValue:
      dataState.installationValue.id != null ? dataState.installationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterInstallationEvent(installationValue: value));
      },
      items: dataState.listOfInstallation
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _cableConnectionDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCableConnection,
      dropdownValue:
      dataState.cableConnectionValue.id != null ? dataState.cableConnectionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterCableConnectionEvent(cableConnectionValue: value));
      },
      items: dataState.listOfCableConnection
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _pspReadingProtectionController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPSPReadingProtection,
      controller: dataState.pspReadingProtectionController,
    );
  }

  Widget _pspReadingOtherController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPSPReadingOther,
      controller: dataState.pspReadingOtherController,
    );
  }

  Widget _polarityCheckController({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPolarityCheck,
      controller: dataState.polarityCheckController,
    );
  }

  Widget _cableTerminationDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCableTermination,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterCableTerminationEvent(cableTerminationValue: value));
      },
      items: dataState.listOfCableTermination
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }
  Widget _backfillDropDown({required FetchAddSurgeDiverterState dataState}) {
    return DropdownWidget(
      hint: AppString.selectBackfilling,
      dropdownValue:
      dataState.backfillValue.id != null ? dataState.backfillValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSurgeDiverterBloc>(context)
            .add(AddSurgeDiverterBackfillEvent(backfillValue: value));
      },
      items: dataState.listOfBackfill
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _activityRemark({required FetchAddSurgeDiverterState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddSurgeDiverterState dataState}) {
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
                    color: AppColor.themeColor,
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
                        color: AppColor.themeColor,
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
                    BlocProvider.of<AddSurgeDiverterBloc>(context).add(
                        AddSurgeDiverterAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddSurgeDiverterBloc>(context).add(
                        AddSurgeDiverterAddImageEvent(
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

  Widget _button({required FetchAddSurgeDiverterState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddSurgeDiverterBloc>(context)
              .add(AddSurgeDiverterSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


