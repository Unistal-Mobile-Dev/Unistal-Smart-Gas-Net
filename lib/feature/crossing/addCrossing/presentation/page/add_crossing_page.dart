import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/bloc/add_crossing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/model/crossing_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddCrossingPage extends StatefulWidget {
  const AddCrossingPage({super.key});

  @override
  State<AddCrossingPage> createState() => _AddCrossingPageState();
}

class _AddCrossingPageState extends State<AddCrossingPage> {
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
    BlocProvider.of<AddCrossingBloc>(context)
        .add(AddCrossingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddCrossingBloc, AddCrossingState>(
        builder: (context, state) {
          if (state is FetchAddCrossingDataState) {
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

  Widget _itemBuilder({required FetchAddCrossingDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if(_isVPPL || _isVRPL || _isBJPL)...[
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
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _sectionLengthController(dataState: dataState),
            _verticalSpace(),
            _casingPipeLength(dataState: dataState),
            _verticalSpace(),
            _concreteCoatingLengthController(dataState: dataState),
            _verticalSpace(),
            _crossingTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _crossingNameController(dataState: dataState),
            _verticalSpace(),
            _holidayChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _prePaddingDropDown(dataState: dataState),
            _verticalSpace(),
            _postPaddingDropDown(dataState: dataState),
            _verticalSpace(),
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            if(_isVPPL)...[
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photoStageInspection(dataState: dataState)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photoPreHydrotest(dataState: dataState)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photoRestoration(dataState: dataState)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photoPhotoBefore(dataState: dataState)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photoPhotoAfter(dataState: dataState)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photoVideoBefore(dataState: dataState)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photoVideoAfter(dataState: dataState)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.44, child: _photo(dataState: dataState)),
                ],
              ),
            ],
            if(!_isVPPL)...[
              _photo(dataState: dataState)
            ],
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

  Widget _dateController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddCrossingDataState dataState}) {
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
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _pipeMaterialDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<PipeMaterialModel>(
      hint: AppString.selectPipeMaterial,
      dropdownValue: dataState.pipeMaterialData.id != null
          ? dataState.pipeMaterialData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectPipeMaterialDataEvent(pipeMaterialData: value!));
      },
      items: dataState.pipeMaterialList,
    );
  }

  Widget _pipeDiaDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<PipeDiaModel>(
      hint: AppString.selectPipeDia,
      dropdownValue:
          dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectPipeDiaDataEvent(pipeDiaData: value!));
      },
      items: dataState.pipeDialList,
    );
  }

  Widget _thicknessDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<ThicknessModel>(
      hint: AppString.selectPipeThickness,
      dropdownValue:
          dataState.thicknessData.id != null ? dataState.thicknessData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectThicknessDataEvent(thicknessData: value!));
      },
      items: dataState.thicknessList,
    );
  }

  Widget _coatingTypeDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<CoatingTypeModel>(
      hint: AppString.selectCoatingType,
      dropdownValue: dataState.coatingTypeData.id != null
          ? dataState.coatingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectCoatingTypeDataEvent(coatingTypeData: value!));
      },
      items: dataState.coatingTypeList,
    );
  }

  Widget _prePaddingDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      hint: AppString.selectPrePadding,
      dropdownValue:
          dataState.prePaddingData.id != null ? dataState.prePaddingData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectPrePaddingDataEvent(prePaddingData: value!));
      },
      items: dataState.prePaddingList,
    );
  }

  Widget _postPaddingDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      hint: AppString.selectPostPadding,
      dropdownValue: dataState.postPaddingData.id != null
          ? dataState.postPaddingData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectPostPaddingDataEvent(postPaddingData: value!));
      },
      items: dataState.postPaddingList
    );
  }

  Widget _locatinController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.location,
      controller: dataState.locationController,
    );
  }

  Widget _holidayTestNoController(
      {required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.holidayTestNo,
      controller: dataState.holidayTestNoController,
    );
  }

  Widget _concreteCoatingLengthController(
      {required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.concreteCoatingLengthMeter,
      controller: dataState.concreteCoatingLengthController,
    );
  }

  Widget _crossingNameController(
      {required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.crossingName,
      controller: dataState.crossingNameController,
    );
  }

  Widget _surfaceController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.surface,
      controller: dataState.surfaceController,
    );
  }

  Widget _visualChecksDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectVisualChecks,
      dropdownValue: dataState.visualChecksData.id != null
          ? dataState.visualChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectVisualChecksDataEvent(visualChecksData: value!));
      },
      items: dataState.visualsChecksList
    );
  }

  Widget _onBodyController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.onBody,
      controller: dataState.onBodyController,
    );
  }

  Widget _electrometerNoController(
      {required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.electrometerNo,
      controller: dataState.electrometerNoController,
    );
  }

  Widget _jointTypeDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList,
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddCrossingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.fromJointData.id != null ? dataState.fromJointData : null,
      hint: AppString.selectFromJointNumber,
      items: dataState.jointFromList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectFromJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _toJointNumberDropDown(
      {required FetchAddCrossingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.toJointData.id != null ? dataState.toJointData : null,
      hint: AppString.selectToJointNumber,
      items: dataState.jointToList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectToJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _sectionLengthController(
      {required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.sectionLengthMeter,
      controller: dataState.sectionLengthController,
    );
  }

  Widget _casingPipeLength({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      textInputType: TextInputType.number,
      labelText: AppString.casingPipeLengthMeter,
      controller: dataState.casingPipeLengthController,
    );
  }

  Widget _batchNoController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.batchNo,
      controller: dataState.batchNoController,
    );
  }

  Widget _crossingTypeDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<CrossingTypeModel>(
      isRequired: true,
      hint: AppString.selectCrossingType,
      dropdownValue: dataState.crossingTypeData.id != null
          ? dataState.crossingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectCrossingTypeDataEvent(crossingTypeData: value!));
      },
      items: dataState.crossingTyeList
    );
  }

  Widget _holidayChecksDropDown(
      {required FetchAddCrossingDataState dataState}) {
    return DropdownWidget<HolidayChecksModel>(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null
          ? dataState.holidayChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectHolidayDataEvent(holidayChecksData: value!));
      },
      items: dataState.holidayCheckList
    );
  }

  Widget _activityRemark({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photoStageInspection({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Stage Inspection Report",
      file: dataState.fileStageInspection,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingStageInspectionEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingStageInspectionEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _photoPreHydrotest({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Pre-Hydrotest",
      file: dataState.filePreHydrotest,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingPreHydrotestEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingPreHydrotestEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _photoRestoration({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Restoration",
      file: dataState.fileRestoration,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingRestorationEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingRestorationEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _photoPhotoBefore({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Photo-Before",
      file: dataState.filePhotoBefore,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingPhotoBeforeEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingPhotoBeforeEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _photoPhotoAfter({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Photo-After",
      file: dataState.filePhotoAfter,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingPhotoAfterEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingPhotoAfterEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _photoVideoBefore({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Video Before",
      file: dataState.fileVideoBefore,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingVideoBeforeEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingVideoBeforeEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _photoVideoAfter({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Video After",
      file: dataState.fileVideoAfter,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingVideoAfterEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingVideoAfterEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _photo({required FetchAddCrossingDataState dataState}){
    return PhotoUploadWidget(
      title: "Attachment File",
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(context: context,
        onCamera: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingAddImageEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddCrossingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddCrossingBloc>(context)
                  .add(AddCrossingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
  Widget _width() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.01,
    );
  }
}
