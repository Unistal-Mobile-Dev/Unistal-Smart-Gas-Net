import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/domain/add_clearing_grading_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddClearingGradingPage extends StatefulWidget {
  const AddClearingGradingPage({super.key});

  @override
  State<AddClearingGradingPage> createState() => _AddClearingGradingPageState();
}

class _AddClearingGradingPageState extends State<AddClearingGradingPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;
  bool get _isPJPL => _client == Client.pjpl;
  bool get _isAllClient => _isVPPL || _isURJAGATI || _isGJPL || _isHPCL || _isHPOIL  || _isBJPL || _isPJPL;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;

    BlocProvider.of<AddClearingGradingBloc>(context)
        .add(AddClearingGradingPageLoadEvent(context: context));
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Widget _itemBuilder({required FetchAddClearingGradingDataState dataState}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildBasicInfoSection(dataState),
            if (!(_isVPPL || _isHPCL || _isHPOIL  || _isBJPL || _isPJPL)) _buildGapSection(dataState),
            if (!_isMGL) _buildClientSpecificSection(dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _photo(dataState: dataState),
            const SizedBox(height: 24),
            _button(dataState: dataState),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection(FetchAddClearingGradingDataState dataState) {
    return Column(
      children: [
        _verticalSpace(),
        if(_isVPPL || _isVRPL || _isBJPL || _isPJPL)...[
          _formatNoField(),
          _verticalSpace(),
        ],
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
        if(_isBJPL)...[
          _machineyController(dataState: dataState),
          _verticalSpace(),
          _manpowerController(dataState: dataState),
          _verticalSpace(),
        ],
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
          _verticalSpace(),
        ],
      ),
    );
  }

  //================================================================
  // CLIENT SECTION
  //================================================================

  Widget _buildClientSpecificSection(FetchAddClearingGradingDataState dataState) {
    if (_isAllClient) {
      return Column(
        children: [
          _verticalSpace(),
          _isURJAGATI || _isGJPL  ? SizedBox.shrink(): _buildMarkerSection(dataState),
          _verticalSpace(),
          _isURJAGATI || _isGJPL ? _structureNameController(dataState: dataState):_buildStructureSection(dataState),
        ],
      );
    }
    return Column(
      children: [
        _verticalSpace(),
        _tpIpChainageController(dataState: dataState),
        _verticalSpace(),
        _tpIpNOSController(dataState: dataState),
        _verticalSpace(),
        _ipNumberController(dataState: dataState),
        _verticalSpace(),
        _ipNumberFrom(dataState: dataState),
        _verticalSpace(),
        if(!(_isHPCL || _isHPOIL || _isBJPL))...[
          _groundTypeController(dataState: dataState),
          _verticalSpace(),
        ],
        _structureNameController(dataState: dataState),
        _verticalSpace(),
        _chainageController(dataState: dataState),
        _verticalSpace(),
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
        _verticalSpace(),
        _tpIpNOSController(dataState: dataState),
      ],
    );
  }

  //================================================================
  // STRUCTURE SECTION
  //================================================================

  Widget _buildStructureSection(FetchAddClearingGradingDataState dataState) {
    return  DottedBorderWidget(
      title: _isBJPL ? "Details of Structures/utilities/Crossings(U/G,A/G & O/H).":"Details of Structure In/Across ROU such as Pipeline, HT etc.",
      children: [
        _structureNameController(dataState: dataState),
        _verticalSpace(),
        _ipNumberController(dataState: dataState),
        _verticalSpace(),
        _ipNumberFrom(dataState: dataState),
        _verticalSpace(),
        _isBJPL ? _detailsController(dataState: dataState) : SizedBox(),
      ],
    );
  }


  //================================================================
  // FORM FIELDS
  //================================================================


  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue: AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }


  Widget _dateController({required FetchAddClearingGradingDataState dataState,}) {
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

  Widget _reportNumberController({required FetchAddClearingGradingDataState dataState,}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _chainageFromController({required FetchAddClearingGradingDataState dataState,}) {
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

  Widget _chainageToController({required FetchAddClearingGradingDataState dataState,}) {
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

  Widget _lengthController({required FetchAddClearingGradingDataState dataState,}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _tpIpChainageController({required FetchAddClearingGradingDataState dataState,}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "TP No. From",
      controller: dataState.tpChainageController,
    );
  }

  Widget _tpIpNOSController({required FetchAddClearingGradingDataState dataState,}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: "TP No. To",
      controller: dataState.tpChainageNumberController,
    );
  }

  Widget _ipNumberController({required FetchAddClearingGradingDataState dataState,}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: _isAllClient ? "Chainage From" : "IP No. From",
      controller: dataState.ipNumberController,
    );
  }

  Widget _ipNumberFrom({required FetchAddClearingGradingDataState dataState,}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: _isAllClient ? "Chainage To" : AppString.ipNoTo,
      controller: dataState.ipNumberFromController,
    );
  }

  Widget _groundTypeController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 2,
      labelText: _isURJAGATI || _isGJPL ? AppString.terrain : AppString.groundType,
      controller: dataState.groundTypeController,
    );
  }

  Widget _structureNameController({required FetchAddClearingGradingDataState dataState,}) {
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

  Widget _alignmentDropdown({required FetchAddClearingGradingDataState dataState,}) {
    return DropDownSearchMultiSelectWidget(
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
      hint: _isVPPL || _isHPCL || _isHPOIL || _isPJPL
          ? AppString.selectGroundType
       : _isBJPL ? "Details of Strata(Normal Soil/Rocky/Seismic Clay)"
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

  Widget _machineyController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "Machiney",
      controller: dataState.machineyController,
    );
  }

  Widget _manpowerController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.text,
      labelText: "Manpower",
      controller: dataState.manpowerController,
    );
  }

  Widget _detailsController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      labelText:  "Details",
      controller: dataState.detailsController,
    );
  }

  Widget _gapDescriptionController({required FetchAddClearingGradingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.description,
      controller: dataState.gapDescriptionController,
    );
  }


  Widget _photo({required FetchAddClearingGradingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddClearingGradingBloc>(context).add(
            AddClearingGradingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddClearingGradingBloc>(context).add(
            AddClearingGradingAddImageEvent(
                context: context, mediaType: 2)),
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
  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
