import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_source_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/bloc/add_radiography_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddRadioGraphyPage extends StatefulWidget {
  const AddRadioGraphyPage({super.key});

  @override
  State<AddRadioGraphyPage> createState() => _AddRadioGraphyPageState();
}

class _AddRadioGraphyPageState extends State<AddRadioGraphyPage> {
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
    BlocProvider.of<AddRadiographyBloc>(context)
        .add(AddRadiographyPageLoadEvent(context: context));

  }

  final client  =  AppConfig.instanceInit()!.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddRadiographyBloc, AddRadiographyState>(
        builder: (context, state) {
          if (state is FetchAddRadiographyDataState) {
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

  Widget _itemBuilder({required FetchAddRadiographyDataState dataState}) {
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
            _ndtSourceDropDown(dataState: dataState),
            _verticalSpace(),
            //  _wpdTypeDropDown(dataState: dataState),
            // _verticalSpace(),
            _filmTypeController(dataState: dataState),
            _verticalSpace(),
            _inspectTechniqueDropdown(dataState: dataState),
            _verticalSpace(),
            _equipmentController(dataState: dataState),
            _verticalSpace(),
            _sensivityController(dataState: dataState),
            _verticalSpace(),
            _densityController(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),

            /*          _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _segmentListBuilder(dataState: dataState),
            _verticalSpace(),
            _ndtAgencyDropDown(dataState: dataState),
            _verticalSpace(),
            _dSPPLDropDown(dataState: dataState),
            _verticalSpace(),
            _mECONPBGPLDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddRadiographyDataState dataState}) {
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
              BlocProvider.of<AddRadiographyBloc>(context)
                  .add(AddRadiographyMultipleSelectAlignmentEvent(
                alignmentData: selectedAlignmentDataList,
              ));
            },
          );
  }

  Widget _weatherDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<WeatherModel>(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _ndtSourceDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<NdtSourceModel>(
      isRequired: true,
      hint: _isVPPL || _isVRPL || _isURJAGATI || _isHPCL || _isHPOIL ? "Source":AppString.selectRtSource,
      dropdownValue: dataState.ndtSourceData.id != null ? dataState.ndtSourceData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectNdtSourceDataEvent(ndtSourceData: value!));
      },
      items: dataState.ndtSourceList
    );
  }

  Widget _chainageController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }

  Widget _filmTypeController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      labelText: _isVPPL || _isVRPL || _isURJAGATI || _isHPCL || _isHPOIL? "Film": AppString.filmType,
      controller: dataState.filmTypeController,
    );
  }

  /*Widget _inspectTechniqueController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.inspectionTechnique,
      controller: dataState.inspectTechniqueController,
    );
  }*/

  Widget _inspectTechniqueDropdown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: AppString.inspectionTechnique,
        dropdownValue: dataState.inspectionVal.id != null ? dataState.inspectionVal : null,
        onChanged: (value) {
          BlocProvider.of<AddRadiographyBloc>(context).add(
              AddRadiographySelectInspectionEvent(inspectionVal: value!));
        },
        items: dataState.inspectionTechniqueList
    );
  }

  Widget _sensivityController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      labelText: AppString.sensivity,
      controller: dataState.sensivityController,
    );
  }

  Widget _densityController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      labelText: AppString.density,
      controller: dataState.densityController,
    );
  }

  Widget _equipmentController({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      enabled: false,
      labelText: _isVPPL || _isVRPL || _isURJAGATI || _isHPCL || _isHPOIL? "Penetrameter":AppString.equipment,
      controller: dataState.equipmentController,
    );
  }

  Widget _jointTypeDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _jointNumberDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.jointNumberData.id != null
          ? dataState.jointNumberData
          : null,
      hint: AppString.selectJointNumber,
      items: dataState.jointNumberList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectJointNumberDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _wpdTypeDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<WPSModel>(
      hint: AppString.selectWPS,
      dropdownValue:
          dataState.wpsTypeData.id != null ? dataState.wpsTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectWPSTypeEvent(
                wpsTypeData: value!, context: context));
      },
      items: dataState.wpsTypeList
    );
  }

  Widget _segmentListBuilder({required FetchAddRadiographyDataState dataState}) {
    return ListView.builder(
        itemCount: dataState.segmentList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _listItemBuilder(
              segmentData: dataState.segmentList[index], index: index);
        });
  }

  Widget _listItemBuilder(
      {required SegmentModel segmentData, required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(
              "${segmentData.name}",
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
            TextWidget(
              " *",
              color: AppColor.red,
            ),
          ],
        ),
        _verticalSpace(),
        _radioButtonList(segmentData: segmentData, segmentIndex: index),
        TextFieldWidget(
          labelText: "${segmentData.observation}",
          controller: segmentData.observationController,
        ),
        _verticalSpace(),
        segmentData.segmentWelderList != null &&
                segmentData.segmentWelderList!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: segmentData.segmentWelderList!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, welderIndex) {

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        "${segmentData.segmentWelderList![welderIndex].name}",
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                      AppConfig.instanceInit()!.client == Client.vppl ||
                      AppConfig.instanceInit()!.client == Client.urjagati
                          || AppConfig.instanceInit()!.client == Client.vrpl
                          || AppConfig.instanceInit()!.client == Client.bjpl
                          || AppConfig.instanceInit()!.client == Client.gjpl
                          || AppConfig.instanceInit()!.client == Client.bcpl
                          || AppConfig.instanceInit()!.client == Client.jdpl
                          ? _welderMultiSelectDropDown(
                              welderData: segmentData.segmentWelderList![welderIndex].multipleWelderData ?? [],

                              welderList: segmentData
                                  .segmentWelderList![welderIndex].welderList!,
                              index: index,
                              welderIndex: welderIndex)
                          : _welderDropDown(
                              welderData: segmentData
                                  .segmentWelderList![welderIndex].welderData!,
                              welderList: segmentData
                                  .segmentWelderList![welderIndex].welderList!,
                              index: index,
                              welderIndex: welderIndex),
                      _verticalSpace(),
                    ],
                  );
                })
            : const SizedBox.shrink(),
         AppConfig.instanceInit()!.client == Client.vppl
             ? SizedBox.shrink()
             : TextFieldWidget(
          isRequired: false,
          labelText: "${segmentData.remark}",
          controller: segmentData.remarkController,
        ),
        _verticalSpace(),
        const Divider(),
      ],
    );
  }

  Widget _radioButtonList(
      {required SegmentModel segmentData, required int segmentIndex}) {
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
                  BlocProvider.of<AddRadiographyBloc>(context).add(
                      AddRadiographySelectSegmentDataEvent(
                          index: index, segmentIndex: segmentIndex));
                },
              ),
              TextWidget(
                  segmentData.segmentStatusList![index].status.toString()),
            ],
          );
        });
  }

  Widget _welderDropDown(
      {required WelderModel welderData,
      required List<WelderModel> welderList,
      required int index,
      required int welderIndex}) {
    return DropdownWidget<WelderModel>(
      hint: AppString.selectWelder,
      dropdownValue: welderData.id != null ? welderData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectWelderDataEvent(
                welderData: value!, index: index, welderIndex: welderIndex));
      },
      items: welderList
    );
  }

  Widget _welderMultiSelectDropDown(
      {required List<WelderModel> welderData,
      required List<WelderModel> welderList,
      required int index,
      required int welderIndex}) {
    return DropDownSearchMultiSelectWidget(
      hint: AppString.selectWelder,
      selectedItem: welderData,
      items: welderList,
      itemAsString: (welderData) => welderData.welderName.toString(),
      onChanged: (value) {
        List<WelderModel> selectedWelderModelList = [];
        for (var data in value) {
          selectedWelderModelList.add(data);
        }

        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographyMultipleSelectWelderDataEvent(
                welderData: selectedWelderModelList,
                index: index,
                welderIndex: welderIndex));

      },
    );
  }

  Widget _ndtAgencyDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<NdtStatusModel>(
      hint: _isVPPL || _isVRPL ? "SIEVERT" :  _isBJPL ? "MECON/GSPL" : AppString.selectNdtAgency,
      dropdownValue:
          dataState.ndtAgencyData.id != null ? dataState.ndtAgencyData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectNdtAgencyDataEvent(ndtAgencyData: value!));
      },
      items: dataState.ndtAgencyList
    );
  }

  Widget _dSPPLDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<NdtStatusModel>(
      hint: _isVPPL || _isVRPL || _isBJPL ? "MEIL" : AppString.selectDSPPL,
      dropdownValue: dataState.dSPPLAgencyData.id != null
          ? dataState.dSPPLAgencyData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context)
            .add(AddRadiographySelectDspplDataEvent(dspplData: value!));
      },
      items: dataState.dSPPLAgencyList
    );
  }

  Widget _mECONPBGPLDropDown({required FetchAddRadiographyDataState dataState}) {
    return DropdownWidget<NdtStatusModel>(
      hint: _isVPPL || _isVRPL  ? "EIL" : _isBJPL ? "CEIL"  : AppString.selectMECONPBGPL,
      dropdownValue:
      dataState.meconPbgplData.id != null ? dataState.meconPbgplData : null,
      onChanged: (value) {
        BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographySelectMeconPbgplDataEvent(meconPbgplData: value!));
      },
      items: dataState.meconPbgplList
    );
  }

  Widget _activityRemark({required FetchAddRadiographyDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddRadiographyDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () => BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographyAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>BlocProvider.of<AddRadiographyBloc>(context).add(
            AddRadiographyAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddRadiographyDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddRadiographyBloc>(context)
                  .add(AddRadiographySubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
