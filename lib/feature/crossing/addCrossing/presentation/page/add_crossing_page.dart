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
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AddCrossingPage extends StatefulWidget {
  const AddCrossingPage({super.key});

  @override
  State<AddCrossingPage> createState() => _AddCrossingPageState();
}

class _AddCrossingPageState extends State<AddCrossingPage> {
  @override
  void initState() {
    BlocProvider.of<AddCrossingBloc>(context)
        .add(AddCrossingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _dateController({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
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
    return AppConfig.instanceInit()!.client == Client.vppl
        ?  DropDownSearchMultiSelectWidget(
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
    ) :  DropDownSearchWidget(
      isRequired: true,
      selectedItem: dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      isRequired: true,
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(SelectWeatherEvent(weatherData: value));
      },
      items: dataState.weatherList
          .map<DropdownMenuItem<WeatherModel>>((WeatherModel weatherData) {
        return DropdownMenuItem<WeatherModel>(
          value: weatherData,
          child: Text(weatherData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _pipeMaterialDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeMaterial,
      dropdownValue: dataState.pipeMaterialData.id != null
          ? dataState.pipeMaterialData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectPipeMaterialDataEvent(pipeMaterialData: value));
      },
      items: dataState.pipeMaterialList
          .map<DropdownMenuItem<PipeMaterialModel>>(
              (PipeMaterialModel pipeMaterialData) {
        return DropdownMenuItem<PipeMaterialModel>(
          value: pipeMaterialData,
          child: Text(pipeMaterialData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _pipeDiaDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeDia,
      dropdownValue:
          dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectPipeDiaDataEvent(pipeDiaData: value));
      },
      items: dataState.pipeDialList
          .map<DropdownMenuItem<PipeDiaModel>>((PipeDiaModel pipeDiaData) {
        return DropdownMenuItem<PipeDiaModel>(
          value: pipeDiaData,
          child: Text(pipeDiaData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _thicknessDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeThickness,
      dropdownValue:
          dataState.thicknessData.id != null ? dataState.thicknessData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectThicknessDataEvent(thicknessData: value));
      },
      items: dataState.thicknessList.map<DropdownMenuItem<ThicknessModel>>(
          (ThicknessModel thicknessData) {
        return DropdownMenuItem<ThicknessModel>(
          value: thicknessData,
          child: Text(thicknessData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _coatingTypeDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCoatingType,
      dropdownValue: dataState.coatingTypeData.id != null
          ? dataState.coatingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectCoatingTypeDataEvent(coatingTypeData: value));
      },
      items: dataState.coatingTypeList.map<DropdownMenuItem<CoatingTypeModel>>(
          (CoatingTypeModel coatingTypeData) {
        return DropdownMenuItem<CoatingTypeModel>(
          value: coatingTypeData,
          child: Text(coatingTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _prePaddingDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPrePadding,
      dropdownValue:
          dataState.prePaddingData.id != null ? dataState.prePaddingData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectPrePaddingDataEvent(prePaddingData: value));
      },
      items: dataState.prePaddingList
          .map<DropdownMenuItem<PaddingModel>>((PaddingModel prePaddingData) {
        return DropdownMenuItem<PaddingModel>(
          value: prePaddingData,
          child: Text(prePaddingData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _postPaddingDropDown({required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPostPadding,
      dropdownValue: dataState.postPaddingData.id != null
          ? dataState.postPaddingData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectPostPaddingDataEvent(postPaddingData: value));
      },
      items: dataState.postPaddingList
          .map<DropdownMenuItem<PaddingModel>>((PaddingModel postPaddingData) {
        return DropdownMenuItem<PaddingModel>(
          value: postPaddingData,
          child: Text(postPaddingData.value.toString()),
        );
      }).toList(),
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
    return DropdownWidget(
      hint: AppString.selectVisualChecks,
      dropdownValue: dataState.visualChecksData.id != null
          ? dataState.visualChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectVisualChecksDataEvent(visualChecksData: value));
      },
      items: dataState.visualsChecksList
          .map<DropdownMenuItem<VisualChecksModel>>(
              (VisualChecksModel visualChecksData) {
        return DropdownMenuItem<VisualChecksModel>(
          value: visualChecksData,
          child: Text(visualChecksData.value.toString()),
        );
      }).toList(),
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
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectJointTypeDataEvent(
                jointTypeData: value, context: context));
      },
      items: dataState.jointTypeList.map<DropdownMenuItem<JointTypeModel>>(
          (JointTypeModel jointTypeData) {
        return DropdownMenuItem<JointTypeModel>(
          value: jointTypeData,
          child: Text(jointTypeData.name.toString()),
        );
      }).toList(),
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
    return DropdownWidget(
      isRequired: true,
      hint: AppString.selectCrossingType,
      dropdownValue: dataState.crossingTypeData.id != null
          ? dataState.crossingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context).add(
            AddCrossingSelectCrossingTypeDataEvent(crossingTypeData: value));
      },
      items: dataState.crossingTyeList.map<DropdownMenuItem<CrossingTypeModel>>(
          (CrossingTypeModel crossingTypeData) {
        return DropdownMenuItem<CrossingTypeModel>(
          value: crossingTypeData,
          child: Text(crossingTypeData.name.toString()),
        );
      }).toList(),
    );
  }

  Widget _holidayChecksDropDown(
      {required FetchAddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null
          ? dataState.holidayChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddCrossingBloc>(context)
            .add(AddCrossingSelectHolidayDataEvent(holidayChecksData: value));
      },
      items: dataState.holidayCheckList
          .map<DropdownMenuItem<HolidayChecksModel>>(
              (HolidayChecksModel holidayChecksData) {
        return DropdownMenuItem<HolidayChecksModel>(
          value: holidayChecksData,
          child: Text(holidayChecksData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _activityRemark({required FetchAddCrossingDataState dataState}) {
    return TextFieldWidget(
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddCrossingDataState dataState}) {
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
                                color: EnvironmentConfig.of(context)!.primaryTheme,
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
                    BlocProvider.of<AddCrossingBloc>(context).add(
                        AddCrossingAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddCrossingBloc>(context).add(
                        AddCrossingAddImageEvent(
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
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
