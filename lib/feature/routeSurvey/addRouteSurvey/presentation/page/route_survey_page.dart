import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/bloc/add_route_survey_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/ground_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddRouteSurveyPage extends StatefulWidget {
  const AddRouteSurveyPage({super.key});

  @override
  State<AddRouteSurveyPage> createState() => _AddRouteSurveyPageState();
}

class _AddRouteSurveyPageState extends State<AddRouteSurveyPage> {
  late final AddRouteSurveyBloc _bloc;
  late final Client _client;

  bool get _isVppl => _client == Client.vppl;
  bool get _isUrjagati => _client == Client.urjagati;
  bool get _isVpplOrUrjagati => _isVppl || _isUrjagati;
  bool get _showTpFromField => !_isVpplOrUrjagati;
  bool get _showMglFields => _client != Client.mgl;

  @override
  void initState() {
    super.initState();

    _bloc = context.read<AddRouteSurveyBloc>();
    _client = AppConfig.instanceInit()!.client!;

    _bloc.add(AddRouteSurveyPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddRouteSurveyBloc, AddRouteSurveyState>(
        builder: (_, state) {
          if (state is! FetchAddRouteSurveyDataState) {
            return const Center(
              child: CenterLoaderWidget(),
            );
          }

          return _buildBody(state);
        },
      ),
    );
  }

  Widget _buildBody(FetchAddRouteSurveyDataState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _space,
          _dateField(state),
          _space,
          _reportNumberField(state),
          _space,
          _alignmentDropdown(state),
          _space,
          _weatherDropdown(state),
          _space,
          _chainageFromField(state),
          _space,
          _chainageToField(state),
          _space,
          _lengthField(state),
          _space,
          _groundTypeDropdown(state),
          _space,
          if (_showTpFromField || _isUrjagati) ...[
            _tpFromField(state),
            _space,
          ],
          _tpNosField(state),

          _space,

          if (_showMglFields) ...[
            _bearingField(state),
            _space,

            if (!_isVpplOrUrjagati ) ...[
              _terrainField(state),
              _space,
            ],
          ],
          _buildStructureSection(state),
          _space,
          _activityRemarkField(state),
          _space,

          _photo(dataState: state),
          _space,
          _space,
          _button(dataState: state),
        ],
      ),
    );
  }

  Widget get _space => SizedBox(
    height: MediaQuery.of(context).size.height * 0.02,
  );

  // ---------------------------------------------------------------------------
  // TEXTFIELDS
  // ---------------------------------------------------------------------------

  Widget _dateField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: state.dateController,
      onTap: () {
        _bloc.add(
          AddRouteSurveySelectDateEvent(context: context),
        );
      },
    );
  }

  Widget _reportNumberField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: state.reportNumberController,
    );
  }

  Widget _tpFromField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      textInputType: _isUrjagati ? TextInputType.number: TextInputType.text,
      labelText: _isUrjagati ? "IP/TP No." : AppString.tpFrom,
      controller: state.tpChainageController,
    );
  }

  Widget _tpNosField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      textInputType: _isVppl ? TextInputType.text : TextInputType.number,
      labelText: _isVppl
          ? "Markers for IP Nos./TP Nos."
          : _isUrjagati ? "IP/TP Chainage" : AppString.tpTo,
      controller: state.tpChainageNumberController,
    );
  }


  Widget _bearingField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      textInputType: _isVppl ? TextInputType.text : TextInputType.number,
      labelText: _isVppl
          ? "Details of Structure In/Across ROU Such as P/L, HT Crossings"
          : AppString.bearingAngle,
      controller: state.bearingAngleController,
    );
  }

  Widget _terrainField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      labelText: AppString.terrain,
      controller: state.terrainController,
    );
  }

  Widget _chainageFromField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: state.chainageFromController,
      onChanged: (value) {
        _bloc.add(
          CalculateLengthEvent(
            isChainageTo: false,
            value: value,
            context: context,
          ),
        );
      },
    );
  }

  Widget _chainageToField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: state.chainageToController,
      onChanged: (value) {
        _bloc.add(
          CalculateLengthEvent(
            isChainageTo: true,
            value: value,
            context: context,
          ),
        );
      },
    );
  }

  Widget _lengthField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: state.lengthController,
    );
  }

  Widget _activityRemarkField(FetchAddRouteSurveyDataState state) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: state.activityRemarkController,
    );
  }

  // ---------------------------------------------------------------------------
  // DROPDOWNS
  // ---------------------------------------------------------------------------

  Widget _alignmentDropdown(FetchAddRouteSurveyDataState state) {
    return DropDownSearchMultiSelectWidget(
      isRequired: true,
      selectedItem: state.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: state.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        _bloc.add(
          AddRouteSurveyMultipleSelectAlignmentEvent(
            alignmentData: List<AlignmentModel>.from(value),
          ),
        );
      },
    );
  }

  Widget _weatherDropdown(FetchAddRouteSurveyDataState state) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      state.weatherData.id != null ? state.weatherData : null,
      items: state.weatherList,
      onChanged: (value) {
        if (value == null) return;

        _bloc.add(
          SelectWeatherEvent(weatherData: value),
        );
      },
    );
  }

  Widget _groundTypeDropdown(FetchAddRouteSurveyDataState state) {
    return DropdownWidget<GroundTypeModel>(
      hint: _isUrjagati ? AppString.terrain : AppString.selectGroundType,
      dropdownValue:
      state.groundTypeData.id != null ? state.groundTypeData : null,
      items: state.groundTypeList,
      onChanged: (value) {
        if (value == null) return;

        _bloc.add(
          AddRouteSurveySelectGroundTypeEvent(
            groundTypeData: value,
          ),
        );
      },
    );
  }

  Widget _photo({required FetchAddRouteSurveyDataState dataState}) {
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
                                color: EnvironmentConfig.of(context)!.primaryTheme,
                                fontSize: AppFont.font_12,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        color: Colors.white.withValues(alpha: 0.6),
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
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddRouteSurveyBloc>(context).add(
                        AddRouteSurveyAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddRouteSurveyBloc>(context).add(
                        AddRouteSurveyAddImageEvent(
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

  Widget _button({required FetchAddRouteSurveyDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddRouteSurveyBloc>(context)
                  .add(AddRouteSurveySubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _buildStructureSection(FetchAddRouteSurveyDataState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DottedBorderWidget(
        title: "Details of Structure",
        children: [
          _nameStructureField(state: state),
          _space,
          _chainageField(state: state),
          _space,
          _detailField(state: state),
        ],
      ),
    );
  }

  Widget _nameStructureField({required FetchAddRouteSurveyDataState state}) {
    return TextFieldWidget(
      labelText: "Name of Structure",
      controller: state.structureController,
    );
  }
  Widget _chainageField({required FetchAddRouteSurveyDataState state}) {
    return TextFieldWidget(
      labelText: "Chainage",
      textInputType: TextInputType.number,
      controller: state.chainageController,
    );
  }
  Widget _detailField({required FetchAddRouteSurveyDataState state}) {
    return TextFieldWidget(
      labelText: "Detail",
      controller: state.detailController,
    );
  }


}