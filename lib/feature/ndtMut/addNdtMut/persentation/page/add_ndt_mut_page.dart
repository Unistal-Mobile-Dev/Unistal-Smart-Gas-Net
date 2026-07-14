import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/bloc/add_ndt_mut_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddNdtMutPage extends StatefulWidget {
  const AddNdtMutPage({super.key});

  @override
  State<AddNdtMutPage> createState() => _AddNdtMutPageState();
}

class _AddNdtMutPageState extends State<AddNdtMutPage> {
  late final Client _client;

  bool get _isVPPL => _client == Client.vppl;
  bool get _isVRPL => _client == Client.vrpl;
  bool get _isBJPL => _client == Client.bjpl;
  bool get _isHPCL => _client == Client.hpcl;
  bool get _isHPOIL => _client == Client.hpoil;
  bool get _isGJPL => _client == Client.gjpl;
  bool get _isURJAGATI => _client == Client.urjagati;
  bool get _isMGL => _client == Client.mgl;
  bool get _isAllClient => _isVPPL || _isURJAGATI || _isGJPL;

  @override
  void initState() {
    super.initState();
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<AddNdtMutBloc>(context)
        .add(AddNdtMutPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddNdtMutBloc, AddNdtMutState>(
        builder: (context, state) {
          if (state is FetchAddNdtMutDataState) {
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

  Widget _itemBuilder({required FetchAddNdtMutDataState dataState}) {
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
            if(_isBJPL)...[
              _ufdModelController(dataState: dataState),
              _verticalSpace(),
              _materialGradeDropDown(dataState: dataState),
              _verticalSpace(),
              _typeOfFlawDetectorController(dataState: dataState),
              _verticalSpace(),
              _referenceBlockController(dataState: dataState),
              _verticalSpace(),
              _scanningDbController(dataState: dataState),
              _verticalSpace(),
              _dimensionTransducerController(dataState: dataState),
              _verticalSpace(),
              _referenceDbController(dataState: dataState),
              _verticalSpace(),
              _transducerFrequencyController(dataState: dataState),
              _verticalSpace(),
              _referenceStandardController(dataState: dataState),
              _verticalSpace(),
              _couplantController(dataState: dataState),
              _verticalSpace(),
              _surfaceConditionController(dataState: dataState),
              _verticalSpace(),
              _calibratedRangeController(dataState: dataState),
              _verticalSpace(),
              _extentExaminationController(dataState: dataState),
              _verticalSpace(),
              _jointTemperatureController(dataState: dataState),
              _verticalSpace(),
              _pipeDiaController(dataState: dataState),
              _verticalSpace(),
              _pipeThicknessController(dataState: dataState),
              _verticalSpace(),
              _acceptanceCriteriaDropDown(dataState: dataState),
              _verticalSpace(),
            ]else...[
              _angleOfRayInputController(dataState: dataState),
              _verticalSpace(),
              _operatingFrequencyController(dataState: dataState),
              _verticalSpace(),
              _leveOfInspectionController(dataState: dataState),
              _verticalSpace(),
            ],
            _pipeNumberSearchController(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            if(_isBJPL)...[
              _segmentController(dataState: dataState),
              _verticalSpace(),
              _observationController(dataState: dataState),
              _verticalSpace(),
              _accRejController(dataState: dataState),
              _verticalSpace(),
            ]else...[
              _locationDiscoverDefectController(dataState: dataState),
              _verticalSpace(),
              _ndtAgencyDropDown(dataState: dataState),
              _verticalSpace(),
              _dSPPLDropDown(dataState: dataState),
              _verticalSpace(),
              _mECONPBGPLDropDown(dataState: dataState),
            ],
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

  Widget _dateController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddNdtMutBloc>(context).add(AddNdtMutSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddNdtMutDataState dataState}) {
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
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }
  Widget _typeOfFlawDetectorController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: _isBJPL ?  "Calibration Block" : AppString.typeOfFlawDetector,
      controller: dataState.typeOfFlawDetectorController,
    );
  }

  Widget _ufdModelController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "UFD Model & Sr. No.",
      controller: dataState.ufdModelController,
    );
  }



  Widget _referenceBlockController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Reference Block",
      controller: dataState.calibrationBlockController,
    );
  }

  Widget _scanningDbController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Scanning Db",
      controller: dataState.scanningDbController,
    );
  }

  Widget _dimensionTransducerController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Type & Dimension of Transducer",
      controller: dataState.dimensionTransducerController,
    );
  }

  Widget _referenceDbController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Reference Db",
      controller: dataState.referenceDbController,
    );
  }

  Widget _transducerFrequencyController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Transducer angle & Frequency",
      controller: dataState.transducerFrequencyController,
    );
  }

  Widget _referenceStandardController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Reference Standard",
      controller: dataState.referenceStandardController,
    );
  }
  Widget _couplantController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Couplant",
      controller: dataState.couplantController,
    );
  }
  Widget _surfaceConditionController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Surface Condition",
      controller: dataState.surfaceConditionController,
    );
  }
  Widget _calibratedRangeController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Calibrated Range",
      controller: dataState.calibratedRangeController,
    );
  }
  Widget _jointTemperatureController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Joint Temperature",
      controller: dataState.jointTemperatureController,
    );
  }
  Widget _pipeDiaController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Pipe Dia",
      controller: dataState.pipeDiaController,
    );
  }
  Widget _pipeThicknessController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Pipe Thickness",
      controller: dataState.pipeThicknessController,
    );
  }

  Widget _segmentController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Segment",
      controller: dataState.segmentController,
    );
  }
  Widget _observationController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Location Of Discovered Defects",
      controller: dataState.observationController,
    );
  }
  Widget _accRejController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "ACC/Rej",
      controller: dataState.accRejController,
    );
  }

  Widget _materialGradeDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Material Grade",
        dropdownValue: dataState.materialGradeValue.id != null
            ? dataState.materialGradeValue
            : null,
        onChanged: (value) {
          BlocProvider.of<AddNdtMutBloc>(context)
              .add(SelectMaterialGradeEvent(materialGradeValue: value!));
        },
        items: dataState.listOfMaterialGrade);
  }

  Widget _extentExaminationController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      labelText: "Extent of Examination",
      controller: dataState.extentExaminationController,
    );
  }


  Widget _acceptanceCriteriaDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Acceptance Criteria",
        dropdownValue: dataState.acceptanceCriteriaValue.id != null
            ? dataState.acceptanceCriteriaValue
            : null,
        onChanged: (value) {
          BlocProvider.of<AddNdtMutBloc>(context)
              .add(SelectAcceptanceCriteriaEvent(acceptanceCriteriaValue: value!));
        },
        items: dataState.listOfAcceptanceCriteria);
  }


  Widget _angleOfRayInputController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.angleOfRayInput,
      controller: dataState.angleOfRayInputController,
    );
  }

  Widget _operatingFrequencyController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.operatingFrequency,
      controller: dataState.operatingFrequencyController,
    );
  }

  Widget _leveOfInspectionController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.levelOfInspection,
      controller: dataState.leveOfInspectionController,
    );
  }

  Widget _pipeNumberSearchController({required FetchAddNdtMutDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddNdtMutBloc>(context).add(
              AddNdtMutSearchPipeDataEvent(keyword: value, context: context));
        },
        onClick: (value) {
          BlocProvider.of<AddNdtMutBloc>(context)
              .add(AddNdtMutSelectPipeDataEvent(pipeData: value));
        },
        controller: dataState.searchPipeController,
        label: AppString.selectPipeNumber,
        list: dataState.pipeList);
  }

  Widget _jointTypeDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context).add(
            AddNdtMutSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _jointNumberDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.jointNumberData.id != null
          ? dataState.jointNumberData
          : null,
      hint: AppString.selectJointNumber,
      items: dataState.jointNumberList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectJointNumberDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _segmentListBuilder({required FetchAddNdtMutDataState dataState}) {
    return ListView.builder(
        itemCount: dataState.segmentList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _listItemBuilder(
              segmentData: dataState.segmentList[index], index: index);
        });
  }

  Widget _listItemBuilder({required SegmentModel segmentData, required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(
          "${segmentData.name}*",
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        _verticalSpace(),
        _radioButtonList(segmentData: segmentData, segmentIndex: index),
        TextFieldWidget(
          isRequired: true,
          labelText: "${segmentData.observation}",
          controller: segmentData.observationController,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        TextFieldWidget(
          isRequired: false,
          labelText: "${segmentData.remark}",
          controller: segmentData.remarkController,
        ),
        _verticalSpace(),
        const Divider(),
      ],
    );
  }

  Widget _radioButtonList({required SegmentModel segmentData, required int segmentIndex}) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: segmentData.segmentStatusList!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Radio(
                value:
                    segmentData.segmentStatusList![index].groupType.toString(),
                groupValue: segmentData.segmentStatusList![index].selectedValue
                    .toString(),
                onChanged: (val) {
                  BlocProvider.of<AddNdtMutBloc>(context).add(
                      AddNdtMutSelectSegmentDataEvent(
                          index: index, segmentIndex: segmentIndex));
                },
              ),
              TextWidget(
                  segmentData.segmentStatusList![index].status.toString()),
            ],
          );
        });
  }

  Widget _activityRemark({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _locationDiscoverDefectController({required FetchAddNdtMutDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: AppString.locationOfDiscoveredDefect,
      controller: dataState.locationDiscoverDefectController,
    );
  }

  Widget _ndtAgencyDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget<NdtStatusModel>(
      hint: _isVPPL || _isVRPL ? "SIEVERT" :  AppString.selectNdtAgency,
      dropdownValue:
          dataState.ndtAgencyData.id != null ? dataState.ndtAgencyData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectNdtAgencyDataEvent(ndtAgencyData: value!));
      },
      items: dataState.ndtAgencyList
    );
  }

  Widget _dSPPLDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget<NdtStatusModel>(
      hint: _isVPPL || _isVRPL ? "MEIL" : _isURJAGATI || _isGJPL ? "AIPL" : _isHPCL  || _isHPOIL ? "Contractor": AppString.selectDSPPL,
      dropdownValue: dataState.dSPPLAgencyData.id != null
          ? dataState.dSPPLAgencyData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectDspplDataEvent(dspplData: value!));
      },
      items: dataState.dSPPLAgencyList
    );
  }

  Widget _mECONPBGPLDropDown({required FetchAddNdtMutDataState dataState}) {
    return DropdownWidget<NdtStatusModel>(
      hint:  _isVPPL || _isVRPL ? "EIL" :_isURJAGATI|| _isGJPL ? "TEPL" : _isHPCL || _isHPOIL ? "PMC/TPIA" : AppString.selectMECONPBGPL,
      dropdownValue:
          dataState.meconPbgplData.id != null ? dataState.meconPbgplData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtMutBloc>(context)
            .add(AddNdtMutSelectMeconPbgplDataEvent(meconPbgplData: value!));
      },
      items: dataState.meconPbgplList
    );
  }
  Widget _photo({required FetchAddNdtMutDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddNdtMutBloc>(context).add(
            AddNdtMutAddImageEvent(context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddNdtMutBloc>(context).add(
            AddNdtMutAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddNdtMutDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddNdtMutBloc>(context)
                  .add(AddNdtMutSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
