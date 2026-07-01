import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/domain/bloc/add_restoration_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/photo_upload_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddRestorationPage extends StatefulWidget {
  const AddRestorationPage({super.key});

  @override
  State<AddRestorationPage> createState() => _AddRestorationPageState();
}

class _AddRestorationPageState extends State<AddRestorationPage> {
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
    BlocProvider.of<AddRestorationBloc>(context)
        .add(AddRestorationPageLoadEvent(context: context));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddRestorationBloc, AddRestorationState>(
        builder: (context, state) {
          if (state is FetchAddRestorationDataState) {
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

  Widget _itemBuilder({required FetchAddRestorationDataState dataState}) {
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
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _postPaddingController(dataState: dataState),
            _verticalSpace(),
            _removalOfSurplusMaterialDropDown(dataState: dataState),
            _verticalSpace(),
            _replacementofTopSoilDropDown(dataState: dataState),
            _verticalSpace(),
            _reinstallationBoundaryStoneDropDown(dataState: dataState),
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

  Widget _dateController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddRestorationBloc>(context)
            .add(AddRestorationSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddRestorationDataState dataState}) {
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
        BlocProvider.of<AddRestorationBloc>(context)
            .add(AddRestorationMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddRestorationDataState dataState}) {
    return DropdownWidget<WeatherModel>(
        isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _jointTypeDropDown({required FetchAddRestorationDataState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectJointTypeDataEvent(
                jointTypeData: value!, context: context));
      },
      items: dataState.jointTypeList
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddRestorationDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointData.id != null
                ? dataState.fromJointData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddRestorationBloc>(context).add(
                  AddRestorationSelectFromJointDataEvent(
                      jointNumberData: value!));
            },
            items: dataState.jointFromList
          )
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown(
      {required FetchAddRestorationDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddRestorationBloc>(context).add(
                  AddRestorationSelectToJointDataEvent(jointNumberData: value!));
            },
            items: dataState.jointToList
          )
        : const DottedLoaderWidget();
  }

  Widget _lengthController({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.lengthMeter,
      controller: dataState.lengthController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chainageToController(
      {required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _postPaddingController(
      {required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.landType,
      controller: dataState.landTypeController,
    );
  }

  Widget _removalOfSurplusMaterialDropDown(
      {required FetchAddRestorationDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      hint: AppString.selectRemovalOfSurplusMaterialData,
      dropdownValue: dataState.removalOfSurplusMaterialData.id != null
          ? dataState.removalOfSurplusMaterialData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectRemovalOfSurplusMaterialDataEvent(
                removalOfSurplusMaterialData: value!));
      },
      items: dataState.removalOfSurplusMaterialList
    );
  }

  Widget _replacementofTopSoilDropDown(
      {required FetchAddRestorationDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      hint: AppString.selectReplacementofTopSoilData,
      dropdownValue: dataState.replacementofTopSoilData.id != null
          ? dataState.replacementofTopSoilData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectReplacementofTopSoilDataEvent(
                replacementofTopSoilData: value!));
      },
      items: dataState.replacementofTopSoilList
    );
  }

  Widget _reinstallationBoundaryStoneDropDown(
      {required FetchAddRestorationDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      hint: AppString.selectReinstallationBoundaryStonesData,
      dropdownValue: dataState.reinstallationBoundaryStonesData.id != null
          ? dataState.reinstallationBoundaryStonesData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationSelectReinstallationBoundaryStonesDataEvent(
                reinstallationBoundaryStonesData: value!));
      },
      items: dataState.replacementofTopSoilList
    );
  }

  Widget _activityRemark({required FetchAddRestorationDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }
  Widget _photo({required FetchAddRestorationDataState dataState}){
    return PhotoUploadWidget(
      file: dataState.file,
      onTap: () => MediaPickerSheet.show(
        context: context,
        onCamera: () =>  BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationAddImageEvent(
                context: context, mediaType: 1)),
        onGallery: () =>  BlocProvider.of<AddRestorationBloc>(context).add(
            AddRestorationAddImageEvent(
                context: context, mediaType: 2)),
      ),
    );
  }

  Widget _button({required FetchAddRestorationDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddRestorationBloc>(context)
                  .add(AddRestorationSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
