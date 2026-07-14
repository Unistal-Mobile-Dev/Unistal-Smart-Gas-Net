import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/domain/bloc/add_lpt_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/domain/model/lpt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/searchTextFieldWidget/presentation/widgets/search_text_field.dart';


class AddLptPage extends StatefulWidget {
  const AddLptPage({super.key});

  @override
  State<AddLptPage> createState() => _AddLptPageState();
}

class _AddLptPageState extends State<AddLptPage> {
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
    BlocProvider.of<AddLptBloc>(context)
        .add(AddLptPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddLptBloc, AddLptState>(
        builder: (context, state) {
          if (state is FetchAddLptDataState) {
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

  Widget _itemBuilder({required FetchAddLptDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            if (_isVPPL || _isVRPL || _isBJPL) ...[
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
            _consumableTable(dataState: dataState),
            _verticalSpace(),
            _surfaceTempController(dataState: dataState),
            _verticalSpace(),
            _penetrantDwellTimeController(dataState: dataState),
            _verticalSpace(),
            _developerTimeController(dataState: dataState),
            _verticalSpace(),
            _acceptanceCriteriaController(dataState: dataState),
            _verticalSpace(),
            _materialTypeController(dataState: dataState),
            _verticalSpace(),
            _applicationMethodController(dataState: dataState),
            _verticalSpace(),
            _pipeThicknessDropDown(dataState: dataState),
            _verticalSpace(),
            if(_isBJPL)...[
              _sketchController(dataState: dataState),
              _verticalSpace(),
            ],
            _pipeNumberSearchController(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
          if(_isBJPL)...[
            _typeController(dataState: dataState),
            _verticalSpace(),
            _sizeController(dataState: dataState),
            _verticalSpace(),
            _observation(dataState: dataState),
          ]else...[
            _observationResultsController(dataState: dataState),
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


  Widget _dateController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddLptBloc>(context).add(AddLptSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddLptDataState dataState}) {
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
        BlocProvider.of<AddLptBloc>(context)
            .add(AddLptMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddLptDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
        hint: AppString.selectWeather,
        dropdownValue:
        dataState.weatherData.id != null ? dataState.weatherData : null,
        onChanged: (value) {
          BlocProvider.of<AddLptBloc>(context)
              .add(SelectWeatherEvent(weatherData: value!));
        },
        items: dataState.weatherList
    );
  }

  Widget _consumableTable({required FetchAddLptDataState dataState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _consumableTableHeader(),
        _verticalSpace(),
        _consumableRow(
          label: "Penetrant",
          manufacturerController: dataState.penetrantManufacturerController,
          batchNoController: dataState.penetrantBatchNoController,
        ),
        _verticalSpace(),
        _consumableRow(
          label: "Cleaner",
          manufacturerController: dataState.cleanerManufacturerController,
          batchNoController: dataState.cleanerBatchNoController,
        ),
        _verticalSpace(),
        _consumableRow(
          label: "Developer",
          manufacturerController: dataState.developerManufacturerController,
          batchNoController: dataState.developerBatchNoController,
        ),
      ],
    );
  }

  Widget _consumableTableHeader() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            AppString.description,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
           "Manufacturer",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            AppString.batchNo,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  Widget _consumableRow({
    required String label,
    required TextEditingController manufacturerController,
    required TextEditingController batchNoController,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextFieldWidget(
              isRequired: false,
              labelText: '',
              controller: manufacturerController,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextFieldWidget(
              isRequired: false,
              labelText: '',
              controller: batchNoController,
            ),
          ),
        ),
      ],
    );
  }

Widget _surfaceTempController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Surface Temperature",
      controller: dataState.surfaceTemperatureController,
    );
}

  Widget _penetrantDwellTimeController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Penetrant DwellTime",
      controller: dataState.penetrantDwellTimeController,
    );
  }
  Widget _developerTimeController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Developer Time",
      controller: dataState.developerTimeController,
    );
  }

  Widget _acceptanceCriteriaController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Acceptance Criteria",
      controller: dataState.acceptanceCriteriaController,
    );
  }

  Widget _materialTypeController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Material Type",
      controller: dataState.materialTypeController,
    );
  }

  Widget _applicationMethodController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Application Method",
      controller: dataState.applicationMethodController,
    );
  }

  Widget _pipeThicknessDropDown({required FetchAddLptDataState dataState}) {
    return DropdownWidget<ThicknessModel>(
      isRequired: true,
      hint: "Select Thickness",
      dropdownValue: dataState.pipeThicknessData.id != null
          ? dataState.pipeThicknessData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddLptBloc>(context)
            .add(AddLptSelectPipeThicknessEvent(pipeThicknessData: value!));
      },
      items: dataState.pipeThicknessList,
    );
  }

  Widget _pipeNumberSearchController({required FetchAddLptDataState dataState}) {
    return SearchTextField(
        isLoader: dataState.searchPipeLoader,
        onChange: (value) {
          BlocProvider.of<AddLptBloc>(context)
              .add(AddLptSearchPipeDataEvent(keyword: value, context: context));
        },
        onClick: (value) {
          BlocProvider.of<AddLptBloc>(context)
              .add(AddLptSelectPipeDataEvent(pipeData: value));
        },
        controller: dataState.searchPipeController,
        label: AppString.selectPipeNumber,
        list: dataState.pipeList);
  }

  Widget _jointTypeDropDown({required FetchAddLptDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
        hint: AppString.selectJointType,
        dropdownValue:
        dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
        onChanged: (value) {
          BlocProvider.of<AddLptBloc>(context).add(AddLptSelectJointTypeDataEvent(
              jointTypeData: value!, context: context));
        },
        items: dataState.jointTypeList
    );
  }

  Widget _jointNumberDropDown({required FetchAddLptDataState dataState}) {
    return DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.jointData.id != null ? dataState.jointData : null,
      hint: AppString.selectJointNumber,
      items: dataState.jointList,
      itemAsString: (jointNumberData) => jointNumberData.jointNumber.toString(),
      onChanged: (value) {
        BlocProvider.of<AddLptBloc>(context)
            .add(AddLptSelectJointDataEvent(jointNumberData: value));
      },
    );
  }

  Widget _sketchController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Description of Parts/Sketch",
      controller: dataState.sketchController,
    );
  }
  Widget _typeController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Type",
      controller: dataState.typeController,
    );
  }
  Widget _sizeController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: "Size",
      controller: dataState.sizeController,
    );
  }


  Widget _observation({required FetchAddLptDataState dataState}){
    return DottedBorderWidget(
      title: AppString.observationResult,
      children: [
        _mEILDropDown(dataState: dataState),
        _verticalSpace(),
        _cEILDropDown(dataState: dataState),
        _verticalSpace(),
        _meconeDropDown(dataState: dataState),
      ],
    );
  }

  Widget _lptStatusDropDown({required FetchAddLptDataState dataState}) {
    return DropdownWidget<LptStatusModel>(
        hint: AppString.selectLptStatus,
        dropdownValue:
        dataState.lptStatusData.id != null ? dataState.lptStatusData : null,
        onChanged: (value) {
          BlocProvider.of<AddLptBloc>(context)
              .add(AddLptSelectLptStatusDataEvent(lptStatusData: value!));
        },
        items: dataState.lptStatusList
    );
  }

  Widget _mEILDropDown({required FetchAddLptDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "MEIL",
        dropdownValue: dataState.dataMEIL.id != null ? dataState.dataMEIL : null,
        onChanged: (value) {
          BlocProvider.of<AddLptBloc>(context).add(
              SelectMEILEvent(meilData: value!,));
        },
        items: dataState.listOfMEIL
    );
  }

  Widget _cEILDropDown({required FetchAddLptDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "CEIL",
        dropdownValue: dataState.dataCEIL.id != null ? dataState.dataCEIL : null,
        onChanged: (value) {
          BlocProvider.of<AddLptBloc>(context).add(
              SelectCEILEvent(ceilVal: value!,));
        },
        items: dataState.listOfCEIL
    );
  }

  Widget _meconeDropDown({required FetchAddLptDataState dataState}) {
    return DropdownWidget<TerrainTypeModel>(
        hint: "MECON/GSPL",
        dropdownValue: dataState.dataMECON.id != null ? dataState.dataMECON : null,
        onChanged: (value) {
          BlocProvider.of<AddLptBloc>(context).add(
              SelectMECONEvent(meconeVal: value!,));
        },
        items: dataState.listOfMECON
    );
  }

  Widget _observationResultsController({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      labelText: AppString.observationResult,
      controller: dataState.observationResultsController,
    );
  }

  Widget _activityRemark({required FetchAddLptDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddLptDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddLptBloc>(context).add(
            AddLptAddImageEvent(context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddLptBloc>(context).add(
            AddLptAddImageEvent(context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddLptDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddLptBloc>(context)
              .add(AddLptSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}