import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/sacrificialAnode/addSacrificialAnode/helper/add_sacrificial_anode_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/helper/add_test_station_box_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/helper/dashboard_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_sacrificial_anode_event.dart';
part 'add_sacrificial_anode_state.dart';

class AddSacrificialAnodeBloc extends Bloc<AddSacrificialAnodeEvent, AddSacrificialAnodeState> {
  AddSacrificialAnodeBloc() : super(AddSacrificialAnodeInitial()) {
    on<AddSacrificialAnodePageLoadEvent>(_pageLoadEvent);
    on<AddSacrificialAnodeSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddTestStationBoxTLPTypeEvent>(_selectTLPType);
    on<AddTestStationBoxSacrificialAnodeTypeEvent>(_selectSacrificialAnode);
    on<AddTestStationBoxAnodeConditionEvent>(_selectAnodeCondition);
    on<AddSacrificialAnodeSelectAlignmentEvent>(_selectAlignment);
    on<AddSacrificialAnodeMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddSacrificialAnodeAddImageEvent>(_selectFile);
    on<AddSacrificialAnodeSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController testStationLocationController = TextEditingController();
  TextEditingController testStationTypeController = TextEditingController();
  TextEditingController testStationController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController noAnodesController = TextEditingController();
  TextEditingController spacingAnodesController = TextEditingController();
  TextEditingController outputAnodesController = TextEditingController();
  TextEditingController a1Controller = TextEditingController();
  TextEditingController a2Controller = TextEditingController();
  TextEditingController a3Controller = TextEditingController();
  TextEditingController anodeCircuitController = TextEditingController();
  TextEditingController beforeAnodeController = TextEditingController();
  TextEditingController afterAnodeController = TextEditingController();
  TextEditingController activityRemarkController= TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();

  List<TlpTypeModel> listOfSacrificialAnode = [];
  TlpTypeModel sacrificialAnodeValue = TlpTypeModel();

  List<VisualChecksModel> listOfAnodeCondition = [];
  VisualChecksModel anodeConditionValue = VisualChecksModel();

  _pageLoadEvent(AddSacrificialAnodePageLoadEvent event, emit) async {
    emit(AddSacrificialAnodePageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    reportNumberController.text = "";
    areaController.text = "";
    chainageController.text = "";
    testStationLocationController.text = "";
    testStationTypeController.text = "";
    testStationController.text = "";
    distanceController.text = "";
    noAnodesController.text = "";
    spacingAnodesController.text = "";
    outputAnodesController.text = "";
    a1Controller.text = "";
    a2Controller.text = "";
    a3Controller.text = "";
    anodeCircuitController.text = "";
    beforeAnodeController.text = "";
    afterAnodeController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfAnodeCondition = [];
    listOfSacrificialAnode = [];
    anodeConditionValue = VisualChecksModel();
    sacrificialAnodeValue = TlpTypeModel();
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    weatherData = WeatherModel();
    tlpTypeValue = TlpTypeModel();
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData();
    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }
    var resTLPType = await AddTestStationBoxHelper.fetchTLPType();
    if (resTLPType != null) {
      listOfTLPType = resTLPType;
    }
    var resVisual = await AddBendingHelper.fetchVisualChecks();
    if (resVisual != null) {
      listOfAnodeCondition = resVisual;
    }
    var resAnodeType = await AddTestStationBoxHelper.fetchAnodeTypeApi();
    if (resAnodeType != null) {
      listOfSacrificialAnode = resAnodeType;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddSacrificialAnodeSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddSacrificialAnodeMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }



  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectTLPType(AddTestStationBoxTLPTypeEvent event, emit) {
    tlpTypeValue = event.tlpTypeValue;
    _eventComplete(emit);
  }

  _selectSacrificialAnode(AddTestStationBoxSacrificialAnodeTypeEvent event, emit) {
    sacrificialAnodeValue = event.sacrificialAnodeValue;
    _eventComplete(emit);
  }

  _selectAnodeCondition(AddTestStationBoxAnodeConditionEvent event, emit) {
    anodeConditionValue = event.anodeConditionValue;
    _eventComplete(emit);
  }


  _selectDate(AddSacrificialAnodeSelectDateEvent event, emit) async {
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

  _selectFile(AddSacrificialAnodeAddImageEvent event, emit) async {
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

  _submitData(AddSacrificialAnodeSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddSacrificialAnodeHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      area: areaController.text.trim().toString(),
      tlpTypeId: tlpTypeValue,
      chainage: chainageController.text.trim().toString(),
     testStationType: testStationTypeController.text.trim().toString(),
      afterPspConnectionAnode: afterAnodeController.text.trim().toString(),
      anodeCondition: anodeConditionValue,
      anodeId: "",
      anodeLocation: testStationLocationController.text.trim().toString(),
      anodeNo:noAnodesController.text.trim().toString(),
      anodeOpenCirkuit: anodeCircuitController.text.trim().toString(),
      anodeTailCableLength2: a2Controller.text.trim().toString(),
      anodeTailCableLength3:  a3Controller.text.trim().toString(),
      anodeTailCableLength:  a1Controller.text.trim().toString(),
      beforePspConnectionAnode: beforeAnodeController.text.trim().toString(),
      currentOutputAnode: outputAnodesController.text.trim().toString(),
      distancePipeline: distanceController.text.trim().toString(),
      spacingBetweenAnode: spacingAnodesController.text.trim().toString(),
      testStationNo: testStationController.text.trim().toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      dateController.text = "";
      reportNumberController.text = "";
      areaController.text = "";
      chainageController.text = "";
      testStationLocationController.text = "";
      testStationTypeController.text = "";
      testStationController.text = "";
      distanceController.text = "";
      noAnodesController.text = "";
      spacingAnodesController.text = "";
      outputAnodesController.text = "";
      a1Controller.text = "";
      a2Controller.text = "";
      a3Controller.text = "";
      anodeCircuitController.text = "";
      beforeAnodeController.text = "";
      afterAnodeController.text = "";
      activityRemarkController.text = "";
      anodeConditionValue = VisualChecksModel();
      sacrificialAnodeValue = TlpTypeModel();
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      weatherData = WeatherModel();
      tlpTypeValue = TlpTypeModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddSacrificialAnodeState> emit) {
    emit(FetchAddSacrificialAnodeState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      listOfTLPType: listOfTLPType,
      tlpTypeValue: tlpTypeValue,
      anodeConditionValue: anodeConditionValue,
      sacrificialAnodeValue: sacrificialAnodeValue,
      listOfAnodeCondition: listOfAnodeCondition,
      listOfSacrificialAnode: listOfSacrificialAnode,
      dateController : dateController,
      reportNumberController : reportNumberController,
      areaController: areaController,
      chainageController: chainageController,
      testStationLocationController: testStationLocationController,
      testStationTypeController: testStationTypeController,
      a1Controller: a1Controller,
      a2Controller: a2Controller,
      a3Controller: a3Controller,
      afterAnodeController: afterAnodeController,
      anodeCircuitController: anodeCircuitController,
      beforeAnodeController: beforeAnodeController,
      distanceController: distanceController,
      noAnodesController: noAnodesController,
      outputAnodesController: outputAnodesController,
      spacingAnodesController: spacingAnodesController,
      testStationController: testStationController,
      activityRemarkController : activityRemarkController,

    ));
  }
}