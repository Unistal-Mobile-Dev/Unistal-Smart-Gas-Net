import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/ground_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddClearingGradingPage extends StatefulWidget {
  const AddClearingGradingPage({super.key});

  @override
  State<AddClearingGradingPage> createState() => _AddClearingGradingPageState();
}

class _AddClearingGradingPageState extends State<AddClearingGradingPage> {
  @override
  void initState() {
    BlocProvider.of<AddClearingGradingBloc>(context)
        .add(AddClearingGradingPageLoadEvent(context: context));
    super.initState();
  }

  final client = AppConfig.instanceInit()!.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddClearingGradingBloc, AddClearingGradingState>(
        builder: (context, state) {
          if (state is FetchAddClearingGradingDataState) {
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

  Widget _itemBuilder({required FetchAddClearingGradingDataState dataState}) {
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
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _terrainDropDown(dataState: dataState),
            _verticalSpace(),
            client != Client.vppl
                ? DottedBorder(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _verticalSpace(),
                      TextWidget(
                        AppString.detailOfGap,
                      ),
                      _verticalSpace(),
                      _gapLengthController(dataState: dataState),
                      _verticalSpace(),
                      _gapDescriptionController(dataState: dataState),
                      _verticalSpace(),
                    ],
                  ),
                ))
                : SizedBox.shrink(),
            _verticalSpace(),
            client != Client.mgl
                ? Column(
              children: [
                client == Client.vppl
                    ? DottedBorder(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _verticalSpace(),
                        TextWidget(
                          "MARKERS FOR",
                        ),
                        _verticalSpace(),
                        _tpIpChainageController(dataState: dataState),
                        _verticalSpace(),
                        _tpIpNOSController(dataState: dataState),
                        _verticalSpace(),
                      ],
                    ),
                  ),
                )
                    : SizedBox.shrink(),
                client != Client.vppl ? _tpIpChainageController(dataState: dataState) : SizedBox.shrink(),
                client != Client.vppl ? _verticalSpace() : SizedBox.shrink(),
                client != Client.vppl ? _tpIpNOSController(dataState: dataState) : SizedBox.shrink(),
                client != Client.vppl ? _verticalSpace() : SizedBox.shrink(),
                _verticalSpace(),
                client == Client.vppl
                    ? DottedBorder(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _verticalSpace(),
                        TextWidget(
                          "Details of Structure In/Across ROU such as Pipeline, HT etc.",
                        ),
                        _verticalSpace(),
                        _structureNameController(dataState: dataState),
                        _verticalSpace(),
                        _ipNumberController(dataState: dataState),
                        _verticalSpace(),
                        _ipNumberFrom(dataState: dataState),
                        _verticalSpace(),
                      ],
                    ),
                  ),
                )
                    : SizedBox.shrink(),
                client != Client.vppl ? _ipNumberController(dataState: dataState) : SizedBox.shrink(),
                client != Client.vppl ? _verticalSpace() : SizedBox.shrink(),
                client != Client.vppl ? _ipNumberFrom(dataState: dataState) : SizedBox.shrink(),
                 _verticalSpace(),
                client != Client.vppl ? _groundTypeController(dataState: dataState) : SizedBox.shrink(),
                client != Client.vppl ? _verticalSpace() : SizedBox.shrink(),
                client != Client.vppl ? _structureNameController(dataState: dataState) : SizedBox.shrink(),
                _verticalSpace(),
                client != Client.vppl ? _chainageController(dataState: dataState) : SizedBox.shrink(),
                client != Client.vppl ? _verticalSpace() : SizedBox.shrink(),
                client != Client.vppl ? _boundaryLocationController(dataState: dataState) : SizedBox.shrink(),
                _verticalSpace(),
              ],
            )
                : const SizedBox.shrink(),
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

  Widget _dateController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(AddClearingGradingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context).add(
            CalculateLengthEvent(
                isChainageTo: false, value: value, context: context));
      },
    );
  }

  Widget _chainageToController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context).add(
            CalculateLengthEvent(
                isChainageTo: true, value: value, context: context));
      },
    );
  }

  Widget _lengthController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _tpIpChainageController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "TP No. From",
      controller: dataState.tpChainageController,
    );
  }

  Widget _tpIpNOSController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "TP No. To",
      controller: dataState.tpChainageNumberController,
    );
  }

  Widget _ipNumberController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType:TextInputType.number,
      labelText: client == Client.vppl ? "Chainage From":"IP No. From" ,
      controller: dataState.ipNumberController,
    );
  }

  Widget _ipNumberFrom({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText:  client == Client.vppl ? "Chainage To": AppString.ipNoTo,
      controller: dataState.ipNumberFromController,
    );
  }

  Widget _groundTypeController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 2,
      labelText: AppString.groundType,
      controller: dataState.groundTypeController,
    );
  }

  Widget _structureNameController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.structureName,
      controller: dataState.structureNameController,
    );
  }

  Widget _chainageController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _boundaryLocationController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.boundaryLocation,
      controller: dataState.boundaryLocationController,
    );
  }

  Widget _activityRemark({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddClearingGradingDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) =>
          alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];
        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(AddClearingGradingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddClearingGradingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList,
    );
  }

  Widget _groundTypeDropDown({required FetchAddClearingGradingDataState dataState}) {
    return DropdownWidget<GroundTypeModel>(
      hint: AppString.selectGroundType,
      dropdownValue:
      dataState.groundTypeData.id != null ? dataState.groundTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context).add(
            AddClearingGradingSelectGroundTypeEvent(groundTypeData: value!));
      },
      items: dataState.groundTypeList,
    );
  }

  Widget _terrainDropDown({required FetchAddClearingGradingDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
      hint: client == Client.vppl ? AppString.selectGroundType: AppString.selectTerrain,
      dropdownValue: dataState.terrainTypeData.id != null
          ? dataState.terrainTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(AddClearingGradingSelectTerrainEvent(terrainTypeData: value!));
      },
      items: dataState.terrainTypeList,
    );
  }

  Widget _gapLengthController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.lengthMeter,
      controller: dataState.gapLengthController,
    );
  }

  Widget _gapDescriptionController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.description,
      controller: dataState.gapDescriptionController,
    );
  }

  Widget _photo({required FetchAddClearingGradingDataState dataState}) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width / 3,
      height: MediaQuery
          .of(context)
          .size
          .width / 3,
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
                    MediaQuery
                        .of(context)
                        .size
                        .width * 0.02),
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width / 4.5,
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
                    dataState.file.path
                        .split('/')
                        .last
                        .toString(),
                    color:
                    EnvironmentConfig.of(context)!.primaryTheme,
                    fontSize: AppFont.font_12,
                  )
                      : const SizedBox.shrink(),
                ],
              ),
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 3,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width / 3,
                  color: Colors.white.withOpacity(0.6),
                  child: Center(
                      child: Icon(
                        Icons.refresh,
                        color: EnvironmentConfig.of(context)!.primaryTheme,
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
          height: MediaQuery
              .of(context)
              .size
              .height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddClearingGradingBloc>(context).add(
                        AddClearingGradingAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddClearingGradingBloc>(context).add(
                        AddClearingGradingAddImageEvent(
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

  Widget _button({required FetchAddClearingGradingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery
            .of(context)
            .size
            .height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddClearingGradingBloc>(context)
              .add(AddClearingGradingSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.02,
    );
  }
}
