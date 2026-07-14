import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/bloc/add_back_filling_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddBackFillingPage extends StatefulWidget {
  const AddBackFillingPage({super.key});

  @override
  State<AddBackFillingPage> createState() => _AddBackFillingPageState();
}

class _AddBackFillingPageState extends State<AddBackFillingPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;
  bool get _isAllClient => _isVPPL || _isVRPL || _isBJPL || _isURJAGATI || _isGJPL || _isMGL;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;

    BlocProvider.of<AddBackFillingBloc>(context)
        .add(AddBackFillingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddBackFillingBloc, AddBackFillingState>(
        builder: (context, state) {
          if (state is FetchAddBackFillingDataState) {
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

  Widget _itemBuilder({required FetchAddBackFillingDataState dataState}) {
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
            _paddingDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            if(_isVPPL || _isVRPL || _isBJPL)...[
              _slopeBreakerCtrl(dataState: dataState),
              _verticalSpace(),
              _gratingsCtrl(dataState: dataState),
              _verticalSpace(),
              _antiBuoyancyController(dataState: dataState),
              _verticalSpace(),
            ],
            if (!(_isHPCL || _isHPOIL || _isVPPL || _isVRPL || _isBJPL)) ...[
              _recordingPipelineCtrl(dataState: dataState),
              _verticalSpace(),
              _locationCtrl(dataState: dataState),
              _verticalSpace(),
              _minimumCoverCtrl(dataState: dataState),
              _verticalSpace(),
              _hdpeDuctCtrl(dataState: dataState),
              _verticalSpace(),
              _warningMatController(dataState: dataState),
              _verticalSpace(),
            ],
            if (!(_isAllClient || _isHPCL || _isHPOIL)) ...[
              _postPaddingController(dataState: dataState),
              _verticalSpace(),
              _plasticGratingDropDown(dataState: dataState),
              _verticalSpace(),
            ],
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


  Widget _dateController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddBackFillingBloc>(context)
            .add(AddBackFillingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddBackFillingDataState dataState}) {
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
        BlocProvider.of<AddBackFillingBloc>(context)
            .add(AddBackFillingMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList,
    );
  }

  Widget _recordingPipelineCtrl({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Recording of Pipeline centre line and Level",
      controller: dataState.recordingPipelineCtrl,
    );
  }

  Widget _antiBuoyancyController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      labelText: _isURJAGATI || _isGJPL
          ? "Anti-Buoyancy Measures"
          :  _isVPPL || _isVRPL || _isBJPL
          ? "Anti Buoyancy"
          :AppString.antiBuoyancy,
      controller: dataState.antiBuoyancyController,
    );
  }

  Widget _gratingsCtrl({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      labelText: _isVPPL || _isVRPL  || _isBJPL
          ? "Plastic/Grating/Concrete Slab"
          :"Gratings / Concrete slabs at electrical / other Crossing",
      controller: dataState.gratingsCtrl,
    );
  }

  Widget _slopeBreakerCtrl({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.slopBreaker,
      controller: dataState.slopeBreakerCtrl,
    );
  }

  Widget _locationCtrl({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Location",
      controller: dataState.locationCtrl,
    );
  }

  Widget _minimumCoverCtrl({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "Availability of Minimum cover",
      controller: dataState.minimumCoverCtrl,
    );
  }

  Widget _paddingDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Padding",
        dropdownValue:
        dataState.paddingValue.id != null ? dataState.paddingValue : null,
        onChanged: (value) {
          BlocProvider.of<AddBackFillingBloc>(context)
              .add(AddLoweringSelectPaddingEvent(paddingValue: value!));
        },
        items: dataState.listOfPadding);
  }

  Widget _hdpeDuctCtrl({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: "HDPE Duct",
      controller: dataState.hdpeDuctCtrl,
    );
  }

  Widget _pipeDiaDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget<PipeDiaModel>(
      hint: AppString.selectPipeDia,
      dropdownValue:
          dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context)
            .add(AddBackFillingSelectPipeDiaDataEvent(pipeDiaData: value!));
      },
      items: dataState.pipeDialList,
    );
  }

  Widget _thicknessDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget<ThicknessModel>(
        hint: AppString.selectPipeThickness,
        dropdownValue:
            dataState.thicknessData.id != null ? dataState.thicknessData : null,
        onChanged: (value) {
          BlocProvider.of<AddBackFillingBloc>(context).add(
              AddBackFillingSelectThicknessDataEvent(thicknessData: value!));
        },
        items: dataState.thicknessList);
  }

  Widget _jointTypeDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList,
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddBackFillingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.fromJointData.id != null ? dataState.fromJointData : null,
      hint: AppString.selectFromJointNumber,
      items: dataState.jointFromList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectFromJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _toJointNumberDropDown(
      {required FetchAddBackFillingDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem:
          dataState.toJointData.id != null ? dataState.toJointData : null,
      hint: AppString.selectToJointNumber,
      items: dataState.jointToList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context)
            .add(AddBackFillingSelectToJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _chainageFromController(
      {required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(CalculateLengthEvent(
            isChainageTo: false, value: value, context: context));
      },
    );
  }

  Widget _chainageToController(
      {required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(CalculateLengthEvent(
            isChainageTo: true, value: value, context: context));
      },
    );
  }

  Widget _lengthController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.length,
      controller: dataState.lengthController,
    );
  }

  Widget _postPaddingController({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.postPadding,
      controller: dataState.postPaddingController,
    );
  }

  Widget _plasticGratingDropDown({required FetchAddBackFillingDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectPlasticGrating,
      dropdownValue: dataState.plasticGratingData.id != null
          ? dataState.plasticGratingData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddBackFillingBloc>(context).add(
            AddBackFillingSelectPlasticGratingEvent(
                plasticGratingData: value!));
      },
      items: dataState.plasticGratingList,
    );
  }

  Widget _warningMatController(
      {required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.warningMat,
      controller: dataState.warningMatController,
    );
  }

  Widget _activityRemark({required FetchAddBackFillingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddBackFillingDataState dataState}) {
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddBackFillingBloc>(context)
            .add(AddBackFillingAddImageEvent(context: context, mediaType: 1)),
        onGallery: () => BlocProvider.of<AddBackFillingBloc>(context)
            .add(AddBackFillingAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddBackFillingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddBackFillingBloc>(context)
                  .add(AddBackFillingSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
