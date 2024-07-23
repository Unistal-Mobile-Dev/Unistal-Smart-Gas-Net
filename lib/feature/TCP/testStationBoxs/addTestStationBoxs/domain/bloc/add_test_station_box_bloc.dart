import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:meta/meta.dart';

part 'add_test_station_box_event.dart';
part 'add_test_station_box_state.dart';

class AddTestStationBoxBloc extends Bloc<AddTestStationBoxEvent, AddTestStationBoxState> {
  AddTestStationBoxBloc() : super(AddTestStationBoxInitial()) {
    on<AddTestStationBoxPageLoadEvent>(_pageLoadEvent);
    on<AddTestStationBoxSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddTestStationBoxSelectAlignmentEvent>(_selectAlignment);
    on<AddTestStationBoxTLPTypeEvent>(_selectTLPType);
    on<AddTestStationBoxDistanceEvent>(_selectDistance);
    on<AddTestStationBoxFoundationCheckEvent>(_selectFoundationCheck);
    on<AddTestStationBoxTestStationMountingEvent>(_selectTestStationMounting);
    on<AddTestStationBoxTestStationDoorsEvent>(_selectTestStationDoors);
    on<AddTestStationBoxCableEntrySealingEvent>(_selectCableEntrySealing);
    on<AddTestStationBoxCableTerminationEvent>(_selectCableTermination);
    on<AddTestStationBoxNamePlateEvent>(_selectNamePlate);
    on<AddTestStationBoxIndividualResistorEvent>(_selectIndividualResistor);
    on<AddTestStationBoxCompactionEvent>(_selectCompaction);
    on<AddTestStationBoxCableSealingEvent>(_selectCableSealing);
    on<AddTestStationBoxAddImageEvent>(_selectFile);
    on<AddTestStationBoxSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController testStationLocationController = TextEditingController();
  TextEditingController testStationTypeController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();

  List<VisualChecksModel> listOfDistance = [];
  VisualChecksModel distanceValue = VisualChecksModel();

  List<VisualChecksModel> listOfFoundationCheck = [];
  VisualChecksModel foundationCheckValue = VisualChecksModel();

  List<VisualChecksModel> listOfTSMounting = [];
  VisualChecksModel tsMountingValue = VisualChecksModel();

  List<VisualChecksModel> listOfTSDoors = [];
  VisualChecksModel tsDoorsValue = VisualChecksModel();

  List<VisualChecksModel> listOfCableEntrySealing = [];
  VisualChecksModel cableEntrySealingValue = VisualChecksModel();

  List<VisualChecksModel> listOfCableTermination = [];
  VisualChecksModel cableTerminationValue = VisualChecksModel();

  List<VisualChecksModel> listOfNmePlate = [];
  VisualChecksModel namePlateValue = VisualChecksModel();

  List<VisualChecksModel> listOfIndividualResistor = [];
  VisualChecksModel individualResistorValue = VisualChecksModel();

  List<VisualChecksModel> listOfCompaction = [];
  VisualChecksModel compactionValue = VisualChecksModel();

  List<VisualChecksModel> listOfCableSealing = [];
  VisualChecksModel cableSealingValue = VisualChecksModel();



  _pageLoadEvent(AddTestStationBoxPageLoadEvent event, emit) async {
    emit(AddTestStationBoxPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    reportNumberController.text = "";
    areaController.text = "";
    chainageController.text = "";
    testStationLocationController.text = "";
    testStationTypeController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfDistance = [];
    listOfFoundationCheck = [];
    listOfTSMounting = [];
    listOfTSDoors = [];
    listOfCableEntrySealing = [];
    listOfCableTermination = [];
    listOfNmePlate = [];
    listOfCompaction = [];
    listOfIndividualResistor = [];
    listOfCableSealing = [];
    alignmentData = AlignmentModel();
    weatherData = WeatherModel();
    tlpTypeValue = TlpTypeModel();
    distanceValue = VisualChecksModel();
    foundationCheckValue = VisualChecksModel();
    tsMountingValue = VisualChecksModel();
    tsDoorsValue = VisualChecksModel();
    cableEntrySealingValue = VisualChecksModel();
    cableTerminationValue = VisualChecksModel();
    namePlateValue = VisualChecksModel();
    individualResistorValue = VisualChecksModel();
    compactionValue = VisualChecksModel();
    cableSealingValue = VisualChecksModel();
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);
    userData = UserInfo.instanceInit()!.userData!;
    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (res != null) {
      alignmentList = res;
    }

    var resTLPType = await AddTestStationBoxHelper.fetchTLPType(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (resTLPType != null) {
      listOfTLPType = resTLPType;
    }
    var resVisual = await AddBendingHelper.fetchVisualChecks(
        context: !event.context.mounted ? event.context : event.context);
    if (resVisual != null) {
      listOfDistance = resVisual;
    }

    listOfFoundationCheck = listOfDistance;
    listOfTSMounting = listOfDistance;
    listOfTSDoors = listOfDistance;
    listOfCableEntrySealing = listOfDistance;
    listOfCableTermination = listOfDistance;
    listOfNmePlate = listOfDistance;
    listOfCompaction = listOfDistance;
    listOfIndividualResistor = listOfDistance;
    listOfCableSealing = listOfDistance;
    _eventComplete(emit);
  }

  _selectAlignment(AddTestStationBoxSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectDate(AddTestStationBoxSelectDateEvent event, emit) async {
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

  _selectFile(AddTestStationBoxAddImageEvent event, emit) async {
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

  _selectTLPType(AddTestStationBoxTLPTypeEvent event, emit) {
    tlpTypeValue = event.tlpTypeValue;
    _eventComplete(emit);
  }

  _selectDistance(AddTestStationBoxDistanceEvent event, emit) {
    distanceValue = event.distanceValue;
    _eventComplete(emit);
  }

  _selectFoundationCheck(AddTestStationBoxFoundationCheckEvent event, emit) {
    foundationCheckValue = event.foundationCheckValue;
    _eventComplete(emit);
  }

  _selectTestStationMounting(AddTestStationBoxTestStationMountingEvent event, emit) {
    tsMountingValue = event.tsMountingValue;
    _eventComplete(emit);
  }

  _selectTestStationDoors(AddTestStationBoxTestStationDoorsEvent event, emit) {
    tsDoorsValue = event.tsDoorsValue;
    _eventComplete(emit);
  }

  _selectCableEntrySealing(AddTestStationBoxCableEntrySealingEvent event, emit) {
    cableEntrySealingValue = event.cableEntrySealingValue;
    _eventComplete(emit);
  }

  _selectCableTermination(AddTestStationBoxCableTerminationEvent event, emit) {
    cableTerminationValue = event.cableTerminationValue;
    _eventComplete(emit);
  }

  _selectNamePlate(AddTestStationBoxNamePlateEvent event, emit) {
    namePlateValue = event.namePlateValue;
    _eventComplete(emit);
  }

  _selectIndividualResistor(AddTestStationBoxIndividualResistorEvent event, emit) {
    individualResistorValue = event.individualResistorValue;
    _eventComplete(emit);
  }

  _selectCompaction(AddTestStationBoxCompactionEvent event, emit) {
    compactionValue = event.compactionValue;
    _eventComplete(emit);
  }

  _selectCableSealing(AddTestStationBoxCableSealingEvent event, emit) {
    cableSealingValue = event.cableSealingValue;
    _eventComplete(emit);
  }

  _submitData(AddTestStationBoxSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddTestStationBoxHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      area: areaController.text.trim().toString(),
      tlpTypeId: tlpTypeValue,
      chainage: chainageController.text.trim().toString(),
     distancePipeline: distanceValue,
      testStationType: testStationTypeController.text.trim().toString(),
      cableEntrySealing: cableEntrySealingValue,
      cableSealing: cableSealingValue,
      cableTerminationCheck: cableTerminationValue,
      compactionAlignmentCheck: compactionValue,
      foundationCheck: foundationCheckValue,
      namePlateConnectionCheck: namePlateValue,
      shuntValueCheck: individualResistorValue,
      tesStationMounting: tsMountingValue,
      testStationDoors: tsDoorsValue,
      testStationLocation: testStationLocationController.text.trim().toString(),
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
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      weatherData = WeatherModel();
      tlpTypeValue = TlpTypeModel();
      distanceValue = VisualChecksModel();
      foundationCheckValue = VisualChecksModel();
      tsMountingValue = VisualChecksModel();
      tsDoorsValue = VisualChecksModel();
      cableEntrySealingValue = VisualChecksModel();
      cableTerminationValue = VisualChecksModel();
      namePlateValue = VisualChecksModel();
      individualResistorValue = VisualChecksModel();
      compactionValue = VisualChecksModel();
      cableSealingValue = VisualChecksModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddTestStationBoxState> emit) {
    emit(FetchAddTestStationBoxState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      alignmentData: alignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      dateController : dateController,
      reportNumberController : reportNumberController,
      areaController: areaController,
      chainageController: chainageController,
      testStationLocationController: testStationLocationController,
      testStationTypeController: testStationTypeController,
      activityRemarkController : activityRemarkController,
      listOfTLPType: listOfTLPType,
      tlpTypeValue: tlpTypeValue,
      listOfDistance: listOfDistance,
      distanceValue: distanceValue,
      listOfFoundationCheck: listOfFoundationCheck,
      foundationCheckValue: foundationCheckValue,
      listOfTSMounting: listOfTSMounting,
      tsMountingValue: tsMountingValue,
      listOfTSDoors: listOfTSDoors,
      tsDoorsValue: tsDoorsValue,
      listOfCableEntrySealing: listOfCableEntrySealing,
      cableEntrySealingValue: cableEntrySealingValue,
      listOfCableTermination: listOfCableTermination,
      cableTerminationValue: cableTerminationValue,
      listOfNmePlate: listOfNmePlate,
      namePlateValue: namePlateValue,
      listOfIndividualResistor: listOfIndividualResistor,
      individualResistorValue: individualResistorValue,
      listOfCompaction: listOfCompaction,
      compactionValue: compactionValue,
      listOfCableSealing: listOfCableSealing,
      cableSealingValue: cableSealingValue,

    ));
  }
}