import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/ssd/addSSD/domain/bloc/add_ssd_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddSsdPage extends StatefulWidget {
  const AddSsdPage({super.key});

  @override
  State<AddSsdPage> createState() => _AddSsdPageState();
}

class _AddSsdPageState extends State<AddSsdPage> {
  @override
  void initState() {
    BlocProvider.of<AddSsdBloc>(context)
        .add(AddSsdPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddSsdBloc, AddSsdState>(
        builder: (context, state) {
          if (state is FetchAddSsdState) {
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

  Widget _itemBuilder({required FetchAddSsdState dataState}) {
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
            _voltageController(dataState: dataState),
            _verticalSpace(),
            _htTowerController(dataState: dataState),
            _verticalSpace(),
            _installationDropDown(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _checkACVolDropDown(dataState: dataState),
            _verticalSpace(),
            _pspDropDown(dataState: dataState),
            _verticalSpace(),
            _finalRestorationDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddSsdState dataState}) {
    return  AppConfig.instanceInit()!.client == Client.vppl
        ?  DropDownSearchMultiSelectWidget(
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    ) : DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
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
      {required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdTLPTypeEvent(tlpTypeValue: value));
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


  Widget _areaController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }
  Widget _locationController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.locationController,
    );
  }

  Widget _voltageController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectVoltageRating,
      controller: dataState.voltageController,
    );
  }
  Widget _htTowerController({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectHTTower,
      controller: dataState.htTowerController,
    );
  }

  Widget _installationDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget(
      hint: AppString.selectInstallation,
      dropdownValue:
      dataState.installationValue.id != null ? dataState.installationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdInstallationEvent(installationValue: value));
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

  Widget _cableTerminationDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCableTermination,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdCableTerminationEvent(cableTerminationValue: value));
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

  Widget _checkACVolDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCheckACVol,
      dropdownValue:
      dataState.checkACVolValue.id != null ? dataState.checkACVolValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdCheckACVolEvent(checkACVolValue: value));
      },
      items: dataState.listOfCheckACVol
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _pspDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPSP,
      dropdownValue:
      dataState.pspValue.id != null ? dataState.pspValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdPSPEvent(pspValue: value));
      },
      items: dataState.listOfPSP
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _finalRestorationDropDown({required FetchAddSsdState dataState}) {
    return DropdownWidget(
      hint: AppString.selectFinalRestoration,
      dropdownValue:
      dataState.finalRestorationValue.id != null ? dataState.finalRestorationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSsdBloc>(context)
            .add(AddSsdFinalRestorationEvent(finalRestorationValue: value));
      },
      items: dataState.listOfFinalRestoration
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _activityRemark({required FetchAddSsdState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddSsdState dataState}) {
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
                    BlocProvider.of<AddSsdBloc>(context).add(
                        AddSsdAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddSsdBloc>(context).add(
                        AddSsdAddImageEvent(
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

  Widget _button({required FetchAddSsdState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddSsdBloc>(context)
              .add(AddSsdSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


