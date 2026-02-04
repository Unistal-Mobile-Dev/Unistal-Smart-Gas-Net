import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/bloc/add_test_station_box_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddTestStationBoxPage extends StatefulWidget {
  const AddTestStationBoxPage({super.key});

  @override
  State<AddTestStationBoxPage> createState() => _AddTestStationBoxPageState();
}

class _AddTestStationBoxPageState extends State<AddTestStationBoxPage> {
  @override
  void initState() {
    BlocProvider.of<AddTestStationBoxBloc>(context)
        .add(AddTestStationBoxPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddTestStationBoxBloc, AddTestStationBoxState>(
        builder: (context, state) {
          if (state is FetchAddTestStationBoxState) {
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

  Widget _itemBuilder({required FetchAddTestStationBoxState dataState}) {
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
            _areaController(dataState: dataState),
            _verticalSpace(),
            _tlpTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _testStationLocationController(dataState: dataState),
            _verticalSpace(),
            _testStationTypeController(dataState: dataState),
            _verticalSpace(),
            _distanceDropDown(dataState: dataState),
            _verticalSpace(),
            _foundationCheckDropDown(dataState: dataState),
            _verticalSpace(),
            _testLocationDropDown(dataState: dataState),
            _verticalSpace(),
            _tsDoorsDropDown(dataState: dataState),
            _verticalSpace(),
            _cableEntrySealingDropDown(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _namePlateDropDown(dataState: dataState),
            _verticalSpace(),
            _individualResistorDropDown(dataState: dataState),
            _verticalSpace(),
            _compactionDropDown(dataState: dataState),
            _verticalSpace(),
            _cableSealingDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddTestStationBoxState dataState}) {
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
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    ) : DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
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

  Widget _chainageController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }
  Widget _tlpTypeDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
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


  Widget _areaController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }

  Widget _testStationLocationController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.testStationLocationController,
    );
  }

  Widget _testStationTypeController({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectTestType,
      controller: dataState.testStationTypeController,
    );
  }

  Widget _distanceDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.distanceValue.id != null ? dataState.distanceValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxDistanceEvent(distanceValue: value));
      },
      items: dataState.listOfDistance
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _foundationCheckDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectFoundation,
      dropdownValue:
      dataState.foundationCheckValue.id != null ? dataState.foundationCheckValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxFoundationCheckEvent(foundationCheckValue: value));
      },
      items: dataState.listOfFoundationCheck
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _testLocationDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTestLocation,
      dropdownValue:
      dataState.tsMountingValue.id != null ? dataState.tsMountingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxTestStationMountingEvent(tsMountingValue: value));
      },
      items: dataState.listOfTSMounting
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _tsDoorsDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.tsDoorsValue.id != null ? dataState.tsDoorsValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxTestStationDoorsEvent(tsDoorsValue: value));
      },
      items: dataState.listOfTSDoors
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _cableEntrySealingDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCable,
      dropdownValue:
      dataState.cableEntrySealingValue.id != null ? dataState.cableEntrySealingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCableEntrySealingEvent(cableEntrySealingValue: value));
      },
      items: dataState.listOfCableEntrySealing
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }
  Widget _cableTerminationDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCableTerminationEvent(cableTerminationValue: value));
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
  Widget _namePlateDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectNamePlate,
      dropdownValue:
      dataState.namePlateValue.id != null ? dataState.namePlateValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxNamePlateEvent(namePlateValue: value));
      },
      items: dataState.listOfNmePlate
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }
  Widget _individualResistorDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectDistance,
      dropdownValue:
      dataState.individualResistorValue.id != null ? dataState.individualResistorValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxIndividualResistorEvent(individualResistorValue: value));
      },
      items: dataState.listOfIndividualResistor
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }
  Widget _compactionDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCompaction,
      dropdownValue:
      dataState.compactionValue.id != null ? dataState.compactionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCompactionEvent(compactionValue: value));
      },
      items: dataState.listOfCompaction
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }
  Widget _cableSealingDropDown({required FetchAddTestStationBoxState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCableSealing,
      dropdownValue:
      dataState.cableSealingValue.id != null ? dataState.cableSealingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddTestStationBoxBloc>(context)
            .add(AddTestStationBoxCableSealingEvent(cableSealingValue: value));
      },
      items: dataState.listOfCableSealing
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _activityRemark({required FetchAddTestStationBoxState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddTestStationBoxState dataState}) {
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
                    BlocProvider.of<AddTestStationBoxBloc>(context).add(
                        AddTestStationBoxAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddTestStationBoxBloc>(context).add(
                        AddTestStationBoxAddImageEvent(
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

  Widget _button({required FetchAddTestStationBoxState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddTestStationBoxBloc>(context)
              .add(AddTestStationBoxSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


