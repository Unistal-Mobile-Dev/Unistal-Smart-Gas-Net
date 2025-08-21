import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/sacrificialAnode/addSacrificialAnode/domain/bloc/add_sacrificial_anode_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';

class AddSacrificialAnodePage extends StatefulWidget {
  const AddSacrificialAnodePage({super.key});

  @override
  State<AddSacrificialAnodePage> createState() => _AddSacrificialAnodePageState();
}

class _AddSacrificialAnodePageState extends State<AddSacrificialAnodePage> {
  @override
  void initState() {
    BlocProvider.of<AddSacrificialAnodeBloc>(context)
        .add(AddSacrificialAnodePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddSacrificialAnodeBloc, AddSacrificialAnodeState>(
        builder: (context, state) {
          if (state is FetchAddSacrificialAnodeState) {
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

  Widget _itemBuilder({required FetchAddSacrificialAnodeState dataState}) {
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
            _testStationLocationController(dataState: dataState),
            _verticalSpace(),
            _testStationTypeController(dataState: dataState),
            _verticalSpace(),
            _testStationController(dataState: dataState),
            _verticalSpace(),
            _sacrificialAnodeDropDown(dataState: dataState),
            _verticalSpace(),
            _distanceController(dataState: dataState),
            _verticalSpace(),
            _noAnodesController(dataState: dataState),
            _verticalSpace(),
            _spacingAnodesController(dataState: dataState),
            _verticalSpace(),
            _outputAnodesController(dataState: dataState),
            _verticalSpace(),
            _anodeConditionDropDown(dataState: dataState),
            _verticalSpace(),
            _anode(dataState: dataState),
            _verticalSpace(),
            _anodeCircuitController(dataState: dataState),
            _verticalSpace(),
            _beforeAnodeController(dataState: dataState),
            _verticalSpace(),
            _afterAnodeController(dataState: dataState),
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

  Widget _dateController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddSacrificialAnodeSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddSacrificialAnodeState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
      dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddSacrificialAnodeSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
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

  Widget _chainageController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }
  Widget _tlpTypeDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
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


  Widget _areaController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }

  Widget _testStationLocationController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectAnodeLocation,
      controller: dataState.testStationLocationController,
    );
  }

  Widget _testStationTypeController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestType,
      controller: dataState.testStationTypeController,
    );
  }

  Widget _testStationController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestStation,
      controller: dataState.testStationController,
    );
  }

  Widget _sacrificialAnodeDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget(
      hint: AppString.selectSacrificialAnode,
      dropdownValue:
      dataState.sacrificialAnodeValue.id != null ? dataState.sacrificialAnodeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddTestStationBoxSacrificialAnodeTypeEvent(sacrificialAnodeValue: value));
      },
      items: dataState.listOfSacrificialAnode
          .map<DropdownMenuItem<TlpTypeModel>>((TlpTypeModel tlpTypeData) {
        return DropdownMenuItem<TlpTypeModel>(
          value: tlpTypeData,
          child: Text(tlpTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _distanceController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectDistance,
      controller: dataState.distanceController,
    );
  }

  Widget _noAnodesController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectAnode,
      controller: dataState.noAnodesController,
    );
  }

  Widget _spacingAnodesController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectSpacingAnode,
      controller: dataState.spacingAnodesController,
    );
  }

  Widget _outputAnodesController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectOutputAnode,
      controller: dataState.outputAnodesController,
    );
  }

  Widget _anodeConditionDropDown({required FetchAddSacrificialAnodeState dataState}) {
    return DropdownWidget(
      hint: AppString.selectAnodeCondition,
      dropdownValue:
      dataState.anodeConditionValue.id != null ? dataState.anodeConditionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddSacrificialAnodeBloc>(context)
            .add(AddTestStationBoxAnodeConditionEvent(anodeConditionValue: value));
      },
      items: dataState.listOfAnodeCondition
          .map<DropdownMenuItem<VisualChecksModel>>((VisualChecksModel visualChecksModel) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksModel,
          child: Text(visualChecksModel.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _anode({required FetchAddSacrificialAnodeState dataState}){
    return DottedBorder(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Text("Anode Tail Cable Length(mtr)"),
            _verticalSpace(),
            _a1Controller(dataState: dataState),
            _verticalSpace(),
            _a2Controller(dataState: dataState),
            _verticalSpace(),
            _a3Controller(dataState: dataState),
          ],
        ),
      ),
    );
  }
  Widget _a1Controller({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA1,
      controller: dataState.a1Controller,
    );
  }

  Widget _a2Controller({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA2,
      controller: dataState.a2Controller,
    );
  }

  Widget _a3Controller({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA3,
      controller: dataState.a3Controller,
    );
  }

  Widget _anodeCircuitController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectAnodeCircuit,
      controller: dataState.anodeCircuitController,
    );
  }

  Widget _beforeAnodeController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectBeforePSP,
      controller: dataState.beforeAnodeController,
    );
  }

  Widget _afterAnodeController({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectAfterPSP,
      controller: dataState.afterAnodeController,
    );
  }



  Widget _activityRemark({required FetchAddSacrificialAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddSacrificialAnodeState dataState}) {
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
                    BlocProvider.of<AddSacrificialAnodeBloc>(context).add(
                        AddSacrificialAnodeAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddSacrificialAnodeBloc>(context).add(
                        AddSacrificialAnodeAddImageEvent(
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

  Widget _button({required FetchAddSacrificialAnodeState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddSacrificialAnodeBloc>(context)
              .add(AddSacrificialAnodeSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


