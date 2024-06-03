import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/preHydrotest/addPreHydrotest/domain/bloc/add_pre_hydrotest_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddPreHydroTestPage extends StatefulWidget {
  const AddPreHydroTestPage({super.key});

  @override
  State<AddPreHydroTestPage> createState() => _AddPreHydroTestPageState();
}

class _AddPreHydroTestPageState extends State<AddPreHydroTestPage> {
  @override
  void initState() {
    BlocProvider.of<AddPreHydrotestBloc>(context)
        .add(AddPreHydrotestPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddPreHydrotestBloc, AddPreHydrotestState>(
        builder: (context, state) {
          if (state is FetchAddPreHydrotestDataState) {
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

  Widget _itemBuilder({required FetchAddPreHydrotestDataState dataState}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _verticalSpace(),
            _dateController(dataState: dataState),
            _verticalSpace(),
            _alignmentDropdown(dataState: dataState),
            _verticalSpace(),
            _weatherDropDown(dataState: dataState),
            _verticalSpace(),
            _pressureGaugeNoController(dataState: dataState),
            _verticalSpace(),
            _pressureGaugeCalibrationDateController(dataState: dataState),
            _verticalSpace(),
            _testPressureController(dataState: dataState),
            _verticalSpace(),
            _rangeController(dataState: dataState),
            _verticalSpace(),
            _pipeSizeController(dataState: dataState),
            _verticalSpace(),
            _durationController(dataState: dataState),
            _verticalSpace(),
            _timeOnController(dataState: dataState),
            _verticalSpace(),
            _timeOffController(dataState: dataState),
            _verticalSpace(),
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _chainageFromController(dataState: dataState),
            _verticalSpace(),
            _chaingeToController(dataState: dataState),
            _verticalSpace(),
            _lengthController(dataState: dataState),
            _verticalSpace(),
            _timeInHoursController(dataState: dataState),
            _verticalSpace(),
            _pressureReading1KGController(dataState: dataState),
            _verticalSpace(),
            _pressureReading2KGController(dataState: dataState),
            _verticalSpace(),
            _tempController(dataState: dataState),
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

  Widget _dateController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(AddPreHydrotestSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _alignmentDropdown(
      {required FetchAddPreHydrotestDataState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
          dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(AddPreHydrotestSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddPreHydrotestDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
          dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context)
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

  Widget _jointTypeDropDown(
      {required FetchAddPreHydrotestDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue:
          dataState.jointTypeData.id != null ? dataState.jointTypeData : null,
      onChanged: (value) {
        BlocProvider.of<AddPreHydrotestBloc>(context).add(
            AddPreHydrotestSelectJointTypeDataEvent(
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
      {required FetchAddPreHydrotestDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
            hint: AppString.selectFromJointNumber,
            dropdownValue: dataState.fromJointData.id != null
                ? dataState.fromJointData
                : null,
            onChanged: (value) {
              BlocProvider.of<AddPreHydrotestBloc>(context).add(
                  AddPreHydrotestSelectFromJointDataEvent(
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
      {required FetchAddPreHydrotestDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
            hint: AppString.selectToJointNumber,
            dropdownValue:
                dataState.toJointData.id != null ? dataState.toJointData : null,
            onChanged: (value) {
              BlocProvider.of<AddPreHydrotestBloc>(context).add(
                  AddPreHydrotestSelectToJointDataEvent(
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

  Widget _pressureGaugeNoController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.pressureGaugeNo,
      controller: dataState.pressureGaugeNoController,
    );
  }

  Widget _pressureGaugeCalibrationDateController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.pressureGaugeCalibrationDate,
      controller: dataState.pressureGaugeCalibrationDateController,
      onTap: () {
        BlocProvider.of<AddPreHydrotestBloc>(context)
            .add(AddPreHydrotestSelectPressureDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _testPressureController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.testPressure,
      controller: dataState.testPressureController,
    );
  }

  Widget _rangeController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.range,
      controller: dataState.rangeController,
    );
  }

  Widget _pipeSizeController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.pipeSize,
      controller: dataState.pipeSizeController,
    );
  }

  Widget _durationController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.duration,
      controller: dataState.durationController,
    );
  }

  Widget _timeOnController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.timeOn,
      controller: dataState.timeOnController,
    );
  }

  Widget _timeOffController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.timeOff,
      controller: dataState.timeOffController,
    );
  }

  Widget _timeInHoursController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.timeInHours,
      controller: dataState.timeInHoursController,
    );
  }

  Widget _pressureReading1KGController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.pressureReading1Kg,
      controller: dataState.pressureReading1KGController,
    );
  }

  Widget _pressureReading2KGController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.pressureReading2Kg,
      controller: dataState.pressureReading2KGController,
    );
  }

  Widget _tempController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.temp,
      controller: dataState.tempController,
    );
  }

  Widget _chainageFromController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageFrom,
      controller: dataState.chainageFromController,
    );
  }

  Widget _chaingeToController(
      {required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.chainageTo,
      controller: dataState.chainageToController,
    );
  }

  Widget _lengthController({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.number,
      labelText: AppString.sectionLength,
      controller: dataState.lengthController,
    );
  }

  Widget _activityRemark({required FetchAddPreHydrotestDataState dataState}) {
    return TextFieldWidget(
      isRequired: false,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }

  Widget _photo({required FetchAddPreHydrotestDataState dataState}) {
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
                    BlocProvider.of<AddPreHydrotestBloc>(context).add(
                        AddPreHydrotestAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddPreHydrotestBloc>(context).add(
                        AddPreHydrotestAddImageEvent(
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

  Widget _button({required FetchAddPreHydrotestDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            height:
                AppConfig.getDeviceType(context: context) == DeviceType.tablet
                    ? MediaQuery.of(context).size.height * 0.13
                    : null,
            onPressed: () {
              BlocProvider.of<AddPreHydrotestBloc>(context)
                  .add(AddPreHydrotestSubmitDataEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
