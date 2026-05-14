import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddClearingGradingPage extends StatefulWidget {
  const AddClearingGradingPage({super.key});

  @override
  State<AddClearingGradingPage> createState() => _AddClearingGradingPageState();
}

class _AddClearingGradingPageState extends State<AddClearingGradingPage> {
  final client = AppConfig.instanceInit()!.client;

  late bool isVpplOrUrjagati = false;
  late bool isVppl= false;
  late bool isUrjagati= false;
  late bool isMgl= false;

  static const SizedBox verticalSpace = SizedBox(height: 16);

  @override
  void initState() {
    super.initState();

    isVppl = client == Client.vppl;
    isUrjagati =  client == Client.urjagati;
    isVpplOrUrjagati = isVppl || isUrjagati;
    isMgl = client == Client.mgl;

    BlocProvider.of<AddClearingGradingBloc>(context)
        .add(AddClearingGradingPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddClearingGradingBloc, AddClearingGradingState>(
        builder: (context, state) {
          if (state is FetchAddClearingGradingDataState) {
            return _itemBuilder(dataState: state);
          }

          return const Center(
            child: CenterLoaderWidget(),
          );
        },
      ),
    );
  }

  Widget _itemBuilder({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildBasicInfoSection(dataState),
            if (!isVppl) _buildGapSection(dataState),
            if (!isMgl) _buildClientSpecificSection(dataState),
            verticalSpace,
            _activityRemark(dataState: dataState),
            verticalSpace,
            _photo(dataState: dataState),
            const SizedBox(height: 24),
            _button(dataState: dataState),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //================================================================
  // BASIC SECTION
  //================================================================

  Widget _buildBasicInfoSection(FetchAddClearingGradingDataState dataState) {
    return Column(
      children: [
        _dateController(dataState: dataState),
        verticalSpace,
        _reportNumberController(dataState: dataState),
        verticalSpace,
        _alignmentDropdown(dataState: dataState),
        verticalSpace,
        _weatherDropDown(dataState: dataState),
        verticalSpace,
        _chainageFromController(dataState: dataState),
        verticalSpace,
        _chainageToController(dataState: dataState),
        verticalSpace,
        _lengthController(dataState: dataState),
        verticalSpace,
        _terrainDropDown(dataState: dataState),
      ],
    );
  }

  //================================================================
  // GAP SECTION
  //================================================================

  Widget _buildGapSection(FetchAddClearingGradingDataState dataState) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DottedBorderWidget(
        title: AppString.detailOfGap,
        children: [
          _gapLengthController(dataState: dataState),
          verticalSpace,
          _gapDescriptionController(dataState: dataState),
        ],
      ),
    );
  }

  //================================================================
  // CLIENT SECTION
  //================================================================

  Widget _buildClientSpecificSection(FetchAddClearingGradingDataState dataState) {
    if (isVpplOrUrjagati) {
      return Column(
        children: [
          verticalSpace,
          isUrjagati ? SizedBox.shrink(): _buildMarkerSection(dataState),
          verticalSpace,
          isUrjagati?  _structureNameController(dataState: dataState):_buildStructureSection(dataState),
        ],
      );
    }
    return Column(
      children: [
        verticalSpace,
        _tpIpChainageController(dataState: dataState),
        verticalSpace,
        _tpIpNOSController(dataState: dataState),
        verticalSpace,
        _ipNumberController(dataState: dataState),
        verticalSpace,
        _ipNumberFrom(dataState: dataState),
        verticalSpace,
        _groundTypeController(dataState: dataState),
        verticalSpace,
        _structureNameController(dataState: dataState),
        verticalSpace,
        _chainageController(dataState: dataState),
        verticalSpace,
        _boundaryLocationController(dataState: dataState),
      ],
    );
  }

  //================================================================
  // MARKER SECTION
  //================================================================

  Widget _buildMarkerSection(FetchAddClearingGradingDataState dataState) {
    return DottedBorderWidget(
      title: "MARKERS FOR",
      children: [
        _tpIpChainageController(dataState: dataState),
        verticalSpace,
        _tpIpNOSController(dataState: dataState),
      ],
    );
  }

  //================================================================
  // STRUCTURE SECTION
  //================================================================

  Widget _buildStructureSection(FetchAddClearingGradingDataState dataState) {
    return  DottedBorderWidget(
      title: "Details of Structure In/Across ROU such as Pipeline, HT etc.",
      children: [
        _structureNameController(dataState: dataState),
        verticalSpace,
        _ipNumberController(dataState: dataState),
        verticalSpace,
        _ipNumberFrom(dataState: dataState),
      ],
    );
  }


  //================================================================
  // FORM FIELDS
  //================================================================

  Widget _dateController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        context.read<AddClearingGradingBloc>().add(
              AddClearingGradingSelectDateEvent(
                context: context,
              ),
            );
      },
    );
  }

  Widget _reportNumberController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        context.read<AddClearingGradingBloc>().add(
              CalculateLengthEvent(
                isChainageTo: false,
                value: value,
                context: context,
              ),
            );
      },
    );
  }

  Widget _chainageToController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        context.read<AddClearingGradingBloc>().add(
              CalculateLengthEvent(
                isChainageTo: true,
                value: value,
                context: context,
              ),
            );
      },
    );
  }

  Widget _lengthController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _tpIpChainageController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "TP No. From",
      controller: dataState.tpChainageController,
    );
  }

  Widget _tpIpNOSController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "TP No. To",
      controller: dataState.tpChainageNumberController,
    );
  }

  Widget _ipNumberController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: isVpplOrUrjagati ? "Chainage From" : "IP No. From",
      controller: dataState.ipNumberController,
    );
  }

  Widget _ipNumberFrom({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: isVpplOrUrjagati ? "Chainage To" : AppString.ipNoTo,
      controller: dataState.ipNumberFromController,
    );
  }

  Widget _groundTypeController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 2,
      labelText: isUrjagati ? AppString.terrain : AppString.groundType,
      controller: dataState.groundTypeController,
    );
  }

  Widget _structureNameController({required FetchAddClearingGradingDataState dataState,}) {
    return TextFieldWidget(
      labelText: AppString.structureName,
      controller: dataState.structureNameController,
    );
  }

  Widget _chainageController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _boundaryLocationController({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      labelText: AppString.boundaryLocation,
      controller: dataState.boundaryLocationController,
    );
  }

  Widget _activityRemark({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({
    required FetchAddClearingGradingDataState dataState,
  }) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        List<AlignmentModel> selectedAlignmentDataList = [];

        for (var data in value) {
          selectedAlignmentDataList.add(data);
        }

        context.read<AddClearingGradingBloc>().add(
              AddClearingGradingMultipleSelectAlignmentEvent(
                alignmentData: selectedAlignmentDataList,
              ),
            );
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
        context.read<AddClearingGradingBloc>().add(
              SelectWeatherEvent(weatherData: value!),
            );
      },
      items: dataState.weatherList,
    );
  }

  Widget _terrainDropDown({required FetchAddClearingGradingDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
      hint: isVppl
          ? AppString.selectGroundType
          : AppString.selectTerrain,
      dropdownValue: dataState.terrainTypeData.id != null
          ? dataState.terrainTypeData
          : null,
      onChanged: (value) {
        context.read<AddClearingGradingBloc>().add(
              AddClearingGradingSelectTerrainEvent(
                terrainTypeData: value!,
              ),
            );
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

  Widget _gapDescriptionController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.description,
      controller: dataState.gapDescriptionController,
    );
  }

  //================================================================
  // PHOTO
  //================================================================

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

  //================================================================
  // BUTTON
  //================================================================

  Widget _button({
    required FetchAddClearingGradingDataState dataState,
  }) {
    if (dataState.isLoader) {
      return const DottedLoaderWidget();
    }

    return ButtonWidget(
      text: AppString.submit,
      height: AppConfig.getDeviceType(context: context) == DeviceType.tablet
          ? MediaQuery.of(context).size.height * 0.13
          : null,
      onPressed: () {
        context.read<AddClearingGradingBloc>().add(
              AddClearingGradingSubmitDataEvent(
                context: context,
              ),
            );
      },
    );
  }
}
