import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/tieIn/addTiein/domain/bloc/add_tiein_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';

class AddTieinPage extends StatefulWidget {
  const AddTieinPage({super.key});

  @override
  State<AddTieinPage> createState() => _AddTieinPageState();
}

class _AddTieinPageState extends State<AddTieinPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isPJPL => _client == Client.pjpl;
  bool get _isMGL => _client == Client.mgl;



  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddTieinBloc>(context)
        .add(AddTieinPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddTieinBloc, AddTieinState>(
        builder: (context, state) {
          if (state is FetchAddTieinDataState) {
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

  Widget _itemBuilder({required FetchAddTieinDataState dataState}) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _verticalSpace(),
            if (_isVPPL || _isVRPL || _isBJPL || _isPJPL) ...[
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
            _wpsDropDown(dataState: dataState),
            _verticalSpace(),
            if(_isPJPL)...[
              _chainageController(dataState: dataState),
              _verticalSpace(),
            ]else...[
              _chainageFromController(dataState: dataState),
              _verticalSpace(),
              _chainageToController(dataState: dataState),
              _verticalSpace(),
            ],
            _electrodeDiaE6010Controller(dataState: dataState),
            _verticalSpace(),
            _electrodeDiaE6010BatchController(dataState: dataState),
            _verticalSpace(),
            _electrodeEiaE7010p1Controller(dataState: dataState),
            _verticalSpace(),
            _electrodeEiaE7010p1BatchController(dataState: dataState),
            _verticalSpace(),
            if (_isVPPL || _isVRPL || _isPJPL) ...[
              _electrodeDiaE9045p2Controller(dataState: dataState),
              _verticalSpace(),
              _electrodeDiaE9045p2BatchController(dataState: dataState),
              _verticalSpace(),
            ],
            if(_isPJPL)...[
              _internalCleaningPipeController(dataState: dataState),
              _verticalSpace(),
              _pigPassController(dataState: dataState),
              _verticalSpace(),
              _thicknessCheckController(dataState: dataState),
              _verticalSpace(),
            ],
            _leftPipeDropDown(dataState: dataState),
            _verticalSpace(),
            _rigthPipeDropDown(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _fitupDropDown(dataState: dataState),
            _verticalSpace(),
            _preheatTempController(dataState: dataState),
            _verticalSpace(),
            _rootWelders1Dropdown(dataState: dataState),
            _verticalSpace(),
            _rootWelders2Dropdown(dataState: dataState),
            _verticalSpace(),
            if(_isVPPL || _isVRPL || _isPJPL)...[
              _hotWelders1Controller(dataState: dataState),
              _verticalSpace(),
              _hotWelders2Controller(dataState: dataState),
              _verticalSpace(),
              _filler1Welders1Controller(dataState: dataState),
              _verticalSpace(),
              _filler1Welders2Controller(dataState: dataState),
              _verticalSpace(),
              _filler2Welders1Controller(dataState: dataState),
              _verticalSpace(),
              _filler2Welders2Controller(dataState: dataState),
              _verticalSpace(),
              _filler3Welders1Controller(dataState: dataState),
              _verticalSpace(),
              _filler3Welders2Controller(dataState: dataState),
              _verticalSpace(),
              _filler4Welders1Controller(dataState: dataState),
              _verticalSpace(),
              _filler4Welders2Controller(dataState: dataState),
              _verticalSpace(),
              _cappingWelder1Controller(dataState: dataState),
              _verticalSpace(),
              _cappingWelder2Controller(dataState: dataState),
              _verticalSpace(),
            ],
            _weldVisualDropDown(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        )));
  }

  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue:
          AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }

  Widget _dateController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddTieinBloc>(context).add(AddTieinSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _preheatTempController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: _isURJAGATI || _isGJPL || _isHPCL || _isHPOIL || _isVPPL || _isVRPL || _isBJPL || _isPJPL
          ? "Bend Details"
          : AppString.preHeatTemperature,
      controller: dataState.preheatTempController,
    );
  }

  Widget _chainageFromController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }
  Widget _chainageController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }
  Widget _internalCleaningPipeController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      labelText: "Internal Cleaning Pipe",
      controller: dataState.internalCleaningPipeController,
    );
  }

  Widget _pigPassController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      labelText: "Pig Pass",
      controller: dataState.pigPassController,
    );
  }

  Widget _thicknessCheckController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      labelText: "Arc Strike removal by grinding DP, MP test & Thickness Check",
      controller: dataState.thicknessCheckController,
    );
  }

  Widget _chainageToController({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _leftPipeDropDown({required FetchAddTieinDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchLeftPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSearchPipeDataEvent(
                  keyword: value,
                  context: context,
                  isLeftPipe: true,
                  isRightPipe: false));
        },
        onClick: (value) {
          BlocProvider.of<AddTieinBloc>(context)
              .add(AddTieinSelectLeftPipeDataEvent(leftPipeData: value));
        },
        controller: dataState.searchLeftPipeController,
        label: AppString.selectLeftPipeNumber,
        list: dataState.searchLeftPipeList);
  }

  Widget _rigthPipeDropDown({required FetchAddTieinDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchRightPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSearchPipeDataEvent(
                  keyword: value,
                  context: context,
                  isLeftPipe: false,
                  isRightPipe: true));
        },
        onClick: (value) {
          BlocProvider.of<AddTieinBloc>(context)
              .add(AddTieinSelectRightPipeDataEvent(rightPipeData: value));
        },
        controller: dataState.searchPipeRightController,
        label: AppString.selectRightPipeNumber,
        list: dataState.searchRightPipeList);
  }

  Widget _rootWelders1Dropdown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.welder1,
        dropdownValue:
            dataState.welderData.id != null ? dataState.welderData : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context)
              .add(AddTieinSelectWelderEvent(welderData: value!));
        },
        items: dataState.rootWelders1List);
  }

  Widget _rootWelders2Dropdown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.welder2,
        dropdownValue: dataState.rootWelders2Data.id != null
            ? dataState.rootWelders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.rootWelders2));
        },
        items: dataState.rootWelders2List);
  }

  Widget _hotWelders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.hotWelders,
        dropdownValue: dataState.hotWelders1Data.id != null
            ? dataState.hotWelders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.hotWelders1));
        },
        items: dataState.hotWelders1List);
  }

  Widget _hotWelders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.hotWelders2,
        dropdownValue: dataState.hotWelders2Data.id != null
            ? dataState.hotWelders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.hotWelders2));
        },
        items: dataState.hotWelders2List);
  }

  Widget _filler1Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.fillerWelders,
        dropdownValue: dataState.filler1Welders1Data.id != null
            ? dataState.filler1Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler1Welders1));
        },
        items: dataState.filler1Welders1List);
  }

  Widget _filler1Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler1Welders2,
        dropdownValue: dataState.filler1Welders2Data.id != null
            ? dataState.filler1Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler1Welders2));
        },
        items: dataState.filler1Welders2List);
  }

  Widget _filler2Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler2Welders1,
        dropdownValue: dataState.filler2Welders1Data.id != null
            ? dataState.filler2Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler2Welders1));
        },
        items: dataState.filler2Welders1List);
  }

  Widget _filler2Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler2Welders2,
        dropdownValue: dataState.filler2Welders2Data.id != null
            ? dataState.filler2Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler2Welders2));
        },
        items: dataState.filler2Welders2List);
  }

  Widget _filler3Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler3Welders1,
        dropdownValue: dataState.filler3Welders1Data.id != null
            ? dataState.filler3Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler3Welders1));
        },
        items: dataState.filler3Welders1List);
  }

  Widget _filler3Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler3Welders2,
        dropdownValue: dataState.filler3Welders2Data.id != null
            ? dataState.filler3Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler3Welders2));
        },
        items: dataState.filler3Welders2List);
  }

  Widget _filler4Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler4Welders1,
        dropdownValue: dataState.filler4Welders1Data.id != null
            ? dataState.filler4Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler4Welders1));
        },
        items: dataState.filler4Welders1List);
  }

  Widget _filler4Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler4Welders2,
        dropdownValue: dataState.filler4Welders2Data.id != null
            ? dataState.filler4Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler4Welders2));
        },
        items: dataState.filler4Welders2List);
  }

  Widget _filler5Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler5Welders1,
        dropdownValue: dataState.filler5Welders1Data.id != null
            ? dataState.filler5Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler5Welders1));
        },
        items: dataState.filler5Welders1List);
  }

  Widget _filler5Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler5Welders2,
        dropdownValue: dataState.filler5Welders2Data.id != null
            ? dataState.filler5Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler5Welders2));
        },
        items: dataState.filler5Welders2List);
  }

  Widget _filler6Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler6Welders1,
        dropdownValue: dataState.filler6Welders1Data.id != null
            ? dataState.filler6Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler6Welders1));
        },
        items: dataState.filler6Welders1List);
  }

  Widget _filler6Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler6Welders2,
        dropdownValue: dataState.filler6Welders2Data.id != null
            ? dataState.filler6Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler6Welders2));
        },
        items: dataState.filler6Welders2List);
  }

  Widget _filler7Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler7Welders1,
        dropdownValue: dataState.filler7Welders1Data.id != null
            ? dataState.filler7Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler7Welders1));
        },
        items: dataState.filler7Welders1List);
  }

  Widget _filler7Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler7Welders2,
        dropdownValue: dataState.filler7Welders2Data.id != null
            ? dataState.filler7Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler7Welders2));
        },
        items: dataState.filler7Welders2List);
  }

  Widget _filler8Welders1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler8Welders1,
        dropdownValue: dataState.filler8Welders1Data.id != null
            ? dataState.filler8Welders1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler8Welders1));
        },
        items: dataState.filler8Welders1List);
  }

  Widget _filler8Welders2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.filler8Welders2,
        dropdownValue: dataState.filler8Welders2Data.id != null
            ? dataState.filler8Welders2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.filler8Welders2));
        },
        items: dataState.filler8Welders2List);
  }

  Widget _stripWelder1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.stripWelder1,
        dropdownValue: dataState.stripWelder1Data.id != null
            ? dataState.stripWelder1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.stripWelder1));
        },
        items: dataState.stripWelder1List);
  }

  Widget _stripWelder2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.stripWelder2,
        dropdownValue: dataState.stripWelder2Data.id != null
            ? dataState.stripWelder2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.stripWelder2));
        },
        items: dataState.stripWelder2List);
  }

  Widget _cappingWelder1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.cappingWelder,
        dropdownValue: dataState.cappingWelder1Data.id != null
            ? dataState.cappingWelder1Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.cappingWelder1));
        },
        items: dataState.cappingWelder1List);
  }

  Widget _cappingWelder2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WelderModel>(
        hint: AppString.cappingWelder2,
        dropdownValue: dataState.cappingWelder2Data.id != null
            ? dataState.cappingWelder2Data
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectMultiWelderEvent(
                  welderData: value!, name: AppString.cappingWelder2));
        },
        items: dataState.cappingWelder2List);
  }

  Widget _electrodeDiaE6010Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: AppString.electrodeDiaE6010,
      items: dataState.electrodeDiaE6010DiaList,
      dropdownValue: dataState.electrodeDiaE6010Value.diaValue != null
          ? dataState.electrodeDiaE6010Value
          : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(SelectElectrodeDiaE6010Event(
            electrodeDiaE6010Value: value!, context: context));
      },
    );
  }

  Widget _electrodeDiaE6010BatchController({required FetchAddTieinDataState dataState}) {
    return dataState.isLoaderDiaE6010BatchBatch == false
        ? DropdownWidget(
            hint: "Batch No.",
            items: dataState.electrodeDiaE6010BatchList,
            dropdownValue: dataState.electrodeDiaE6010BatchValue.batchNo != null
                ? dataState.electrodeDiaE6010BatchValue
                : null,
            onChanged: (value) {
              BlocProvider.of<AddTieinBloc>(context).add(
                  SelectElectrodeDiaE6010BatchEvent(
                      electrodeDiaE6010BatchValue: value!, context: context));
            },
          )
        : DottedLoaderWidget();
  }

  Widget _electrodeEiaE7010p1Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: _isURJAGATI || _isGJPL || _isVPPL || _isVRPL || _isPJPL
          ? "E8010 Dia"
          : AppString.electrodeDiaE7010P1,
      items: dataState.electrodeEiaE8010p1DiaList,
      dropdownValue: dataState.electrodeEiaE8010p1Value.diaValue != null
          ? dataState.electrodeEiaE8010p1Value
          : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            SelectElectrodeEiaE7010p1Event(
                electrodeEiaE8010p1Value: value!, context: context));
      },
    );
  }

  Widget _electrodeEiaE7010p1BatchController({required FetchAddTieinDataState dataState}) {
    return dataState.isLoaderEiaE8010p1BatchBatch == false
        ? DropdownWidget(
            hint: "Batch No.",
            items: dataState.electrodeEiaE8010p1BatchList,
            dropdownValue:
                dataState.electrodeEiaE8010p1BatchValue.batchNo != null
                    ? dataState.electrodeEiaE8010p1BatchValue
                    : null,
            onChanged: (value) {
              BlocProvider.of<AddTieinBloc>(context).add(
                  SelectElectrodeEiaE7010p1BatchEvent(
                      electrodeEiaE8010p1BatchValue: value!, context: context));
            },
          )
        : DottedLoaderWidget();
  }

  Widget _electrodeDiaE9045p2Controller({required FetchAddTieinDataState dataState}) {
    return DropdownWidget(
      hint: "E9045 Dia",
      items: dataState.electrodeEiaE8010p1DiaList,
      dropdownValue: dataState.electrodeEiaE8010p1Value.diaValue != null
          ? dataState.electrodeEiaE8010p1Value
          : null,
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context).add(
            SelectElectrodeDiaE9045p2Event(
                electrodeDiaE9045p2Value: value!, context: context));
      },
    );
  }

  Widget _electrodeDiaE9045p2BatchController({required FetchAddTieinDataState dataState}) {
    return dataState.isLoaderDiaE9045p2Batch == false
        ? DropdownWidget(
            hint: "Batch No.",
            items: dataState.electrodeDiaE9045p2BatchList,
            dropdownValue:
                dataState.electrodeDiaE9045p2BatchValue.batchNo != null
                    ? dataState.electrodeDiaE9045p2BatchValue
                    : null,
            onChanged: (value) {
              BlocProvider.of<AddTieinBloc>(context).add(
                  SelectElectrodeDiaE9045p2BatchEvent(
                      electrodeDiaE9045p2BatchValue: value!, context: context));
            },
          )
        : DottedLoaderWidget();
  }

  Widget _activityRemark({required FetchAddTieinDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _alignmentDropdown({required FetchAddTieinDataState dataState}) {
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
        BlocProvider.of<AddTieinBloc>(context)
            .add(AddTieinMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
        hint: AppString.selectWeather,
        dropdownValue:
            dataState.weatherData.id != null ? dataState.weatherData : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context)
              .add(SelectWeatherEvent(weatherData: value!));
        },
        items: dataState.weatherList);
  }

  Widget _wpsDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<WPSModel>(
        isRequired: true,
        hint: AppString.selectWPS,
        dropdownValue: dataState.wpsData.id != null ? dataState.wpsData : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context)
              .add(AddTieinSelectWPSEvent(wpsData: value!, context: context));
        },
        items: dataState.wpsList);
  }

  Widget _jointTypeDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
        hint: AppString.selectJointType,
        dropdownValue:
            dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context).add(
              AddTieinSelectJointTypeEvent(
                  jointTypeData: value!, context: context));
        },
        items: dataState.jointTypeList);
  }

  Widget _jointNumberDropDown({required FetchAddTieinDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.jointNumberData.id != null
          ? dataState.jointNumberData
          : null,
      hint: AppString.selectJointNumber,
      items: dataState.jointNumberList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddTieinBloc>(context)
            .add(AddTieinSelectJointNumberEvent(jointNumberData: value!));
      },
    );
  }

  Widget _fitupDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
        hint: AppString.selectFitup,
        dropdownValue:
            dataState.fitupData.id != null ? dataState.fitupData : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context)
              .add(AddTieinSelectFitupDataEvent(fitupData: value!));
        },
        items: dataState.fitupList);
  }

  Widget _weldVisualDropDown({required FetchAddTieinDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
        hint: _isURJAGATI || _isGJPL || _isHPCL || _isHPOIL
            ? "Visual Inspection"
            : AppString.selectWeldVisual,
        dropdownValue: dataState.weldVisualData.id != null
            ? dataState.weldVisualData
            : null,
        onChanged: (value) {
          BlocProvider.of<AddTieinBloc>(context)
              .add(AddTieinSelectWeldVisualEvent(weldVisualData: value!));
        },
        items: dataState.weldVisualList);
  }

  Widget _photo({required FetchAddTieinDataState dataState}) {
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddTieinBloc>(context)
            .add(AddTieinAddImageEvent(context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddTieinBloc>(context)
            .add(AddTieinAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddTieinDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddTieinBloc>(context)
                  .add(AddTieinSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
