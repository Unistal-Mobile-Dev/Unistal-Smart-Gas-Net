import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/thermitWeld/addThermitWeld/domain/bloc/add_thermit_weld_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddThermitWeldPage extends StatefulWidget {
  const AddThermitWeldPage({super.key});

  @override
  State<AddThermitWeldPage> createState() => _AddThermitWeldPageState();
}

class _AddThermitWeldPageState extends State<AddThermitWeldPage> {
  @override
  void initState() {
    BlocProvider.of<AddThermitWeldBloc>(context)
        .add(AddThermitWeldPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddThermitWeldBloc, AddThermitWeldState>(
        builder: (context, state) {
          if (state is FetchAddThermitWeldState) {
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

  Widget _itemBuilder({required FetchAddThermitWeldState dataState}) {
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
            _spacingController(dataState: dataState),
            _verticalSpace(),
            _cableController(dataState: dataState),
            _verticalSpace(),
            _epoxyController(dataState: dataState),
            _verticalSpace(),
            _cableSizeController(dataState: dataState),
            _verticalSpace(),
            _cableLengthController(dataState: dataState),
            _verticalSpace(),
            _pinBrazingDropDown(dataState: dataState),
            _verticalSpace(),
            _cableTrenchDropDown(dataState: dataState),
            _verticalSpace(),
            _restorationCheckDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(AddThermitWeldSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddThermitWeldState dataState}) {
    return  AppConfig.instanceInit()!.client == Client.vppl || AppConfig.instanceInit()!.client == Client.vrpl
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
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(AddThermitWeldMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    ) : DropDownSearchWidget(
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(AddThermitWeldSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddThermitWeldState dataState}) {
    return DropdownWidget<WeatherModel>(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }
  Widget _chainageController(
      {required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddThermitWeldState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(AddTestStationBoxTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }
  Widget _testStationLocationController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.testStationLocationController,
    );
  }
  Widget _testStationTypeController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestType,
      controller: dataState.testStationTypeController,
    );
  }
  Widget _spacingController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectSpacingConnection,
      controller: dataState.spacingController,
    );
  }
  Widget _cableController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCable,
      controller: dataState.cableController,
    );
  }  Widget _epoxyController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectEpoxy,
      controller: dataState.epoxyController,
    );
  }
  Widget _cableSizeController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCableSize,
      controller: dataState.cableSizeController,
    );
  }
  Widget _cableLengthController({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCableLength,
      controller: dataState.cableLengthController,
    );
  }

  Widget _pinBrazingDropDown({required FetchAddThermitWeldState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectPinBrazing,
      dropdownValue:
      dataState.pinBrazingValue.id != null ? dataState.pinBrazingValue : null,
      onChanged: (value) {
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(AddTestStationBoxPinBrazingEvent(pinBrazingValue: value!));
      },
      items: dataState.listOfPinBrazing
    );
  }

  Widget _cableTrenchDropDown({required FetchAddThermitWeldState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCableTrench,
      dropdownValue:
      dataState.continuityCheckValue.id != null ? dataState.continuityCheckValue : null,
      onChanged: (value) {
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(AddTestStationBoxContinuityCheckEvent(continuityCheckValue: value!));
      },
      items: dataState.listOfContinuityCheck
    );
  }

  Widget _restorationCheckDropDown({required FetchAddThermitWeldState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectRestorationCheck,
      dropdownValue:
      dataState.restorationCheckValue.id != null ? dataState.restorationCheckValue : null,
      onChanged: (value) {
        BlocProvider.of<AddThermitWeldBloc>(context)
            .add(AddTestStationBoxRestorationCheckEvent(restorationCheckValue: value!));
      },
      items: dataState.listOfRestorationCheck
    );
  }
  Widget _activityRemark({required FetchAddThermitWeldState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddThermitWeldState dataState}) {
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
                    BlocProvider.of<AddThermitWeldBloc>(context).add(
                        AddThermitWeldAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddThermitWeldBloc>(context).add(
                        AddThermitWeldAddImageEvent(
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

  Widget _button({required FetchAddThermitWeldState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddThermitWeldBloc>(context)
              .add(AddThermitWeldSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


