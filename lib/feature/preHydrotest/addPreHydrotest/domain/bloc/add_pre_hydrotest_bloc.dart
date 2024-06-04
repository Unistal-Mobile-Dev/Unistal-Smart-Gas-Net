import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/helper/add_concrete_coating_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/preHydrotest/addPreHydrotest/helper/add_pre_hydrotest_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_pre_hydrotest_event.dart';

part 'add_pre_hydrotest_state.dart';

class AddPreHydrotestBloc
    extends Bloc<AddPreHydrotestEvent, AddPreHydrotestState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController ndeClearanceController = TextEditingController();
  TextEditingController pressureGaugeNoController = TextEditingController();
  TextEditingController pressureGaugeCalibrationDateController =
      TextEditingController();
  TextEditingController testPressureController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  TextEditingController pipeSizeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController timeOnController = TextEditingController();
  TextEditingController timeOffController = TextEditingController();
  TextEditingController timeInHoursController = TextEditingController();
  TextEditingController pressureReading1KGController = TextEditingController();
  TextEditingController pressureReading2KGController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();

  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  bool isLoader = false;
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<ThicknessModel> _thicknessList = [];

  List<ThicknessModel> get thicknessList => _thicknessList;

  ThicknessModel _thicknessData = ThicknessModel();

  ThicknessModel get thicknessData => _thicknessData;

  AddPreHydrotestBloc() : super(AddPreHydrotestInitial()) {
    on<AddPreHydrotestPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddPreHydrotestSelectAlignmentEvent>(_selectAlignment);
    on<AddPreHydrotestSelectFromJointDataEvent>(_selectJointFrom);
    on<AddPreHydrotestSelectToJointDataEvent>(_selectJointTo);
    on<AddPreHydrotestSelectJointTypeDataEvent>(_selectJointType);
    on<AddPreHydrotestSelectDateEvent>(_selectDate);
    on<AddPreHydrotestSelectPressureDateEvent>(_selectPressureDate);
    on<AddPreHydrotestAddImageEvent>(_selectFile);
    on<AddPreHydrotestSelectSelectThicknessDataEvent>(_selectThickness);
    on<AddPreHydrotestSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddPreHydrotestPageLoadEvent event, emit) async {
    emit(AddPreHydrotestPageLoadState());
    dateController.text = "";
    activityRemarkController.text = "";
    lengthController.text = "";
    ndeClearanceController.text = "";
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData = AlignmentModel();
    _thicknessList = [];
    _thicknessData = ThicknessModel();
    isLoader = false;
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    weatherData = WeatherModel();
    pressureGaugeNoController.text = "";
    pressureGaugeCalibrationDateController.text = "";
    testPressureController.text = "";
    rangeController.text = "";
    pipeSizeController.text = "";
    durationController.text = "";
    timeOnController.text = "";
    timeOffController.text = "";
    timeInHoursController.text = "";
    pressureReading1KGController.text = "";
    pressureReading2KGController.text = "";
    chainageToController.text = "";
    chainageFromController.text = "";
    reportNumberController.text = "";
    pressureReading2KGController.text = "";
    tempController.text = "";
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (res != null) {
      alignmentList = res;
    }

    var resJointType = await AddWeldingHelper.fetchJointType(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (resJointType != null) {
      jointTypeList = resJointType;
    }

    var thicknessRes = await AddConcreteCoatingHelper.fetchThicknessData(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (thicknessRes != null) {
      _thicknessList = thicknessRes;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddPreHydrotestSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddPreHydrotestSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddPreHydrotestSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddPreHydrotestSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointFromList = [];
    jointToList = [];
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        jointTypeData: jointTypeData);
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }
    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectDate(AddPreHydrotestSelectDateEvent event, emit) async {
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

  _selectPressureDate(
      AddPreHydrotestSelectPressureDateEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      pressureGaugeCalibrationDateController.text =
          formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _selectThickness(AddPreHydrotestSelectSelectThicknessDataEvent event, emit) {
    _thicknessData = event.thicknessData;
    _eventComplete(emit);
  }

  _selectFile(AddPreHydrotestAddImageEvent event, emit) async {
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

  _submitData(AddPreHydrotestSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddPreHydroTestHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      fromJointData: fromJointData,
      toJointData: toJointData,
      jointTypeData: jointTypeData,
      ndeClearance: ndeClearanceController.text.toString(),
      length: lengthController.text.toString(),
      thicknessData: thicknessData,
      file: file,
      duration: durationController.text.toString(),
      pipeSize: pipeSizeController.text.toString(),
      pressureGaugeCalibrationDate:
          pressureGaugeCalibrationDateController.text.toString(),
      pressureGaugeNo: pressureGaugeNoController.text.toString(),
      pressureReading1KG: pressureReading1KGController.text.toString(),
      pressureReading2KG: pressureReading2KGController.text.toString(),
      range: rangeController.text.toString(),
      temp: tempController.text.toString(),
      testPressure: testPressureController.text.toString(),
      timeInHours: timeInHoursController.text.toString(),
      timeOff: timeOffController.text.toString(),
      timeOn: timeOnController.text.toString(),
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      reportNumber: reportNumberController.text.toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      activityRemarkController.text = "";
      lengthController.text = "";
      ndeClearanceController.text = "";
      alignmentData = AlignmentModel();
      isLoader = false;
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      _thicknessData = ThicknessModel();
      pressureGaugeNoController.text = "";
      pressureGaugeCalibrationDateController.text = "";
      testPressureController.text = "";
      rangeController.text = "";
      pipeSizeController.text = "";
      durationController.text = "";
      timeOnController.text = "";
      timeOffController.text = "";
      timeInHoursController.text = "";
      pressureReading1KGController.text = "";
      pressureReading2KGController.text = "";
      tempController.text = "";
      chainageFromController.text = "";
      reportNumberController.text = "";
      chainageToController.text = "";
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddPreHydrotestState> emit) {
    emit(FetchAddPreHydrotestDataState(
        isLoader: isLoader,
        alignmentList: alignmentList,
        dateController: dateController,
        activityRemarkController: activityRemarkController,
        alignmentData: alignmentData,
        file: file,
        weatherList: weatherList,
        weatherData: weatherData,
        jointTypeData: jointTypeData,
        jointTypeList: jointTypeList,
        isJointNumberLoader: isJointNumberLoader,
        fromJointData: fromJointData,
        jointFromList: jointFromList,
        jointToList: jointToList,
        lengthController: lengthController,
        toJointData: toJointData,
        ndeClearanceController: ndeClearanceController,
        thicknessData: thicknessData,
        thicknessList: thicknessList,
        durationController: durationController,
        pipeSizeController: pipeSizeController,
        pressureGaugeCalibrationDateController:
            pressureGaugeCalibrationDateController,
        pressureGaugeNoController: pressureGaugeNoController,
        pressureReading1KGController: pressureReading1KGController,
        pressureReading2KGController: pressureReading2KGController,
        rangeController: rangeController,
        tempController: tempController,
        testPressureController: testPressureController,
        timeInHoursController: timeInHoursController,
        timeOffController: timeOffController,
        timeOnController: timeOnController,
        chainageFromController: chainageFromController,
        reportNumberController: reportNumberController,
        chainageToController: chainageToController));
  }
}
