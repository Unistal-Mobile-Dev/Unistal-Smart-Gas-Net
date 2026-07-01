import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/bloc/add_route_survey_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/ground_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddRouteSurveyPage extends StatefulWidget {
  const AddRouteSurveyPage({super.key});

  @override
  State<AddRouteSurveyPage> createState() => _AddRouteSurveyPageState();
}

class _AddRouteSurveyPageState extends State<AddRouteSurveyPage> {
  late final AddRouteSurveyBloc _bloc;
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;

    _bloc = context.read<AddRouteSurveyBloc>();
    _bloc.add(AddRouteSurveyPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddRouteSurveyBloc, AddRouteSurveyState>(
        builder: (_, state) {
          if (state is! FetchAddRouteSurveyDataState) {
            return const Center(
              child: CenterLoaderWidget(),
            );
          }

          return _itemBuilder(dataState: state);
        },
      ),
    );
  }

  Widget _itemBuilder({required FetchAddRouteSurveyDataState dataState}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _verticalSpace(),
          if(_isVPPL || _isVRPL || _isBJPL)...[
            _formatNoField(),
            _verticalSpace(),
          ],
          _dateField(dataState:dataState),
          _verticalSpace(),
          _reportNumberField(dataState:dataState),
          _verticalSpace(),
          _alignmentDropdown(dataState:dataState),
          _verticalSpace(),
          _weatherDropdown(dataState:dataState),
          _verticalSpace(),
          _chainageFromField(dataState:dataState),
          _verticalSpace(),
          _chainageToField(dataState:dataState),
          _verticalSpace(),
          _lengthField(dataState:dataState),
          _verticalSpace(),
          _groundTypeDropdown(dataState:dataState),
          _verticalSpace(),
          if (!(_isURJAGATI || _isGJPL || _isVPPL || _isHPCL || _isHPOIL) ) ...[
            _tpFromField(dataState:dataState),
            _verticalSpace(),
          ],
          _tpNosField(dataState:dataState),

          _verticalSpace(),

          if (!(_isMGL)) ...[
            _bearingField(dataState:dataState),
            _verticalSpace(),
            if (!(_isURJAGATI || _isGJPL || _isVPPL || _isHPCL || _isHPOIL) ) ...[
              _terrainField(dataState:dataState),
              _verticalSpace(),
            ],
          ],
          if (!(_isVPPL || _isHPCL || _isHPOIL)) ...[
            _buildStructureSection(dataState:dataState),
            _verticalSpace(),
          ],
          _activityRemarkField(dataState:dataState),
          _verticalSpace(),
          _photo(dataState: dataState),
          _verticalSpace(),
          _verticalSpace(),
          _button(dataState: dataState),
        ],
      ),
    );
  }

  Widget _dateField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        _bloc.add(
          AddRouteSurveySelectDateEvent(context: context),
        );
      },
    );
  }

  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue: AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }

  Widget _reportNumberField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _tpFromField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      textInputType: _isURJAGATI || _isGJPL ? TextInputType.number: TextInputType.text,
      labelText: _isURJAGATI || _isGJPL ? "IP/TP No." : AppString.tpFrom,
      controller: dataState.tpChainageController,
    );
  }

  Widget _tpNosField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      textInputType: _isVPPL || _isHPCL || _isHPOIL ? TextInputType.text : TextInputType.number,
      labelText: _isVPPL || _isHPCL || _isHPOIL
          ? "Markers for IP Nos./TP Nos."
          : _isURJAGATI || _isGJPL ? "IP/TP Chainage" : AppString.tpTo,
      controller: dataState.tpChainageNumberController,
    );
  }


  Widget _bearingField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      textInputType: _isVPPL || _isHPCL || _isHPOIL ? TextInputType.text : TextInputType.number,
      labelText: _isVPPL || _isHPCL || _isHPOIL
          ? "Details of Structure In/Across ROU Such as P/L, HT Crossings"
          : AppString.bearingAngle,
      controller: dataState.bearingAngleController,
    );
  }

  Widget _terrainField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.terrain,
      controller: dataState.terrainController,
    );
  }

  Widget _chainageFromField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
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

  Widget _chainageToField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
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

  Widget _lengthField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _activityRemarkField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  // ---------------------------------------------------------------------------
  // DROPDOWNS
  // ---------------------------------------------------------------------------

  Widget _alignmentDropdown({required FetchAddRouteSurveyDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      isRequired: true,
      selectedItem: dataState.multipleAlignmentData,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
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

  Widget _weatherDropdown({required FetchAddRouteSurveyDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      items: dataState.weatherList,
      onChanged: (value) {
        if (value == null) return;

        _bloc.add(
          SelectWeatherEvent(weatherData: value),
        );
      },
    );
  }

  Widget _groundTypeDropdown({required FetchAddRouteSurveyDataState dataState}) {
    return DropdownWidget<GroundTypeModel>(
      hint: _isURJAGATI || _isGJPL ? AppString.terrain : AppString.selectGroundType,
      dropdownValue:
      dataState.groundTypeData.id != null ? dataState.groundTypeData : null,
      items: dataState.groundTypeList,
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

  Widget _photo({required FetchAddRouteSurveyDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => _bloc.add(AddRouteSurveyAddImageEvent(context: context, mediaType: 1)),
        onGallery: () => _bloc.add(AddRouteSurveyAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button( {required FetchAddRouteSurveyDataState dataState}) {
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

  Widget _buildStructureSection({required FetchAddRouteSurveyDataState dataState}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DottedBorderWidget(
        title: "Details of Structure",
        children: [
          _nameStructureField(dataState: dataState),
          _verticalSpace(),
          _chainageField(dataState: dataState),
          _verticalSpace(),
          _detailField(dataState: dataState),
        ],
      ),
    );
  }

  Widget _nameStructureField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      labelText: "Name of Structure",
      controller: dataState.structureController,
    );
  }
  Widget _chainageField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      labelText: "Chainage",
      textInputType: TextInputType.number,
      controller: dataState.chainageController,
    );
  }
  Widget _detailField({required FetchAddRouteSurveyDataState dataState}) {
    return TextFieldWidget(
      labelText: "Detail",
      controller: dataState.detailController,
    );
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}