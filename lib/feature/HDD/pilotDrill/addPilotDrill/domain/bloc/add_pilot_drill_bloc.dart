import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/pilotDrill/addPilotDrill/helper/add_pilot_drill_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/helper/dashboard_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_pilot_drill_event.dart';
part 'add_pilot_drill_state.dart';

class AddPilotDrillBloc extends Bloc<AddPilotDrillEvent, AddPilotDrillState> {
  AddPilotDrillBloc() : super(AddPilotDrillInitial()) {
    on<AddPilotDrillPageLoadEvent>(_pageLoadEvent);
    on<AddPilotDrillSubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddPilotDrillSelectAlignmentEvent>(_selectAlignment);
    on<AddPilotDrillMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<SelectJointTypeDataEvent>(_selectJointType);
    on<SelectFromJointEvent>(_selectFromJoint);
    on<SelectToJointEvent>(_selectToJoint);
    on<AddPilotDrillStartingDateOfPilotHoleEvent>(_startingDateOfPilotHole);
    on<AddPilotDrillEndDateOfPilotHoleEvent>(_endDateOfPilotHole);
    on<AddPilotDrillSelectDateEvent>(_selectDate);
    on<AddPilotDrillAddImageEvent>(_selectFile);
  }

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController= TextEditingController();
  TextEditingController startDateOfPilotHoleController= TextEditingController();
  TextEditingController endDateOfPilotHoleController= TextEditingController();
  TextEditingController reportNumberController= TextEditingController();
  TextEditingController machineCapacityController= TextEditingController();
  TextEditingController sizeOfPilotBitSizeController= TextEditingController();
  TextEditingController lengthController= TextEditingController();
  TextEditingController rodNoController= TextEditingController();
  TextEditingController totalLengthController= TextEditingController();
  TextEditingController pitchController= TextEditingController();
  TextEditingController degreeController= TextEditingController();
  TextEditingController depthController= TextEditingController();
  TextEditingController activityRemarkController= TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<JointNumberModel> listOfFromJoint = [];
  List<JointNumberModel> listOfToJoint = [];
  List<JointTypeModel> listOfJointType = [];

  JointNumberModel fromJointValue = JointNumberModel();
  JointNumberModel toJointValue = JointNumberModel();
  JointTypeModel jointTypeDataValue = JointTypeModel();
  bool isJointNumberLoader = false;

  _pageLoadEvent(AddPilotDrillPageLoadEvent event, emit) async {
    emit(AddPilotDrillPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    startDateOfPilotHoleController.text = "";
    endDateOfPilotHoleController.text = "";
    reportNumberController.text = "";
    machineCapacityController.text = "";
    sizeOfPilotBitSizeController.text = "";
    lengthController.text = "";
    rodNoController.text = "";
    totalLengthController.text = "";
    pitchController.text = "";
    degreeController.text = "";
    depthController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    listOfJointType = [];
    listOfFromJoint = [];
    listOfToJoint = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    weatherData = WeatherModel();
    fromJointValue = JointNumberModel();
    toJointValue = JointNumberModel();
    jointTypeDataValue = JointTypeModel();
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);


    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (res != null) {
      alignmentList = res;
    }
    var resJointType = await AddWeldingHelper.fetchJointType(
        context: event.context, userData: userData);
    if (resJointType != null) {
      listOfJointType = resJointType;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddPilotDrillSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddPilotDrillMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }



  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectDate(AddPilotDrillSelectDateEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }


  _selectJointType(SelectJointTypeDataEvent event, emit) async {
    jointTypeDataValue = event.jointTypeDataValue;
    listOfFromJoint = [];
    listOfToJoint = [];
    fromJointValue = JointNumberModel();
    toJointValue = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        type: "welding");
    if (resJointNumber != null) {
      listOfFromJoint = resJointNumber;
      listOfToJoint = listOfFromJoint;
    }
    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectFromJoint(SelectFromJointEvent event, emit) {
    fromJointValue = event.fromJointValue;
    _eventComplete(emit);
  }

  _selectToJoint(SelectToJointEvent event, emit) {
    toJointValue = event.toJointValue;
    _eventComplete(emit);
  }

  _startingDateOfPilotHole(AddPilotDrillStartingDateOfPilotHoleEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      startDateOfPilotHoleController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _endDateOfPilotHole(AddPilotDrillEndDateOfPilotHoleEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      endDateOfPilotHoleController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _selectFile(AddPilotDrillAddImageEvent event, emit) async {
    if (event.mediaType == 1) {
      var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
      if (photo != null) {
        file = photo;
      }
    } else {
      var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
      if (photo != null) {
        file = photo;
      }
    }
    Navigator.pop(!event.context.mounted ? event.context : event.context);
    _eventComplete(emit);
  }

  _submitData(AddPilotDrillSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddPilotDrillHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      degree: degreeController.text.toString(),
      depth: depthController.text.trim().toString(),
      fromJointData: fromJointValue,
      hddMachine: machineCapacityController.text.trim().toString(),
      pilotSize: sizeOfPilotBitSizeController.text.trim().toString(),
      toJointData: toJointValue,
      pilotEndDate: endDateOfPilotHoleController.text.trim().toString(),
      pilotLength: lengthController.text.trim().toString(),
      pilotStartDate: startDateOfPilotHoleController.text.trim().toString(),
      pitch: pitchController.text.trim().toString(),
      rodNo: rodNoController.text.trim().toString(),
      totalPilotLength: totalLengthController.text.trim().toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      isJointNumberLoader = false;
      dateController.text = "";
      startDateOfPilotHoleController.text = "";
      endDateOfPilotHoleController.text = "";
      reportNumberController.text = "";
      machineCapacityController.text = "";
      sizeOfPilotBitSizeController.text = "";
      lengthController.text = "";
      rodNoController.text = "";
      totalLengthController.text = "";
      pitchController.text = "";
      degreeController.text = "";
      depthController.text = "";
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      weatherData = WeatherModel();
      fromJointValue = JointNumberModel();
      toJointValue = JointNumberModel();
      jointTypeDataValue = JointTypeModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddPilotDrillState> emit) {
    emit(FetchAddPilotDrillDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      fromJointValue: fromJointValue,
      listOfFromJoint: listOfFromJoint,
      listOfToJoint: listOfToJoint,
      toJointValue: toJointValue,
      dateController : dateController,
      startDateOfPilotHoleController : startDateOfPilotHoleController,
      endDateOfPilotHoleController : endDateOfPilotHoleController,
      reportNumberController : reportNumberController,
      machineCapacityController : machineCapacityController,
      sizeOfPilotBitSizeController : sizeOfPilotBitSizeController,
      lengthController : lengthController,
      rodNoController : rodNoController,
      totalLengthController : totalLengthController,
      pitchController : pitchController,
      degreeController : degreeController,
      depthController : depthController,
      activityRemarkController : activityRemarkController,
      isJointNumberLoader: isJointNumberLoader,
      jointTypeDataValue: jointTypeDataValue,
      listOfJointType: listOfJointType,
    ));
  }
}

