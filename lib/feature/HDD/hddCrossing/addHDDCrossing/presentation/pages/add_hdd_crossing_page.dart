import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddCrossing/addHDDCrossing/domain/bloc/add_hdd_crossing_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

class AddHddCrossingPage extends StatefulWidget {
  const AddHddCrossingPage({super.key});

  @override
  State<AddHddCrossingPage> createState() => _AddHddCrossingPageState();
}

class _AddHddCrossingPageState extends State<AddHddCrossingPage> {
  @override
  void initState() {
    BlocProvider.of<AddHddCrossingBloc>(context)
        .add(AddHddCrossingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<AddHddCrossingBloc, AddHddCrossingState>(
        builder: (context, state) {
          if (state is FetchAddHddCrossingDataState) {
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

  Widget _itemBuilder({required FetchAddHddCrossingDataState dataState}) {
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
            _jointTypeDropDown(dataState: dataState),
            _verticalSpace(),
            _fromJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _toJointNumberDropDown(dataState: dataState),
            _verticalSpace(),
            _hddLocationController(dataState: dataState),
            _verticalSpace(),
            _equipmentUsedController(dataState: dataState),
            _verticalSpace(),
            _equipmentCapacityController(dataState: dataState),
            _verticalSpace(),
            _dateCommencementController(dataState: dataState),
            _verticalSpace(),
            _dateCompletionController(dataState: dataState),
            _verticalSpace(),
            _datePreHydroController(dataState: dataState),
            _verticalSpace(),
            _pipeSpecificationController(dataState: dataState),
            _verticalSpace(),
            _pipeODThicknessController(dataState: dataState),
            _verticalSpace(),
            _lengthCrossingController(dataState: dataState),
            _verticalSpace(),
            _pilotBoreDetails(dataState: dataState),
            _verticalSpace(),
            _reamerSizeUsedController(dataState: dataState),
            _verticalSpace(),
            _startController(dataState: dataState),
            _verticalSpace(),
            _endController(dataState: dataState),
            _verticalSpace(),
            _roDurationController(dataState: dataState),
            _verticalSpace(),
            _loadObservedPSIController(dataState: dataState),
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

  Widget _dateController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.date,
      controller: dataState.dateController,
      onTap: () {
        BlocProvider.of<AddHddCrossingBloc>(context)
            .add(AddHddCrossingSelectDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _reportNumberController(
      {required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.reportNumber,
      controller: dataState.reportNumberController,
    );
  }

  Widget _alignmentDropdown({required FetchAddHddCrossingDataState dataState}) {
    return DropDownSearchWidget(
      selectedItem:
      dataState.alignmentData.id != null ? dataState.alignmentData : null,
      hint: AppString.selectAlignment,
      items: dataState.alignmentList,
      itemAsString: (alignmentData) => alignmentData.alignmentName.toString(),
      onChanged: (value) {
        BlocProvider.of<AddHddCrossingBloc>(context)
            .add(AddHddCrossingSelectAlignmentEvent(
          alignmentData: value,
        ));
      },
    );
  }

  Widget _weatherDropDown({required FetchAddHddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectWeather,
      dropdownValue:
      dataState.weatherData.id != null ? dataState.weatherData : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCrossingBloc>(context)
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

  Widget _jointTypeDropDown({required FetchAddHddCrossingDataState dataState}) {
    return DropdownWidget(
      hint: AppString.selectJointType,
      dropdownValue:
      dataState.jointTypeDataValue.id != null ? dataState.jointTypeDataValue : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCrossingBloc>(context).add(
            SelectJointTypeDataEvent(
                jointTypeDataValue: value, context: context));
      },
      items: dataState.listOfJointType.map<DropdownMenuItem<JointTypeModel>>(
              (JointTypeModel jointTypeData) {
            return DropdownMenuItem<JointTypeModel>(
              value: jointTypeData,
              child: Text(jointTypeData.name.toString()),
            );
          }).toList(),
    );
  }

  Widget _fromJointNumberDropDown(
      {required FetchAddHddCrossingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
      hint: AppString.selectFromJointNumber,
      dropdownValue: dataState.fromJointValue.id != null
          ? dataState.fromJointValue
          : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCrossingBloc>(context).add(
            SelectFromJointEvent(fromJointValue: value));
      },
      items: dataState.listOfFromJoint
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
      {required FetchAddHddCrossingDataState dataState}) {
    return dataState.isJointNumberLoader == false
        ? DropdownWidget(
      hint: AppString.selectToJointNumber,
      dropdownValue:
      dataState.toJointValue.id != null ? dataState.toJointValue : null,
      onChanged: (value) {
        BlocProvider.of<AddHddCrossingBloc>(context).add(
            SelectToJointEvent(toJointValue: value));
      },
      items: dataState.listOfToJoint
          .map<DropdownMenuItem<JointNumberModel>>(
              (JointNumberModel? jointNumberData) {
            return DropdownMenuItem<JointNumberModel>(
              value: jointNumberData,
              child: Text(jointNumberData!.jointNumber.toString()),
            );
          }).toList(),
    )
        : const DottedLoaderWidget();
  }
  
  Widget _hddLocationController(
      {required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectHddLocation,
      controller: dataState.hddLocationController,
    );
  }

  Widget _equipmentUsedController(
      {required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectEquipmentUsed,
      controller: dataState.equipmentUsedController,
    );
  }

  Widget _equipmentCapacityController(
      {required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectEquipmentCapacity,
      controller: dataState.equipmentCapacityController,
    );
  }

  Widget _dateCommencementController(
      {required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.text,
      labelText: AppString.selectDateCommencement,
      controller: dataState.dateCommencementController,
      onTap: () {
        BlocProvider.of<AddHddCrossingBloc>(context)
            .add(AddHddCrossingDateCommencementEvent(
          context: context,
        ));
      },
    );
  }



  Widget _dateCompletionController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectDateCompletion,
      controller: dataState.dateCompletionController,
      onTap: () {
        BlocProvider.of<AddHddCrossingBloc>(context)
            .add(AddHddCrossingDateCompletionEvent(
          context: context,
        ));
      },
    );
  }

  Widget _datePreHydroController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      labelText: AppString.selectDatePreHydro,
      controller: dataState.datePreHydroController,
      onTap: () {
        BlocProvider.of<AddHddCrossingBloc>(context)
            .add(AddHddCrossingDatePreHydroEvent(
          context: context,
        ));
      },
    );
  }

  Widget _pipeSpecificationController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPipeSpecification,
      controller: dataState.pipeSpecificationController,
    );
  }

  Widget _pipeODThicknessController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectPipeODThickness,
      controller: dataState.pipeODThicknessController,
    );
  }

  Widget _lengthCrossingController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      labelText: AppString.selectLengthCrossing,
      controller: dataState.lengthCrossingController,
    );
  }


  Widget _pilotBoreDetails({required FetchAddHddCrossingDataState dataState}){
    return DottedBorder(
      child: Padding(
        padding: const EdgeInsets.all( 5.0),
        child: Column(
          children: [
            const Text("Pilot Bore Details"),
            _verticalSpace(),
            _pilotBoreDateCommencementController(dataState: dataState),
            _verticalSpace(),
            _pilotBoreStartTimeController(dataState: dataState),
            _verticalSpace(),
            _pilotBoreDateCompletionController(dataState: dataState),
            _verticalSpace(),
            _pilotBoreCompletedTimeController(dataState: dataState),
            _verticalSpace(),
            _pilotBoreDiameterController(dataState: dataState),
            _verticalSpace(),
            _pilotBoreDurationController(dataState: dataState),

          ],
        ),
      ),
    );
  }
  Widget _pilotBoreDateCommencementController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.text,
      labelText: AppString.selectDateCommencement,
      controller: dataState.pilotBoreDateCommencementController,
      onTap: () {
        BlocProvider.of<AddHddCrossingBloc>(context)
            .add(AddHddCrossingPilotBoreCommencementDateEvent(
          context: context,
        ));
      },
    );
  }

  Widget _pilotBoreStartTimeController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectBoreStartTime,
      controller: dataState.pilotBoreStartTimeController,
    );
  }

  Widget _pilotBoreDateCompletionController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      enabled: false,
      textInputType: TextInputType.text,
      labelText: AppString.selectDateCompletion,
      controller: dataState.pilotBoreDateCompletionController,
      onTap: () {
        BlocProvider.of<AddHddCrossingBloc>(context)
            .add(AddHddCrossingPilotBoreDateCompletionEvent(
          context: context,
        ));
      },
    );
  }

  Widget _pilotBoreCompletedTimeController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectPilotBoreCompleted,
      controller: dataState.pilotBoreCompletedTimeController,
    );
  }

  Widget _pilotBoreDiameterController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectPilotBoreDiameter,
      controller: dataState.pilotBoreDiameterController,
    );
  }

  Widget _pilotBoreDurationController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectDuration,
      controller: dataState.pilotBoreDurationController,
    );
  }


  Widget _reamerSizeUsedController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectReamerSizeUsed,
      controller: dataState.reamerSizeUsedController,
    );
  }

  Widget _startController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectStart,
      controller: dataState.startController,
    );
  }

  Widget _endController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectEnd,
      controller: dataState.endController,
    );
  }

  Widget _roDurationController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectDuration,
      controller: dataState.roDurationController,
    );
  }

  Widget _loadObservedPSIController({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      textInputType: TextInputType.text,
      labelText: AppString.selectLoadObservedPSI,
      controller: dataState.loadObservedPSIController,
    );
  }

  Widget _activityRemark({required FetchAddHddCrossingDataState dataState}) {
    return TextFieldWidget(
      isRequired: true,
      maxLine: 3,
      labelText: AppString.activityRemark,
      controller: dataState.activityRemarkController,
    );
  }


  Widget _photo({required FetchAddHddCrossingDataState dataState}) {
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
                    color: AppColor.themeColor,
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
                    BlocProvider.of<AddHddCrossingBloc>(context).add(
                        AddHddCrossingAddImageEvent(
                            context: context, mediaType: 1));
                  },
                  child: TextWidget(
                    "Camera",
                    fontSize: AppFont.font_16,
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddHddCrossingBloc>(context).add(
                        AddHddCrossingAddImageEvent(
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

  Widget _button({required FetchAddHddCrossingDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        height:
        AppConfig.getDeviceType(context: context) == DeviceType.tablet
            ? MediaQuery.of(context).size.height * 0.13
            : null,
        onPressed: () {
          BlocProvider.of<AddHddCrossingBloc>(context)
              .add(AddHddCrossingSubmitDataEvent(context: context));
        })
        : const DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

