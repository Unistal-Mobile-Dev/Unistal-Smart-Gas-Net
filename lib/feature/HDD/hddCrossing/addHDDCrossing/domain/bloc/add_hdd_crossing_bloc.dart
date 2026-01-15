import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddCrossing/addHDDCrossing/helper/add_hdd_crossing_helper.dart';
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

part 'add_hdd_crossing_event.dart';
part 'add_hdd_crossing_state.dart';

class AddHddCrossingBloc extends Bloc<AddHddCrossingEvent, AddHddCrossingState> {
  AddHddCrossingBloc() : super(AddHddCrossingInitial()) {
    on<AddHddCrossingPageLoadEvent>(_pageLoadEvent);
    on<AddHddCrossingSubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddHddCrossingSelectAlignmentEvent>(_selectAlignment);
    on<SelectJointTypeDataEvent>(_selectJointType);
    on<SelectFromJointEvent>(_selectFromJoint);
    on<SelectToJointEvent>(_selectToJoint);
    on<AddHddCrossingDateCommencementEvent>(_dateCommencement);
    on<AddHddCrossingDateCompletionEvent>(_dateCompletion);
    on<AddHddCrossingDatePreHydroEvent>(_datePreHydro);
    on<AddHddCrossingPilotBoreCommencementDateEvent>(_pilotBoreDateCommencement);
    on<AddHddCrossingPilotBoreDateCompletionEvent>(_pilotBoreDateCompletion);
    on<AddHddCrossingSelectDateEvent>(_selectDate);
    on<AddHddCrossingAddImageEvent>(_selectFile);
  }

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();

  TextEditingController dateController= TextEditingController();
  TextEditingController dateCommencementController= TextEditingController();
  TextEditingController dateCompletionController= TextEditingController();
  TextEditingController reportNumberController= TextEditingController();
  TextEditingController activityRemarkController= TextEditingController();
  TextEditingController datePreHydroController= TextEditingController();
  TextEditingController equipmentCapacityController= TextEditingController();
  TextEditingController equipmentUsedController= TextEditingController();
  TextEditingController hddLocationController= TextEditingController();
  TextEditingController lengthCrossingController= TextEditingController();
  TextEditingController pipeODThicknessController= TextEditingController();
  TextEditingController pipeSpecificationController= TextEditingController();
  TextEditingController pilotBoreDateCommencementController= TextEditingController();
  TextEditingController pilotBoreStartTimeController= TextEditingController();
  TextEditingController pilotBoreDateCompletionController= TextEditingController();
  TextEditingController pilotBoreCompletedTimeController= TextEditingController();
  TextEditingController pilotBoreDiameterController= TextEditingController();
  TextEditingController pilotBoreDurationController= TextEditingController();
  TextEditingController reamerSizeUsedController= TextEditingController();
  TextEditingController startController= TextEditingController();
  TextEditingController endController= TextEditingController();
  TextEditingController roDurationController= TextEditingController();
  TextEditingController loadObservedPSIController= TextEditingController();

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

  _pageLoadEvent(AddHddCrossingPageLoadEvent event, emit) async {
    emit(AddHddCrossingPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    dateCommencementController.text = "";
    dateCompletionController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    datePreHydroController.text = "";
    equipmentCapacityController.text = "";
    equipmentUsedController.text = "";
    hddLocationController.text = "";
    lengthCrossingController.text = "";
    pipeODThicknessController.text = "";
    pipeSpecificationController.text = "";
    pilotBoreDateCommencementController.text = "";
    pilotBoreStartTimeController.text = "";
    pilotBoreDateCompletionController.text = "";
    pilotBoreCompletedTimeController.text = "";
    pilotBoreDiameterController.text = "";
    pilotBoreDurationController.text = "";
    reamerSizeUsedController.text = "";
    startController.text = "";
    endController.text = "";
    roDurationController.text = "";
    loadObservedPSIController.text = "";
    alignmentList = [];
    listOfFromJoint = [];
    listOfToJoint = [];
    listOfJointType = [];
    fromJointValue = JointNumberModel();
    toJointValue = JointNumberModel();
    jointTypeDataValue = JointTypeModel();
    alignmentData = AlignmentModel();
    weatherData = WeatherModel();
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);
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

  _selectAlignment(AddHddCrossingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectDate(AddHddCrossingSelectDateEvent event, emit) async {
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

  _dateCompletion(AddHddCrossingDateCompletionEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateCompletionController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _dateCommencement(AddHddCrossingDateCommencementEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateCommencementController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _datePreHydro(AddHddCrossingDatePreHydroEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      datePreHydroController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _pilotBoreDateCommencement(AddHddCrossingPilotBoreCommencementDateEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      pilotBoreDateCommencementController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _pilotBoreDateCompletion(AddHddCrossingPilotBoreDateCompletionEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      pilotBoreDateCompletionController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _selectFile(AddHddCrossingAddImageEvent event, emit) async {
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

  _submitData(AddHddCrossingSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddHddCrossingHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      fromJointData: fromJointValue,
      reamerSize: reamerSizeUsedController.text.trim().toString(),
      commencementDate: dateCommencementController.text.trim().toString(),
      completionDate: dateCompletionController.text.trim().toString(),
      crossingLength: lengthCrossingController.text.trim().toString(),
      equipmentCapacit: equipmentCapacityController.text.trim().toString(),
      equipmentUsed: equipmentUsedController.text.trim().toString(),
      hddLocation: hddLocationController.text.trim().toString(),
      loadObserved: loadObservedPSIController.text.trim().toString(),
      pilotBoreCommencementDate: pilotBoreDateCommencementController.text.trim().toString(),
      pilotBoreComplateTime: pilotBoreCompletedTimeController.text.trim().toString(),
      pilotBoreCompletionDate: pilotBoreDateCompletionController.text.trim().toString(),
      pilotBoreDiameter: pilotBoreDiameterController.text.trim().toString(),
      pilotBoreDuration: pilotBoreDurationController.text.trim().toString(),
      pilotBoreStartTime: pilotBoreStartTimeController.text.trim().toString(),
      preHydroTestDate: datePreHydroController.text.trim().toString(),
      reamingDuration: roDurationController.text.trim().toString(),
      reamingEnd: endController.text.trim().toString(),
      reamingStart: startController.text.trim().toString(),
      toJointData: toJointValue,
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      isJointNumberLoader = false;
      dateController.text = "";
      dateCommencementController.text = "";
      dateCompletionController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      datePreHydroController.text = "";
      equipmentCapacityController.text = "";
      equipmentUsedController.text = "";
      hddLocationController.text = "";
      lengthCrossingController.text = "";
      pipeODThicknessController.text = "";
      pipeSpecificationController.text = "";
      pilotBoreDateCommencementController.text = "";
      pilotBoreStartTimeController.text = "";
      pilotBoreDateCompletionController.text = "";
      pilotBoreCompletedTimeController.text = "";
      pilotBoreDiameterController.text = "";
      pilotBoreDurationController.text = "";
      reamerSizeUsedController.text = "";
      startController.text = "";
      endController.text = "";
      roDurationController.text = "";
      loadObservedPSIController.text = "";
      alignmentData = AlignmentModel();
      weatherData = WeatherModel();
      fromJointValue = JointNumberModel();
      toJointValue = JointNumberModel();
      jointTypeDataValue = JointTypeModel();
      file = File("");
      _eventComplete(emit);
    }
  }


  _eventComplete(Emitter<AddHddCrossingState> emit) {
    emit(FetchAddHddCrossingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      alignmentData: alignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      dateController : dateController,
      reportNumberController : reportNumberController,
      activityRemarkController : activityRemarkController,
      dateCommencementController: dateCommencementController,
      dateCompletionController: dateCompletionController,
      datePreHydroController: datePreHydroController,
      equipmentCapacityController: equipmentCapacityController,
      equipmentUsedController: equipmentUsedController,
      hddLocationController: hddLocationController,
      lengthCrossingController: lengthCrossingController,
      pipeODThicknessController: pipeODThicknessController,
      pipeSpecificationController: pipeSpecificationController,
      startController:startController,
      endController: endController,
      loadObservedPSIController: loadObservedPSIController,
      pilotBoreCompletedTimeController: pilotBoreCompletedTimeController,
      pilotBoreDateCommencementController: pilotBoreDateCommencementController,
      pilotBoreDateCompletionController: pilotBoreDateCompletionController,
      pilotBoreDiameterController: pilotBoreDiameterController,
      pilotBoreDurationController: pilotBoreDurationController,
      pilotBoreStartTimeController: pilotBoreStartTimeController,
      reamerSizeUsedController:reamerSizeUsedController,
      roDurationController: roDurationController,
      listOfJointType: listOfJointType,
      jointTypeDataValue: jointTypeDataValue,
      isJointNumberLoader: isJointNumberLoader,
      toJointValue: toJointValue,
      listOfToJoint: listOfToJoint,
      listOfFromJoint: listOfFromJoint,
      fromJointValue: fromJointValue,

    ));
  }
}


