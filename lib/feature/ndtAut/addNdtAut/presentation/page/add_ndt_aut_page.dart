import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/bloc/add_ndt_aut_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/aut_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_layer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';

class AddNdtAutPage extends StatefulWidget {
  const AddNdtAutPage({super.key});

  @override
  State<AddNdtAutPage> createState() => _AddNdtAutPageState();
}

class _AddNdtAutPageState extends State<AddNdtAutPage> {
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
    BlocProvider.of<AddNdtAutBloc>(context)
        .add(AddNdtAutLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddNdtAutBloc, AddNdtAutState>(
        builder: (context, state) {
          if (state is FetchAddNdtAutDataState) {
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

  Widget _itemBuilder({required FetchAddNdtAutDataState dataState}) {
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
            /*_jointTypeDropDown(dataState: dataState),
            _verticalSpace(),*/
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _autStatusDropDown(dataState: dataState),
            _verticalSpace(),
            _defectLocationController(dataState: dataState),
            _verticalSpace(),
            _defectLayerDropDown(dataState: dataState),
            _verticalSpace(),
            _defectTypeDropDown(dataState: dataState),
            _verticalSpace(),
            if(!(_isVPPL || _isVRPL))...[
              _wpdTypeDropDown(dataState: dataState),
              _verticalSpace(),
            ],
            _welderDropDown(dataState: dataState),
            _verticalSpace(),
            if(_isVPPL || _isVRPL)...[
              _ndtAgencyDropDown(dataState: dataState),
              _verticalSpace(),
              _contractorDropDown(dataState: dataState),
              _verticalSpace(),
              _pmcDropDown(dataState: dataState),
              _verticalSpace(),
            ],
            _activityRemark(dataState: dataState),
            _verticalSpace(),
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
            _verticalSpace(),
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


  Widget _reportNumberController({required FetchAddNdtAutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _dateController({required FetchAddNdtAutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddNdtAutBloc>(context).add(AddNdtAutSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _alignmentDropdown({required FetchAddNdtAutDataState dataState}) {
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
        BlocProvider.of<AddNdtAutBloc>(context)
            .add(AddNdtAutMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectJointTypeEvent(
                jointTypeModel: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _jointNumberDropDown({required FetchAddNdtAutDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectJointNumber,
            dropdownValue: dataState.jointNumberData.id != null
                ? dataState.jointNumberData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddNdtAutBloc>(context)
                  .add(AddNdtAutSelectJointNumberEvent(jointNumberData: value!));
            },
            items: dataState.jointNumberList
          )
        : const DottedLoaderWidget();
  }

  Widget _autStatusDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget<AutStatusModel>(
      hint: AppString.autStatus,
      dropdownValue:
          dataState.autStatusData.id != null ? dataState.autStatusData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context)
            .add(AddNdtAutSelectAutDataEvent(autStatusData: value!));
      },
      items: dataState.autStatusList
    );
  }

  Widget _defectLocationController(
      {required FetchAddNdtAutDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.defectLocation,
      controller: dataState.defectLocationController,
    );
  }

  Widget _defectTypeDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.selectedDefectTypeList,
      hint: AppString.defectType,
      items: dataState.defectTypeList,
      itemAsString: (defectTypeData) => defectTypeData.name.toString(),
      onChanged: (selectedItems) {
        List<DefectTypeModel> selectedDefectTypeList = [];
        for (var data in selectedItems) {
          selectedDefectTypeList.add(data);
        }
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectDefectTypeEvent(
                selectedDefectType: selectedDefectTypeList));
      },
    );
  }

  Widget _defectLayerDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropDownSearchMultiSelectWidget(
      selectedItem: dataState.selectedDefectLayerList,
      hint: AppString.defectLayer,
      items: dataState.defectLayerList,
      itemAsString: (defectLayerData) => defectLayerData.value.toString(),
      onChanged: (selectedItems) {
        List<DefectLayerModel> selectedDefectLayerList = [];
        for (var data in selectedItems) {
          selectedDefectLayerList.add(data);
        }
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectDefectLayerEvent(
                selectedDefectLayer: selectedDefectLayerList));
      },
    );
  }

  Widget _wpdTypeDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget<WPSModel>(
      hint: AppString.selectWPS,
      dropdownValue:
          dataState.wpsTypeData.id != null ? dataState.wpsTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutSelectWPSTypeEvent(wpsTypeData: value!, context: context));
      },
      items: dataState.wpsTypeList
    );
  }

  Widget _ndtAgencyDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "NDT Agency",
        dropdownValue: dataState.ndtAgencyData.id != null ? dataState.ndtAgencyData : null,
        onChanged: (value) {
          BlocProvider.of<AddNdtAutBloc>(context).add(
              SelectNDTAgencyEvent(ndtAgencyData: value!,));
        },
        items: dataState.ndtAgencyList
    );
  }

  Widget _contractorDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "Contractor",
        dropdownValue: dataState.contractorData.id != null ? dataState.contractorData : null,
        onChanged: (value) {
          BlocProvider.of<AddNdtAutBloc>(context).add(
              SelectContractorEvent(contractorData: value!,));
        },
        items: dataState.contractorList
    );
  }

  Widget _pmcDropDown({required FetchAddNdtAutDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "PMC",
        dropdownValue: dataState.pmcData.id != null ? dataState.pmcData : null,
        onChanged: (value) {
          BlocProvider.of<AddNdtAutBloc>(context).add(
              SelectPMCEvent(pmcData: value!,));
        },
        items: dataState.pmcList
    );
  }

  Widget _welderDropDown({required FetchAddNdtAutDataState dataState}) {
    return dataState.isWelderLoader == false
        ? DropDownSearchMultiSelectWidget(
            selectedItem: dataState.selectedWelderList,
            hint: AppString.defectWelder,
            items: dataState.welderList,
            itemAsString: (welderData) => welderData.welderName.toString(),
            onChanged: (selectedItems) {
              List<WelderModel> selectedWelderList = [];
              for (var data in selectedItems) {
                selectedWelderList.add(data);
              }
              BlocProvider.of<AddNdtAutBloc>(context).add(
                  AddNdtAutSelectWelderEvent(
                      selectedWelderList: selectedWelderList));
            },
          )
        : const DottedLoaderWidget();
  }

  Widget _activityRemark({required FetchAddNdtAutDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddNdtAutDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>   BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutAddImageEvent(context: context, mediaType: 1)),
        onGallery: () =>   BlocProvider.of<AddNdtAutBloc>(context).add(
            AddNdtAutAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddNdtAutDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddNdtAutBloc>(context)
                  .add(AddNdtAutSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
