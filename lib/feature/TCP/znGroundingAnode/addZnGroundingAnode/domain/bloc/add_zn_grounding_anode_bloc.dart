import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/helper/add_test_station_box_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/znGroundingAnode/addZnGroundingAnode/helper/add_zn_grounding_anode_helper.dart';
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
part 'add_zn_grounding_anode_event.dart';
part 'add_zn_grounding_anode_state.dart';

class AddZnGroundingAnodeBloc extends Bloc<AddZnGroundingAnodeEvent, AddZnGroundingAnodeState> {
  AddZnGroundingAnodeBloc() : super(AddZnGroundingAnodeInitial()) {
    on<AddZnGroundingAnodePageLoadEvent>(_pageLoadEvent);
    on<AddZnGroundingAnodeSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddTestStationBoxTLPTypeEvent>(_selectTLPType);
    on<AddZnGroundingAnodeSelectAlignmentEvent>(_selectAlignment);
    on<SelectJointTypeDataEvent>(_selectJointType);
    on<SelectJointEvent>(_selectJoint);
    on<AddTestStationBoxSacrificialAnodeTypeEvent>(_selectTypeNode);
    on<AddZnGroundingAnodeAddImageEvent>(_selectFile);
    on<AddZnGroundingAnodeSubmitDataEvent>(_submitData);
  }

  TextEditingController dateController= TextEditingController();
  TextEditingController reportNumberController= TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController anodeWeightController= TextEditingController();
  TextEditingController anodeLocationController= TextEditingController();
  TextEditingController depthAugerController= TextEditingController();
  TextEditingController anodeConditionController= TextEditingController();
  TextEditingController distanceController= TextEditingController();
  TextEditingController noAnodesController= TextEditingController();
  TextEditingController a1LengthController= TextEditingController();
  TextEditingController a2LengthController= TextEditingController();
  TextEditingController a3LengthController= TextEditingController();
  TextEditingController earthingController= TextEditingController();
  TextEditingController acPspBeforeController= TextEditingController();
  TextEditingController a1AnodeController= TextEditingController();
  TextEditingController a2AnodeController= TextEditingController();
  TextEditingController a3AnodeController= TextEditingController();
  TextEditingController a4AnodeController= TextEditingController();
  TextEditingController acPspAfterController= TextEditingController();
  TextEditingController dcPspBeforeController= TextEditingController();
  TextEditingController dcPspAfterController= TextEditingController();
  TextEditingController acCurrentAfterController= TextEditingController();
  TextEditingController installationTypeController= TextEditingController();
  TextEditingController checkWaterFillingController= TextEditingController();
  TextEditingController activityRemarkController= TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();

  List<JointNumberModel> listOfJoint = [];
  List<JointTypeModel> listOfJointType = [];

  JointNumberModel jointValue = JointNumberModel();
  JointTypeModel jointTypeDataValue = JointTypeModel();
  bool isJointNumberLoader = false;

  List<TlpTypeModel> listOfSacrificialAnode = [];
  TlpTypeModel typeNodeValue = TlpTypeModel();

  _pageLoadEvent(AddZnGroundingAnodePageLoadEvent event, emit) async {
    emit(AddZnGroundingAnodePageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    reportNumberController.text = "";
    areaController.text = "";
    chainageController.text = "";
    anodeWeightController.text = "";
    anodeLocationController.text = "";
    depthAugerController.text = "";
    anodeConditionController.text = "";
    distanceController.text = "";
    noAnodesController.text = "";
    a1LengthController.text = "";
    a2LengthController.text = "";
    a3LengthController.text = "";
    earthingController.text = "";
    acPspBeforeController.text = "";
    a1AnodeController.text = "";
    a2AnodeController.text = "";
    a3AnodeController.text = "";
    a4AnodeController.text = "";
    acPspAfterController.text = "";
    dcPspBeforeController.text = "";
    dcPspAfterController.text = "";
    acCurrentAfterController.text = "";
    installationTypeController.text = "";
    checkWaterFillingController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfJointType = [];
    listOfSacrificialAnode = [];
    alignmentData = AlignmentModel();
    weatherData = WeatherModel();
    jointValue = JointNumberModel();
    jointTypeDataValue = JointTypeModel();
    tlpTypeValue =  TlpTypeModel();
    typeNodeValue = TlpTypeModel();
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);
    userData = UserInfo.instanceInit()!.userData!;
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

    var resAnodeType = await AddTestStationBoxHelper.fetchAnodeTypeApi(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (resAnodeType != null) {
      listOfSacrificialAnode = resAnodeType;
    }
    var resTLPType = await AddTestStationBoxHelper.fetchTLPType(
        context: !event.context.mounted ? event.context : event.context, userData: userData);
    if (resTLPType != null) {
      listOfTLPType = resTLPType;
    }

    _eventComplete(emit);
  }

  _selectAlignment(AddZnGroundingAnodeSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
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

  _selectJointType(SelectJointTypeDataEvent event, emit) async {
    jointTypeDataValue = event.jointTypeDataValue;
    listOfJoint = [];
    jointValue = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        type: "welding",
        jointTypeData: jointTypeDataValue);
    if (resJointNumber != null) {
      listOfJoint = resJointNumber;
    }
    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectJoint(SelectJointEvent event, emit) {
    jointValue = event.jointValue;
    _eventComplete(emit);
  }

  _selectTypeNode(AddTestStationBoxSacrificialAnodeTypeEvent event, emit) {
    typeNodeValue = event.typeNodeValue;
    _eventComplete(emit);
  }

  _selectDate(AddZnGroundingAnodeSelectDateEvent event, emit) async {
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

  _selectFile(AddZnGroundingAnodeAddImageEvent event, emit) async {
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

  _submitData(AddZnGroundingAnodeSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddZnGroundingAnodeHelper.submitData(
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
      distancePipeline: distanceController.text.trim().toString(),
      anodeId: typeNodeValue,
      anodeCondition: anodeConditionController.text.trim().toString(),
      earthingResistance: earthingController.text.trim().toString(),
      cableLengthA1:  a1LengthController.text.trim().toString(),
      cableLengthA2:  a2LengthController.text.trim().toString(),
      cableLengthA3: a3LengthController.text.trim().toString(),
      afterConnectionAnodeDc: dcPspAfterController.text.trim().toString(),
      afterInstallationConnectionAc: acPspAfterController.text.trim().toString(),
      afterPspConnectionAc: acPspBeforeController.text.trim().toString(),
      anodeLocationChainage: anodeLocationController.text.trim().toString(),
      anodeNoSpace: noAnodesController.text.trim().toString(),
      anodeOpenCircuitA1: a1AnodeController.text.trim().toString(),
      anodeOpenCircuitA2: a2AnodeController.text.trim().toString(),
      anodeOpenCircuitA3: a3AnodeController.text.trim().toString(),
      anodeOpenCircuitA4: a4AnodeController.text.trim().toString(),
      beforePspConnection: acPspBeforeController.text.trim().toString(),
      beforePspConnectionDc: dcPspBeforeController.text.trim().toString(),
      checkWaterFilling: checkWaterFillingController.text.trim().toString(),
      depthAuger: depthAugerController.text.trim().toString(),
      installationType: installationTypeController.text.trim().toString(),
      weightHeight: anodeWeightController.text.trim().toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      dateController.text = "";
      reportNumberController.text = "";
      areaController.text = "";
      chainageController.text = "";
      anodeWeightController.text = "";
      anodeLocationController.text = "";
      depthAugerController.text = "";
      anodeConditionController.text = "";
      distanceController.text = "";
      noAnodesController.text = "";
      a1LengthController.text = "";
      a2LengthController.text = "";
      a3LengthController.text = "";
      earthingController.text = "";
      acPspBeforeController.text = "";
      a1AnodeController.text = "";
      a2AnodeController.text = "";
      a3AnodeController.text = "";
      a4AnodeController.text = "";
      acPspAfterController.text = "";
      dcPspBeforeController.text = "";
      dcPspAfterController.text = "";
      acCurrentAfterController.text = "";
      installationTypeController.text = "";
      checkWaterFillingController.text = "";
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      weatherData = WeatherModel();
      jointValue = JointNumberModel();
      jointTypeDataValue = JointTypeModel();
      tlpTypeValue =  TlpTypeModel();
      typeNodeValue = TlpTypeModel();
      file = File("");
      _eventComplete(emit);
  }
  }

  _eventComplete(Emitter<AddZnGroundingAnodeState> emit) {
    emit(FetchAddZnGroundingAnodeState(
      isLoader : isLoader,
      alignmentList : alignmentList,
      alignmentData : alignmentData,
      file : file,
      weatherList : weatherList,
      weatherData : weatherData,
      jointValue: jointValue,
      listOfJoint: listOfJoint,
      listOfJointType : listOfJointType,
      jointTypeDataValue : jointTypeDataValue,
      isJointNumberLoader : isJointNumberLoader,
      listOfSacrificialAnode : listOfSacrificialAnode,
      typeNodeValue : typeNodeValue,
      dateController : dateController,
      reportNumberController : reportNumberController,
      anodeWeightController : anodeWeightController,
      anodeLocationController : anodeLocationController,
      depthAugerController : depthAugerController,
      anodeConditionController : anodeConditionController,
      distanceController : distanceController,
      noAnodesController : noAnodesController,
      a1LengthController : a1LengthController,
      a2LengthController : a2LengthController,
      a3LengthController : a3LengthController,
      earthingController : earthingController,
      acPspBeforeController : acPspBeforeController,
      a1AnodeController : a1AnodeController,
      a2AnodeController : a2AnodeController,
      a3AnodeController : a3AnodeController,
      a4AnodeController : a4AnodeController,
      acPspAfterController : acPspAfterController,
      dcPspBeforeController : dcPspBeforeController,
      dcPspAfterController : dcPspAfterController,
      acCurrentAfterController : acCurrentAfterController,
      installationTypeController : installationTypeController,
      checkWaterFillingController : checkWaterFillingController,
      activityRemarkController : activityRemarkController,
      areaController: areaController,
      chainageController: chainageController,
      listOfTLPType: listOfTLPType,
      tlpTypeValue: tlpTypeValue,

    ));
  }
}