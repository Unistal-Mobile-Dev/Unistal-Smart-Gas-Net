import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/bloc/add_joint_coating_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddJointCoatingPage extends StatefulWidget {
  const AddJointCoatingPage({super.key});

  @override
  State<AddJointCoatingPage> createState() => _AddJointCoatingPageState();
}

class _AddJointCoatingPageState extends State<AddJointCoatingPage> {
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
  bool get _isAllClient => _isVPPL || _isURJAGATI || _isGJPL || _isPJPL;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddJointCoatingBloc>(context)
        .add(AddJointCoatingPageLoadEvent(context: context));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddJointCoatingBloc, AddJointCoatingState>(
        builder: (context, state) {
          if (state is FetchAddJointCoatingDataState) {
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

  Widget _itemBuilder({required FetchAddJointCoatingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
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
            if(_isHPCL || _isHPOIL || _isVPPL || _isVRPL || _isPJPL) ...[
              _verticalSpace(),
              _sleeveTypeDropDown(dataState: dataState),
            ],
            _verticalSpace(),
            if(_isURJAGATI || _isGJPL)...[
              _chainageFromController(dataState: dataState),
              _verticalSpace(),
            ]else...[
              _chainageFromController(dataState: dataState),
              _verticalSpace(),
              _chainageToController(dataState: dataState),
              _verticalSpace(),
            ],
            _primaryAbatchController(dataState: dataState),
            _verticalSpace(),
            _primaryBbatchController(dataState: dataState),
            _verticalSpace(),
            _batchNoController(dataState: dataState),
            _verticalSpace(),
            if(!(_isPJPL))...[
              _locatinController(dataState: dataState),
              _verticalSpace(),
            ],
            if(!(_isVPPL || _isPJPL))...[
              _thicknessDropDown(dataState: dataState),
              _verticalSpace(),

            ],
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
           _isURJAGATI || _isGJPL ? _surfaceDropDown(dataState: dataState) : _surfaceController(dataState: dataState) ,
            _verticalSpace(),
            _holidayTestNoController(dataState: dataState),
            _verticalSpace(),
            _humidityMeterDetailsController(dataState: dataState),
            _verticalSpace(),
            _visualChecksDropDown(dataState: dataState),
            _verticalSpace(),
            if (!(_isAllClient || _isVPPL || _isVRPL)) ...[
              _digitalPyrometerDetailsController(dataState: dataState),
              _verticalSpace(),
              _profileGaugeDetailsController(dataState: dataState),
              _verticalSpace(),
            ],
            _holidayChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _calibarationFrequencyController(dataState: dataState),
            _verticalSpace(),
            _elcoMeterController(dataState: dataState),
            _verticalSpace(),
            _peelTestDropDown(dataState: dataState),
            _verticalSpace(),
            _thicknessCtrl(dataState: dataState),
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

  Widget _formatNoField() {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: "Format No",
      initialValue: AppConfig.instanceInit()!.activitySectionData.formateNo.toString(),
    );
  }

  Widget _dateController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _onWeldController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI || _isGJPL ? "On Weld Bead":AppString.onWeld,
      controller: dataState.onWeldController,
    );
  }

  Widget _alignmentDropdown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
            isRequired: true,
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
              BlocProvider.of<AddJointCoatingBloc>(context)
                  .add(AddJointCoatingMultipleSelectAlignmentEvent(
                alignmentData: selectedAlignmentDataList,
              ));
            },
          );
  }

  Widget _weatherDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _pipeMaterialDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<PipeMaterialModel>(
      hint: AppString.selectPipeMaterial,
      dropdownValue: dataState.pipeMaterialData.id != null
          ? dataState.pipeMaterialData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectPipeMaterialDataEvent(
                pipeMaterialData: value!));
      },
      items: dataState.pipeMaterialList
    );
  }

  Widget _pipeDiaDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<PipeDiaModel>(
      hint: AppString.selectPipeDia,
      dropdownValue:
          dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectPipeDiaDataEvent(pipeDiaData: value!));
      },
      items: dataState.pipeDialList
    );
  }

  Widget _thicknessDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<ThicknessModel>(
      hint: AppString.selectPipeThickness,
      dropdownValue:
          dataState.thicknessData.id != null ? dataState.thicknessData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectThicknessDataEvent(thicknessData: value!));
      },
      items: dataState.thicknessList
    );
  }

  Widget _sleeveTypeDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<CoatingTypeModel>(
      isRequired: true,
      hint: AppString.sleeveType,
      dropdownValue: dataState.coatingTypeData.id != null
          ? dataState.coatingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectCoatingTypeDataEvent(coatingTypeData: value!));
      },
      items: dataState.coatingTypeList
    );
  }

  Widget _peelTestDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      hint: _isURJAGATI || _isGJPL ? "Peel Test": AppString.selectPeelTest,
      dropdownValue: dataState.peelTestData.id != null ? dataState.peelTestData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectPeelTestDataEvent(peelTestData: value!));
      },
      items: dataState.peelTestList
    );
  }

  Widget _locatinController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: _isVPPL ? "Relative Humidity" : AppString.location,
      controller: dataState.locationController,
    );
  }

  Widget _holidayTestNoController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI || _isGJPL ? "Pre-Heating" : AppString.holidayTestNo,
      controller: dataState.holidayTestNoController,
    );
  }

  Widget _calibarationFrequencyController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Calibaration Frequency",
      controller: dataState.calibarationFrequencyController,
    );
  }

  Widget _elcoMeterController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Elco Meter",
      controller: dataState.elcoMeterController,
    );
  }

  Widget _primaryAbatchController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.primerABatch,
      controller: dataState.primaryAbatchController,
    );
  }

  Widget _primaryBbatchController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.primerBBatch,
      controller: dataState.primaryBbatchController,
    );
  }

  Widget _humidityMeterDetailsController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI || _isGJPL ? "WFT" : "Humidity Meter Details",
      controller: dataState.humidityMeterDetailsController,
    );
  }

  Widget _digitalPyrometerDetailsController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Digital Pyrometer Details",
      controller: dataState.digitalPyrometerDetailsController,
    );
  }

  Widget _profileGaugeDetailsController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: _isHPCL || _isHPOIL ? true : false,
      labelText: "Profile Gauge Details",
      controller: dataState.profileGaugeDetailsController,
    );
  }

  Widget _surfaceDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<PaddingModel>(
        hint: "Surface Preparation Check",
        dropdownValue:
        dataState.surfacePreprationData.id != null ? dataState.surfacePreprationData : null,
        onChanged: (value) {
          BlocProvider.of<AddJointCoatingBloc>(context)
              .add(SelectSurfacePreparationEvent(surfacePreparationData: value!));
        },
        items: dataState.surfacePreprationList
    );
  }

  Widget _surfaceController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText:  AppString.surface,
      controller: dataState.surfaceController,
    );
  }

  Widget _visualChecksDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: _isURJAGATI || _isGJPL ? "Visuals": AppString.selectVisualChecks,
      dropdownValue: dataState.visualChecksData.id != null
          ? dataState.visualChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectVisualChecksDataEvent(
                visualChecksData: value!));
      },
      items: dataState.visualsChecksList
    );
  }

  Widget _onBodyController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI|| _isGJPL ? "On Base Metal": AppString.onBody,
      controller: dataState.onBodyController,
    );
  }

  Widget _electrometerNoController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.electrometerNo,
      controller: dataState.electrometerNoController,
    );
  }

  Widget _jointTypeDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _fromJointNumberDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.fromJointData.id != null ? dataState.fromJointData : null,
      hint: AppString.selectJointNumber,
      items: dataState.jointFromList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectFromJointDataEvent(jointNumberData: value!));
      },
    );
  }

  Widget _toJointNumberDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddJointCoatingBloc>(context).add(
                  AddJointCoatingSelectToJointDataEvent(
                      jointNumberData: value!));
            },
            items: dataState.jointToList
          )
        : const DottedLoaderWidget();
  }


  Widget _chainageFromController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: _isURJAGATI || _isGJPL ? AppString.chainage :AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _batchNoController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: _isURJAGATI || _isGJPL || _isHPCL || _isHPOIL || _isVPPL || _isVRPL ? "Sleeve Batch No." : AppString.batchNo,
      controller: dataState.batchNoController,
    );
  }

  Widget _holidayChecksDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<HolidayChecksModel>(
      hint: _isURJAGATI || _isGJPL ? "Holiday test at 25 KV": AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null
          ? dataState.holidayChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectHolidayDataEvent(holidayChecksData: value!));
      },
      items: dataState.holidayCheckList
    );
  }

  Widget _thicknessCtrl({required FetchAddJointCoatingDataState dataState}){
    return DottedBorderWidget(
      title: "Thickness",
      children: [
        _onBodyController(dataState: dataState),
        _verticalSpace(),
        _onWeldController(dataState: dataState),
      ],
    );
  }

  Widget _activityRemark({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddJointCoatingDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddJointCoatingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddJointCoatingBloc>(context)
                  .add(AddJointCoatingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
