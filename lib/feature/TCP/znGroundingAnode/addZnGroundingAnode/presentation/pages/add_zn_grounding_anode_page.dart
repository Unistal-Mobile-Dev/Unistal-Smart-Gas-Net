import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/znGroundingAnode/addZnGroundingAnode/domain/bloc/add_zn_grounding_anode_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/presentation/widget/dotted_border_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dropdown_multiselection_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddZnGroundingAnodePage extends StatefulWidget {
  const AddZnGroundingAnodePage({super.key});

  @override
  State<AddZnGroundingAnodePage> createState() => _AddZnGroundingAnodePageState();
}

class _AddZnGroundingAnodePageState extends State<AddZnGroundingAnodePage> {
  @override
  void initState() {
    BlocProvider.of<AddZnGroundingAnodeBloc>(context)
        .add(AddZnGroundingAnodePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddZnGroundingAnodeBloc, AddZnGroundingAnodeState>(
        builder: (context, state) {
          if (state is FetchAddZnGroundingAnodeState) {
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

  Widget _itemBuilder({required FetchAddZnGroundingAnodeState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageController(dataState: dataState),
            _verticalSpace(),
            _areaController(dataState: dataState),
            _verticalSpace(),
            _tlpTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _jointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _typeAnodeDropDown(dataState: dataState),
            _verticalSpace(),
            _anodeWeightController(dataState: dataState),
            _verticalSpace(),
            _anodeLocationController(dataState: dataState),
            _verticalSpace(),
            _depthAugerController(dataState: dataState),
            _verticalSpace(),
            _anodeConditionController(dataState: dataState),
            _verticalSpace(),
            _distanceController(dataState: dataState),
            _verticalSpace(),
            _noAnodesController(dataState: dataState),
            _verticalSpace(),
            _length(dataState: dataState),
            _verticalSpace(),
            _earthingController(dataState: dataState),
            _verticalSpace(),
            _acPspBeforeController(dataState: dataState),
            _verticalSpace(),
            _anodeOpen(dataState: dataState),
            _verticalSpace(),
            _acPspAfterController(dataState: dataState),
            _verticalSpace(),
            _dcPspAfterController(dataState: dataState),
            _verticalSpace(),
            _dcPspBeforeController(dataState: dataState),
            _verticalSpace(),
            _acCurrentAfterController(dataState: dataState),
            _verticalSpace(),
            _installationTypeController(dataState: dataState),
            _verticalSpace(),
            _checkWaterFillingController(dataState: dataState),
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

  Widget _dateController({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: true,
      readOnly: true,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddZnGroundingAnodeBloc>(context)
            .add(AddZnGroundingAnodeSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddZnGroundingAnodeState dataState}) {
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
        BlocProvider.of<AddZnGroundingAnodeBloc>(context)
            .add(AddZnGroundingAnodeMultipleSelectAlignmentEvent(
          alignmentData: selectedAlignmentDataList,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddZnGroundingAnodeState dataState}) {
    return DropdownWidget<WeatherModel>(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddZnGroundingAnodeBloc>(context)
            .add(SelectWeatherEvent(weatherData: value!));
      },
      items: dataState.weatherList
    );
  }

  Widget _chainageController({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainage,
      controller: dataState.chainageController,
    );
  }
  Widget _tlpTypeDropDown({required FetchAddZnGroundingAnodeState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTLPType,
      dropdownValue:
      dataState.tlpTypeValue.id != null ? dataState.tlpTypeValue : null,
      onChanged: (value) {
        BlocProvider.of<AddZnGroundingAnodeBloc>(context)
            .add(AddTestStationBoxTLPTypeEvent(tlpTypeValue: value!));
      },
      items: dataState.listOfTLPType
    );
  }


  Widget _areaController({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectArea,
      controller: dataState.areaController,
    );
  }
  
  Widget _jointTypeDropDown({required FetchAddZnGroundingAnodeState dataState}) {
    return DropdownWidget<JointTypeModel>(
      hint: AppString.selectJointType,
      dropdownValue:
      dataState.jointTypeDataValue.id != null ? dataState.jointTypeDataValue : null,
      onChanged: (value) {
        BlocProvider.of<AddZnGroundingAnodeBloc>(context).add(
            SelectJointTypeDataEvent(
                jointTypeDataValue: value!, context: context));
      },
      items: dataState.listOfJointType
    );
  }

  Widget _jointNumberDropDown(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget<JointNumberModel>(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.jointValue.id != null
          ? dataState.jointValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddZnGroundingAnodeBloc>(context).add(
            SelectJointEvent(jointValue: value!));
      },
      items: dataState.listOfJoint
    )
        : const DottedLoaderWidget();
  }

  Widget _typeAnodeDropDown(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return DropdownWidget<TlpTypeModel>(
      hint: AppString.selectTypeAnode,
      dropdownValue: dataState.typeNodeValue.id != null
          ? dataState.typeNodeValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddZnGroundingAnodeBloc>(context).add(
            AddTestStationBoxSacrificialAnodeTypeEvent(typeNodeValue: value!));
      },
      items: dataState.listOfSacrificialAnode
    );
  }

  Widget _anodeWeightController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectAnodeWeight,
      controller: dataState.anodeWeightController,
    );
  }

  Widget _anodeLocationController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectAnodeLocation,
      controller: dataState.anodeLocationController,
    );
  }

  Widget _depthAugerController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectDepth,
      controller: dataState.depthAugerController,
    );
  }

  Widget _anodeConditionController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectAnodeCondition,
      controller: dataState.anodeConditionController,
    );
  }

  Widget _distanceController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectDistance,
      controller: dataState.distanceController,
    );
  }

  Widget _noAnodesController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectNoAnode,
      controller: dataState.noAnodesController,
    );
  }

  Widget _length({required FetchAddZnGroundingAnodeState dataState}){
    return DottedBorderWidget(
      title: "Length and size of the Cable laying",
      children: [
        _a1LengthController(dataState: dataState),
        _verticalSpace(),
        _a2LengthController(dataState: dataState),
        _verticalSpace(),
        _a3LengthController(dataState: dataState),
      ],
    );
  }

  Widget _anodeOpen({required FetchAddZnGroundingAnodeState dataState}){
    return DottedBorderWidget(
      title: "Anode Open Circuit Potential w.r.t Cu-CuSO4 Ref. Cell (-V)",
      children: [
        _a1AnodeController(dataState: dataState),
        _verticalSpace(),
        _a2AnodeController(dataState: dataState),
        _verticalSpace(),
        _a3AnodeController(dataState: dataState),
        _verticalSpace(),
        _a4AnodeController(dataState: dataState),
      ],
    );
  }

  Widget _a1LengthController({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA1,
      controller: dataState.a1LengthController,
    );
  }

  Widget _a2LengthController({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA2,
      controller: dataState.a2LengthController,
    );
  }

  Widget _a3LengthController({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA3,
      controller: dataState.a3LengthController,
    );
  }

  Widget _earthingController({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectEarthingResistance,
      controller: dataState.earthingController,
    );
  }

  Widget _acPspBeforeController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectACPSPBefore,
      controller: dataState.acPspBeforeController,
    );
  }

  Widget _a1AnodeController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA1,
      controller: dataState.a1AnodeController,
    );
  }

  Widget _a2AnodeController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA2,
      controller: dataState.a2AnodeController,
    );
  }

  Widget _a3AnodeController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA3,
      controller: dataState.a3AnodeController,
    );
  }

  Widget _a4AnodeController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.selectA4,
      controller: dataState.a4AnodeController,
    );
  }

  Widget _acPspAfterController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectACPSPAfter,
      controller: dataState.acPspAfterController,
    );
  }

  Widget _dcPspAfterController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectDCPSPAfter,
      controller: dataState.dcPspAfterController,
    );
  }

  Widget _dcPspBeforeController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectDCPSPBefore,
      controller: dataState.dcPspBeforeController,
    );
  }

  Widget _acCurrentAfterController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectDCPSPAfter,
      controller: dataState.acCurrentAfterController,
    );
  }

  Widget _installationTypeController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectInstallationType,
      controller: dataState.installationTypeController,
    );
  }

  Widget _checkWaterFillingController(
      {required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectCheckWater,
      controller: dataState.checkWaterFillingController,
    );
  }


  Widget _activityRemark({required FetchAddZnGroundingAnodeState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddZnGroundingAnodeState dataState}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      child: InkWell(
        onTap: () {
          mediaType(context: context);
        },
        child: DottedBorder(
          color: AppColor.grey,
          strokeWidth: 1,
          child: dataState.file.path.isEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(Icons.photo_camera_back_outlined),
              ),
              Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.02),
                child: TextWidget(
                  "Photo",
                  fontSize: AppFont.font_12,
                  color: AppColor.grey,
                ),
              ),
            ],
          )
              : Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dataState.file.path
                      .toString()
                      .toLowerCase()
                      .contains(".jpg") ||
                      dataState.file.path
                          .toString()
                          .toLowerCase()
                          .contains(".png") ||
                      dataState.file.path
                          .toString()
                          .toLowerCase()
                          .contains(".jpeg")
                      ? Image.file(
                    dataState.file,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 4.5,
                  )
                      : dataState.file.path
                      .toString()
                      .toLowerCase()
                      .contains(".pdf")
                      ? const Icon(Icons.picture_as_pdf_outlined)
                      : const Icon(Icons.document_scanner_outlined),
                  dataState.file.path
                      .toString()
                      .toLowerCase()
                      .contains(".pdf")
                      ? TextWidget(
                    dataState.file.path.split('/').last.toString(),
                    color:  EnvironmentConfig.of(context)!.primaryTheme,
                    fontSize: AppFont.font_12,
                  )
                      : const SizedBox.shrink(),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  color: Colors.white.withOpacity(0.6),
                  child: Center(
                      child: Icon(
                        Icons.refresh,
                        color:  EnvironmentConfig.of(context)!.primaryTheme,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void mediaType({required BuildContext context}) {
    showModalBottomSheet(
      context: context, // Also default
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddZnGroundingAnodeBloc>(context).add(
                        AddZnGroundingAnodeAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddZnGroundingAnodeBloc>(context).add(
                        AddZnGroundingAnodeAddImageEvent(
                            context: context, mediaType: 2));
                  },
                  child: TextWidget(
                    "Gallery",
                    fontSize: AppFont.font_16,
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required FetchAddZnGroundingAnodeState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddZnGroundingAnodeBloc>(context)
              .add(AddZnGroundingAnodeSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}


