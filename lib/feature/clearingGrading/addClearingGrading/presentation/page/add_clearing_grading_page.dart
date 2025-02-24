import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';

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
            DottedBorder(
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
            )),
            _verticalSpace(),
            AppConfig.instanceInit()!.client != Client.purvaBharti
                ? Column(
                    children: [
                      _tpIpChainageController(dataState: dataState),
                      _verticalSpace(),
                      _tpIpNOSController(dataState: dataState),
                      _verticalSpace(),
                      _ipNumberController(dataState: dataState),
                      _verticalSpace(),
                      _ipNumberFrom(dataState: dataState),
                      _verticalSpace(),
                      _groundTypeController(dataState: dataState),
                      _verticalSpace(),
                      _structureNameController(dataState: dataState),
                      _verticalSpace(),
                      _chainageController(dataState: dataState),
                      _verticalSpace(),
                      _boundaryLocationController(dataState: dataState),
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
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: false, value: value));
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
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(CalculateLengthEvent(isChainageTo: true, value: value));
      },
    );
  }

  Widget _lengthController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _tpIpChainageController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: "TP No. From",
      controller: dataState.tpChainageController,
    );
  }

  Widget _tpIpNOSController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: "TP No. To",
      controller: dataState.tpChainageNumberController,
    );
  }

  Widget _ipNumberController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: "IP No. From",
      controller: dataState.ipNumberController,
    );
  }

  Widget _ipNumberFrom({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.ipNoTo,
      controller: dataState.ipNumberFromController,
    );
  }

  Widget _groundTypeController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 2,
      labelText: AppString.groundType,
      controller: dataState.groundTypeController,
    );
  }

  Widget _structureNameController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.structureName,
      controller: dataState.structureNameController,
    );
  }

  Widget _chainageController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _boundaryLocationController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.boundaryLocation,
      controller: dataState.boundaryLocationController,
    );
  }

  Widget _activityRemark(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown(
      {required FetchAddClearingGradingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(AddClearingGradingSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown(
      {required FetchAddClearingGradingDataState dataState}) {
    return DropdownWidget(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context)
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

  Widget _terrainDropDown(
      {required FetchAddClearingGradingDataState dataState}) {
    return DropdownWidget(
      isRequired: true,
      hint: AppString.selectTerrain,
      dropdownValue: dataState.terrainTypeData.id != null
          ? dataState.terrainTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddClearingGradingBloc>(context)
            .add(AddClearingGradingSelectTerrainEvent(terrainTypeData: value));
      },
      items: dataState.terrainTypeList.map<DropdownMenuItem<TerrainTypeModel>>(
          (TerrainTypeModel terrainTypeData) {
        return DropdownMenuItem<TerrainTypeModel>(
          value: terrainTypeData,
          child: Text(terrainTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _gapLengthController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.lengthMeter,
      controller: dataState.gapLengthController,
    );
  }

  Widget _gapDescriptionController(
      {required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.description,
      controller: dataState.gapDescriptionController,
    );
  }

  Widget _photo({required FetchAddClearingGradingDataState dataState}) {
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
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddClearingGradingBloc>(context)
                  .add(AddClearingGradingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
