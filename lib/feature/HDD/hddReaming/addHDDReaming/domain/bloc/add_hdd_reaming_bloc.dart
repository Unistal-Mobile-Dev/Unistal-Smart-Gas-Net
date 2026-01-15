import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/HDD/hddReaming/addHDDReaming/helper/add_hdd_reaming_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'add_hdd_reaming_event.dart';
part 'add_hdd_reaming_state.dart';

class AddHddReamingBloc extends Bloc<AddHddReamingEvent, AddHddReamingState> {
  AddHddReamingBloc() : super(AddHddReamingInitial()) {
    on<AddHddReamingPageLoadEvent>(_pageLoadEvent);
    on<AddHddReamingSubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddHddReamingSelectAlignmentEvent>(_selectAlignment);
    on<SelectJointTypeDataEvent>(_selectJointType);
    on<SelectFromJointEvent>(_selectFromJoint);
    on<SelectToJointEvent>(_selectToJoint);
    on<AddHddReamingStartingDateOfPilotHoleEvent>(_startingDateOfPilotHole);
    on<AddHddReamingEndDateOfPilotHoleEvent>(_endDateOfPilotHole);
    on<AddHddReamingSelectDateEvent>(_selectDate);
    on<AddHddReamingAddImageEvent>(_selectFile);
  }

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();

  TextEditingController dateController= TextEditingController();
  TextEditingController startDateReamingController= TextEditingController();
  TextEditingController endDateOfPilotHoleController= TextEditingController();
  TextEditingController reportNumberController= TextEditingController();
  TextEditingController machineCapacityController= TextEditingController();
  TextEditingController sizeOfPilotBitSizeController= TextEditingController();
  TextEditingController lengthController= TextEditingController();
  TextEditingController rodNoController= TextEditingController();
  TextEditingController totalLengthController= TextEditingController();
  TextEditingController pitchController= TextEditingController();
  TextEditingController degreeController= TextEditingController();
  TextEditingController pullBackPressureController= TextEditingController();
  TextEditingController rotaryPressureController= TextEditingController();
  TextEditingController pumpRateController= TextEditingController();
  TextEditingController reamerSizeController= TextEditingController();
  TextEditingController sizeReamingController = TextEditingController();
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

  _pageLoadEvent(AddHddReamingPageLoadEvent event, emit) async {
    emit(AddHddReamingPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    startDateReamingController.text = "";
    endDateOfPilotHoleController.text = "";
    reportNumberController.text = "";
    machineCapacityController.text = "";
    sizeOfPilotBitSizeController.text = "";
    lengthController.text = "";
    rodNoController.text = "";
    pullBackPressureController.text = "";
    totalLengthController.text = "";
    pitchController.text = "";
    degreeController.text = "";
    rotaryPressureController.text = "";
    reamerSizeController.text = "";
    pumpRateController.text = "";
    sizeReamingController.text = "";
    activityRemarkController.text = "";

    alignmentList = [];
    listOfJointType = [];
    listOfFromJoint = [];
    listOfToJoint = [];
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

  _selectAlignment(AddHddReamingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectDate(AddHddReamingSelectDateEvent event, emit) async {
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


  _startingDateOfPilotHole(AddHddReamingStartingDateOfPilotHoleEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      startDateReamingController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _endDateOfPilotHole(AddHddReamingEndDateOfPilotHoleEvent event, emit) async {
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

  _selectFile(AddHddReamingAddImageEvent event, emit) async {
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
  

  _submitData(AddHddReamingSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddHddReamingHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      fromJointData: fromJointValue,
      hddMachine: machineCapacityController.text.trim().toString(),
      toJointData: toJointValue,
      rodNo: rodNoController.text.trim().toString(),
      endReamingDate: endDateOfPilotHoleController.text.trim().toString(),
      maxReamingSize: sizeReamingController.text.trim().toString(),
      pullBackPressure: pullBackPressureController.text.trim().toString(),
      pumpRate:  pumpRateController.text.trim().toString(),
      reamerLength: lengthController.text.trim().toString(),
      reamerSize: reamerSizeController.text.trim().toString(),
      rotaryPresuure:rotaryPressureController.text.trim().toString(),
      startReamingDate: startDateReamingController.text.trim().toString(),
      totalReamingLength: totalLengthController.text.trim().toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      isJointNumberLoader = false;
      dateController.text = "";
      startDateReamingController.text = "";
      endDateOfPilotHoleController.text = "";
      reportNumberController.text = "";
      machineCapacityController.text = "";
      sizeOfPilotBitSizeController.text = "";
      lengthController.text = "";
      rodNoController.text = "";
      pullBackPressureController.text = "";
      totalLengthController.text = "";
      pitchController.text = "";
      degreeController.text = "";
      rotaryPressureController.text = "";
      reamerSizeController.text = "";
      pumpRateController.text = "";
      sizeReamingController.text = "";
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      weatherData = WeatherModel();
      fromJointValue = JointNumberModel();
      toJointValue = JointNumberModel();
      jointTypeDataValue = JointTypeModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddHddReamingState> emit) {
    emit(FetchAddHddReamingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      alignmentData: alignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      fromJointValue: fromJointValue,
      listOfFromJoint: listOfFromJoint,
      listOfToJoint: listOfToJoint,
      toJointValue: toJointValue,
      dateController : dateController,
      startDateReamingController: startDateReamingController,
      endDateOfReamingController : endDateOfPilotHoleController,
      reportNumberController : reportNumberController,
      machineCapacityController : machineCapacityController,
      sizeOfPilotBitSizeController : sizeOfPilotBitSizeController,
      lengthController : lengthController,
      rodNoController : rodNoController,
      totalLengthController : totalLengthController,
      pitchController : pitchController,
      degreeController : degreeController,
      pullBackPressureController : pullBackPressureController,
      rotaryPressureController : rotaryPressureController,
      pumpRateController: pumpRateController,
      reamerSizeController: reamerSizeController,
      sizeReamingController: sizeReamingController,
      activityRemarkController : activityRemarkController,
      isJointNumberLoader: isJointNumberLoader,
      jointTypeDataValue: jointTypeDataValue,
      listOfJointType: listOfJointType,
    ));
  }
}

