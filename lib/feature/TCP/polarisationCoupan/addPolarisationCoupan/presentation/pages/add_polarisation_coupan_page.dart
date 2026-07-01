import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/polarisationCoupan/addPolarisationCoupan/domain/bloc/add_polarisation_coupan_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddPolarisationCoupanPage extends StatefulWidget {
  const AddPolarisationCoupanPage({super.key});

  @override
  State<AddPolarisationCoupanPage> createState() => _AddPolarisationCoupanPageState();
}

class _AddPolarisationCoupanPageState extends State<AddPolarisationCoupanPage> {
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
    BlocProvider.of<AddPolarisationCoupanBloc>(context)
        .add(AddPolarisationCoupanPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddPolarisationCoupanBloc, AddPolarisationCoupanState>(
        builder: (context, state) {
          if (state is FetchAddPolarisationCoupanState) {
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

  Widget _itemBuilder({required FetchAddPolarisationCoupanState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            if(_isVPPL  ||_isVRPL || _isBJPL)...[
              _formatNoField(),
              _verticalSpace(),
            ],
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _tlpTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _areaController(dataState: dataState),
            _verticalSpace(),
            _testStationLocationController(dataState: dataState),
            _verticalSpace(),
            _corrosionDropDown(dataState: dataState),
            _verticalSpace(),
            _distanceController(dataState: dataState),
            _verticalSpace(),
            _cableTerminationDropDown(dataState: dataState),
            _verticalSpace(),
            _pspMeasurementController(dataState: dataState),
            _verticalSpace(),
            _couponController(dataState: dataState),
            _verticalSpace(),
            _digitalController(dataState: dataState),
            _verticalSpace(),
            _modelController(dataState: dataState),
            _verticalSpace(),
            _makeController(dataState: dataState),
            _verticalSpace(),
            _dateCalibrationController(dataState: dataState),
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

  Widget _dateController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddPolarisationCoupanState dataState}) {
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
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _chainageController(
      {required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _tlpTypeDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }
  Widget _testStationLocationController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectTestLocation,
      controller: dataState.testStationLocationController,
    );
  }

  Widget _corrosionDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCorrosion,
      dropdownValue:
      dataState.corrosionValue.id != null ? dataState.corrosionValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanCorrosionEvent(corrosionValue: value!));
      },
      items: dataState.listOfCorrosion
    );
  }

  Widget _distanceController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDistance,
      controller: dataState.distanceController,
    );
  }

  Widget _cableTerminationDropDown({required FetchAddPolarisationCoupanState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectCableTermination,
      dropdownValue:
      dataState.cableTerminationValue.id != null ? dataState.cableTerminationValue : null,
      onChanged: (value) {
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanCableTerminationEvent(cableTerminationValue: value!));
      },
      items: dataState.listOfCableTermination
    );
  }

  Widget _pspMeasurementController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectPSPMeasurement,
      controller: dataState.pspMeasurementController,
    );
  }

  Widget _couponController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectCouponInstant,
      controller: dataState.couponController,
    );
  }

  Widget _digitalController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDigitalMultimete,
      controller: dataState.digitalController,
    );
  }

  Widget _modelController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectModelNo,
      controller: dataState.modelController,
    );
  }

  Widget _makeController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectMake,
      controller: dataState.makeController,
    );
  }

  Widget _dateCalibrationController({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.number,
      labelText: AppString.selectDateCalibration,
      controller: dataState.dateCalibrationController,
      onTap: (){
        BlocProvider.of<AddPolarisationCoupanBloc>(context)
            .add(AddPolarisationCoupanDateCalibrationEvent(context: context));
      },
    );
  }


  Widget _activityRemark({required FetchAddPolarisationCoupanState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddPolarisationCoupanState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddPolarisationCoupanBloc>(context).add(
            AddPolarisationCoupanAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddPolarisationCoupanBloc>(context).add(
            AddPolarisationCoupanAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddPolarisationCoupanState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddPolarisationCoupanBloc>(context)
              .add(AddPolarisationCoupanSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}


