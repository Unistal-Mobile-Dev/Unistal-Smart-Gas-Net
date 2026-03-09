import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
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
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddJointCoatingPage extends StatefulWidget {
  const AddJointCoatingPage({super.key});

  @override
  State<AddJointCoatingPage> createState() => _AddJointCoatingPageState();
}

class _AddJointCoatingPageState extends State<AddJointCoatingPage> {
  @override
  void initState() {
    BlocProvider.of<AddJointCoatingBloc>(context)
        .add(AddJointCoatingPageLoadEvent(context: context));
    super.initState();
  }

  final client = AppConfig.instanceInit()!.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
            _dateController(dataState: dataState),
            _verticalSpace(),
            _reportNumberController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _sleeveTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chainageToController(dataState: dataState),
            _verticalSpace(),
            _primaryAbatchController(dataState: dataState),
            _verticalSpace(),
            _primaryBbatchController(dataState: dataState),
            _verticalSpace(),
            _holidayTestNoController(dataState: dataState),
            _verticalSpace(),
            _locatinController(dataState: dataState),
            _verticalSpace(),
            _batchNoController(dataState: dataState),
            _verticalSpace(),
            _peelTestDropDown(dataState: dataState),
            _verticalSpace(),
            client != Client.vppl
                ? SizedBox.shrink()
                : _humidityMeterDetailsController(dataState: dataState),
            client != Client.vppl ? SizedBox.shrink() : _verticalSpace(),
            client != Client.vppl
                ? SizedBox.shrink()
                : _digitalPyrometerDetailsController(dataState: dataState),
            client != Client.vppl ? SizedBox.shrink() : _verticalSpace(),
            client != Client.vppl
                ? SizedBox.shrink()
                : _profileGaugeDetailsController(dataState: dataState),
            client != Client.vppl ? SizedBox.shrink() : _verticalSpace(),
/*            _pipeMaterialDropDown(dataState: dataState),
            _verticalSpace(),*/
/*            _pipeDiaDropDown(dataState: dataState),
            _verticalSpace(),*/
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _surfaceController(dataState: dataState),
            _verticalSpace(),
            _visualChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _holidayChecksDropDown(dataState: dataState),
            _verticalSpace(),
            client == Client.vppl
                ? SizedBox.shrink()
                : _thicknessDropDown(dataState: dataState),
            client == Client.vppl ? SizedBox.shrink() : _verticalSpace(),
/*            _electrometerNoController(dataState: dataState),
            _verticalSpace(),*/
            _onBodyController(dataState: dataState),
            _verticalSpace(),
            _onWeldController(dataState: dataState),
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

  Widget _dateController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
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
      labelText: AppString.onWeld,
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

  Widget _sleeveTypeDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<CoatingTypeModel>(
      isRequired: true,
      hint: AppString.sleeveType,
      dropdownValue: dataState.coatingTypeData.id != null
          ? dataState.coatingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectCoatingTypeDataEvent(coatingTypeData: value!!));
      },
      items: dataState.coatingTypeList
    );
  }

  Widget _peelTestDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<PaddingModel>(
      isRequired: true,
      hint: AppString.selectPeelTest,
      dropdownValue:
          dataState.peelTestData.id != null ? dataState.peelTestData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectPeelTestDataEvent(peelTestData: value!));
      },
      items: dataState.peelTestList
    );
  }

  Widget _locatinController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText:
          client == Client.vppl ? "Relative Humidity" : AppString.location,
      controller: dataState.locationController,
    );
  }

  Widget _holidayTestNoController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.holidayTestNo,
      controller: dataState.holidayTestNoController,
    );
  }

  Widget _primaryAbatchController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.primerABatch,
      controller: dataState.primaryAbatchController,
    );
  }

  Widget _primaryBbatchController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.primerBBatch,
      controller: dataState.primaryBbatchController,
    );
  }

  Widget _humidityMeterDetailsController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Humidity Meter Details",
      controller: dataState.humidityMeterDetailsController,
    );
  }

  Widget _digitalPyrometerDetailsController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Digital Pyrometer Details",
      controller: dataState.digitalPyrometerDetailsController,
    );
  }

  Widget _profileGaugeDetailsController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: "Profile Gauge Details",
      controller: dataState.profileGaugeDetailsController,
    );
  }

  Widget _surfaceController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.surface,
      controller: dataState.surfaceController,
    );
  }

  Widget _visualChecksDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<VisualChecksModel>(
      hint: AppString.selectVisualChecks,
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
      labelText: AppString.onBody,
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

  Widget _fromJointNumberDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
          dataState.fromJointData.id != null ? dataState.fromJointData : null,
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
                      jointNumberData: value!!));
            },
            items: dataState.jointToList
          )
        : const DottedLoaderWidget();
  }

  Widget _chainageFromController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
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

  Widget _batchNoController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: client == Client.vppl ? "Sleeve Batch No." : AppString.batchNo,
      controller: dataState.batchNoController,
    );
  }

  Widget _holidayChecksDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget<HolidayChecksModel>(
      hint: AppString.selectHolidayChecks,
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

  Widget _activityRemark({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddJointCoatingDataState dataState}) {
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
                                color:
                                    EnvironmentConfig.of(context)!.primaryTheme,
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
                          color: EnvironmentConfig.of(context)!.primaryTheme,
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
                    BlocProvider.of<AddJointCoatingBloc>(context).add(
                        AddJointCoatingAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddJointCoatingBloc>(context).add(
                        AddJointCoatingAddImageEvent(
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
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
