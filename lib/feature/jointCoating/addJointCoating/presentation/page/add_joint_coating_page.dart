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
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

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
            _pipeMaterialDropDown(dataState: dataState),
            _verticalSpace(),
            _pipeDiaDropDown(dataState: dataState),
            _verticalSpace(),
            _thicknessDropDown(dataState: dataState),
            _verticalSpace(),
            _coatingTypeDropDown(dataState: dataState),
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
            _electrometerNoController(dataState: dataState),
            _verticalSpace(),
            _batchNoController(dataState: dataState),
            _verticalSpace(),
            _peelTestDropDown(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _surfaceController(dataState: dataState),
            _verticalSpace(),
            _visualChecksDropDown(dataState: dataState),
            _verticalSpace(),
            _holidayChecksDropDown(dataState: dataState),
            _verticalSpace(),
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

  Widget _reportNumberController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _onWeldController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.onWeld,
      controller: dataState.onWeldController,
    );
  }

  Widget _alignmentDropdown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
          dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
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

  Widget _pipeMaterialDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeMaterial,
      dropdownValue: dataState.pipeMaterialData.id != null
          ? dataState.pipeMaterialData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectPipeMaterialDataEvent(
                pipeMaterialData: value));
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

  Widget _pipeDiaDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeDia,
      dropdownValue:
          dataState.pipeDiaData.id != null ? dataState.pipeDiaData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectPipeDiaDataEvent(pipeDiaData: value));
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

  Widget _thicknessDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPipeThickness,
      dropdownValue:
          dataState.thicknessData.id != null ? dataState.thicknessData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectThicknessDataEvent(thicknessData: value));
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

  Widget _coatingTypeDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectCoatingType,
      dropdownValue: dataState.coatingTypeData.id != null
          ? dataState.coatingTypeData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectCoatingTypeDataEvent(coatingTypeData: value));
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

  Widget _peelTestDropDown({required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectPeelTest,
      dropdownValue:
          dataState.peelTestData.id != null ? dataState.peelTestData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context)
            .add(AddJointCoatingSelectPeelTestDataEvent(peelTestData: value));
      },
      items: dataState.peelTestList
          .map<DropdownMenuItem<PaddingModel>>((PaddingModel peelTestData) {
        return DropdownMenuItem<PaddingModel>(
          value: peelTestData,
          child: Text(peelTestData.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _locatinController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.location,
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

  Widget _surfaceController(
      {required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.surface,
      controller: dataState.surfaceController,
    );
  }

  Widget _visualChecksDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectVisualChecks,
      dropdownValue: dataState.visualChecksData.id != null
          ? dataState.visualChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectVisualChecksDataEvent(
                visualChecksData: value));
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

  Widget _onBodyController({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
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
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectJointTypeDataEvent(
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
      {required FetchAddJointCoatingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
            hint: AppString.selectJointNumber,
            dropdownValue: dataState.fromJointData.id != null
                ? dataState.fromJointData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddJointCoatingBloc>(context).add(
                  AddJointCoatingSelectFromJointDataEvent(
                      jointNumberData: value));
            },
            items: dataState.jointFromList
                .map<DropdownMenuItem<JointNumberModel>>(
                    (JointNumberModel jointNumberData) {
              return DropdownMenuItem<JointNumberModel>(
                value: jointNumberData,
                child: Text(jointNumberData.jointNumber.toString()),
              );
            }).toList(),
          )
        : const DottedLoaderWidget();
  }

  Widget _toJointNumberDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddJointCoatingBloc>(context).add(
                  AddJointCoatingSelectToJointDataEvent(
                      jointNumberData: value));
            },
            items: dataState.jointToList
                .map<DropdownMenuItem<JointNumberModel>>(
                    (JointNumberModel jointNumberData) {
              return DropdownMenuItem<JointNumberModel>(
                value: jointNumberData,
                child: Text(jointNumberData.jointNumber.toString()),
              );
            }).toList(),
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
      labelText: AppString.batchNo,
      controller: dataState.batchNoController,
    );
  }

  Widget _holidayChecksDropDown(
      {required FetchAddJointCoatingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectHolidayChecks,
      dropdownValue: dataState.holidayChecksData.id != null
          ? dataState.holidayChecksData
          : null,
      onChanged: (value) {
        BlocProvider.of<AddJointCoatingBloc>(context).add(
            AddJointCoatingSelectHolidayDataEvent(holidayChecksData: value));
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

  Widget _activityRemark({required FetchAddJointCoatingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
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
                                ? Icon(Icons.picture_as_pdf_outlined)
                                : Icon(Icons.document_scanner_outlined),
                        TextWidget(
                          dataState.file.path.split('/').last.toString(),
                          color: AppColor.themeColor,
                          fontSize: AppFont.font_12,
                        ),
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        color: Colors.white.withOpacity(0.6),
                        child: Center(
                            child: Icon(
                          Icons.refresh,
                          color: AppColor.themeColor,
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
