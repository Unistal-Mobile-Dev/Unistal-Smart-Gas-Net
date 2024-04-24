import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/helper/add_radiography_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/domain/model/welder_repair_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/helper/add_welder_repair_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_welder_repair_event.dart';
part 'add_welder_repair_state.dart';

class AddWelderRepairBloc extends Bloc<AddWelderRepairEvent, AddWelderRepairState> {

  List<WelderModel> welderList = [];
  WelderModel welderData =  WelderModel();
  List<WPSModel> wpsTypeList = [];
  WPSModel wpsTypeData =  WPSModel();
  List<SegmentModel> segmentStatusList = [];
  List<SegmentModel> selectedSegmentStatusList = [];
  List<AlignmentModel> alignmentList = [];
  AlignmentModel  alignmentData = AlignmentModel();
  TextEditingController dateController =  TextEditingController();
  TextEditingController activityRemarkController  = TextEditingController();
  TextEditingController e6010Controller =  TextEditingController();
  TextEditingController e8010P1Controller =  TextEditingController();
  TextEditingController e9045P2Controller =  TextEditingController();
  TextEditingController er70s6Controller =  TextEditingController();
  TextEditingController e81TM21ABController =  TextEditingController();
  TextEditingController preHeatingTemperatureController =  TextEditingController();
  File file =  File("");
  bool isLoader =  false;
  List<WeatherModel> weatherList = [];
  WeatherModel weatherData =  WeatherModel();
  List<JointTypeModel> jointTypeList = [];
  JointTypeModel jointTypeData =  JointTypeModel();
  List<JointNumberModel> jointNumberList = [];
  JointNumberModel jointNumberData =  JointNumberModel();
  List<WelderRepairStatusModel> welderRepairStatusList = [];
  WelderRepairStatusModel welderRepairStatusData =  WelderRepairStatusModel();
  bool isJointNumberLoader = false;
  bool isWelderLoader = false;

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  AddWelderRepairBloc() : super(AddWelderRepairInitial()) {
     on<AddWelderRepairLoadEvent>(_pageLoad);
     on<AddWelderRepairSelectDateEvent>(_selectDate);
     on<AddWelderRepairSelectAlignmentEvent>(_selectAlignment);
     on<SelectWeatherEvent>(_selectWeather);
     on<AddWelderRepairSelectJointTypeEvent>(_selectJointType);
     on<AddWelderRepairSelectJointNumberEvent>(_selectJointNumber);
     on<AddWelderRepairSelectWelderRepairStatusEvent>(_selectWelderRepairStatus);
     on<AddWelderRepairSelectSegmentEvent>(_selectSegment);
     on<AddWelderRepairSelectWPSTypeEvent>(_selectWpsType);
     on<AddWelderRepairSelectWelderEvent>(_selectWelder);
     on<AddWelderRepairAddImageEvent>(_selectFile);
     on<AddWelderRepairSubmitDataEvent>(_submit);
  }

  _pageLoad(AddWelderRepairLoadEvent event, emit) async {
    emit(AddWelderRepairPageLoadState());
    welderData =  WelderModel();
    wpsTypeData =  WPSModel();
    jointNumberData =  JointNumberModel();
    jointTypeData =  JointTypeModel();
    alignmentData =  AlignmentModel();
    weatherData =  WeatherModel();
    welderRepairStatusData =  WelderRepairStatusModel();
    weatherList = [];
    alignmentList = [];
    jointTypeList = [];
    jointNumberList = [];
    welderRepairStatusList = [];
    selectedSegmentStatusList = [];
    welderList =[];
    wpsTypeList = [];
    dateController.text = "";
    activityRemarkController.text = "";
    e6010Controller.text = "";
    e8010P1Controller.text = "";
    e9045P2Controller.text = "";
    er70s6Controller.text = "";
    e81TM21ABController.text = "";
    preHeatingTemperatureController.text = "";
    isWelderLoader =  false;
    isJointNumberLoader =  false;
    isLoader = false;
    file =  File("");
    _userData =  UserInfo.instanceInit()!.userData!;
    weatherList =  await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);

    var res =  await AddRouteSurveyHelper.fetchAlignmentData( userData: userData);
    if(res != null){
      alignmentList =  res;
    }

    var resJointType =  await AddWeldingHelper.fetchJointType(context: event.context, userData: userData);
    if(resJointType != null){
      jointTypeList =  resJointType;
    }

    var resSegment =  await AddRadiographyHelper.fetchSegmentData(context: event.context, userData: userData, welderList: welderList);
    if(resSegment != null){
      segmentStatusList =  resSegment;
    }

    var resweldStatus =  await AddWelderRepairHelper.fetchWelderRepairStatusData(context: event.context);
    if(resweldStatus != null){
      welderRepairStatusList =  resweldStatus;
    }

    var resWPS =  await AddWeldingHelper.fetchWPSType(context: event.context, userData: userData);
    if(resWPS != null){
      wpsTypeList =  resWPS;
    }

    _eventComplete(emit);
  }

  _selectDate(AddWelderRepairSelectDateEvent event, emit) async {
    DateTime firstDayCurrentMonth = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day+1);
    DateTime? pickedDate = await showDatePicker(context: event.context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text =  formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      print("Date is not selected");
    }
  }

  _selectAlignment(AddWelderRepairSelectAlignmentEvent event, emit) {
    alignmentData =  event.alignmentData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectJointType(AddWelderRepairSelectJointTypeEvent event, emit) async {
    jointTypeData =  event.jointTypeModel;
    jointNumberList = [];
    jointNumberData =  JointNumberModel();
    isJointNumberLoader =  true;
    _eventComplete(emit);
    var resJointNumber =  await AddWeldingHelper.fetchJointNumberData(context: event.context, userData: userData,
        jointTypeData: jointTypeData);
    if(resJointNumber != null){
      jointNumberList =  resJointNumber;
    }
    isJointNumberLoader =  false;
    _eventComplete(emit);
    _eventComplete(emit);
  }

  _selectWelderRepairStatus(AddWelderRepairSelectWelderRepairStatusEvent event, emit) {
    welderRepairStatusData =  event.welderRepairStatusData;
    _eventComplete(emit);
  }

  _selectJointNumber(AddWelderRepairSelectJointNumberEvent event, emit) {
    jointNumberData =  event.jointNumberData;
    _eventComplete(emit);
  }

  _selectSegment(AddWelderRepairSelectSegmentEvent event, emit) {
    selectedSegmentStatusList =  event.selectedSegmentList;
    _eventComplete(emit);
  }

  _selectWpsType(AddWelderRepairSelectWPSTypeEvent event, emit) async {
    wpsTypeData =  event.wpsTypeData;
    isWelderLoader =  true;
    _eventComplete(emit);
    welderData =  WelderModel();
    var resWelder =  await AddWeldingHelper.fetchWelderData(context: event.context, userData: userData, wpsData: wpsTypeData);
    if(resWelder != null){
      welderList =  resWelder;
    }
    isWelderLoader =  false;
    _eventComplete(emit);
  }

  _selectWelder(AddWelderRepairSelectWelderEvent event, emit) {
    welderData =  event.welderData;
    _eventComplete(emit);
  }

  _selectFile(AddWelderRepairAddImageEvent event, emit) async {
    if(event.mediaType == 1) {
      var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
      if(photo != null){
        file  = photo;
      }
    } else{
      var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
      if(photo != null){
        file  = photo;
      }
    }
    Navigator.pop(event.context);
    _eventComplete(emit);
  }

  _submit(AddWelderRepairSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);

    var res =  await AddWelderRepairHelper.submitData(context: event.context,
        alignmentData: alignmentData,  date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        jointNumberData: jointNumberData,
        segmentList: selectedSegmentStatusList,
        welderRepairStatusData: welderRepairStatusData,
        wpsTypeData: wpsTypeData, welderData: welderData,
        E6010: e6010Controller.text.toString(),
        E8010P1: e8010P1Controller.text.toString(),
        E9045P2: e9045P2Controller.text.toString(),
        Er70s6: er70s6Controller.text.toString(),
        E81TM21AB: e81TM21ABController.text.toString(),
        preHeatingTempreature: preHeatingTemperatureController.text.toString(), file: file);
    if(res != null){
      welderData =  WelderModel();
      wpsTypeData =  WPSModel();
      weatherData =  WeatherModel();
      jointNumberData =  JointNumberModel();
      jointTypeData =  JointTypeModel();
      alignmentData =  AlignmentModel();
      welderRepairStatusData =  WelderRepairStatusModel();
      selectedSegmentStatusList = [];
      dateController.text = "";
      activityRemarkController.text = "";
      e6010Controller.text = "";
      e8010P1Controller.text = "";
      e9045P2Controller.text = "";
      er70s6Controller.text = "";
      e81TM21ABController.text = "";
      preHeatingTemperatureController.text = "";
      isWelderLoader =  false;
      isJointNumberLoader =  false;
      isLoader = false;
      file =  File("");
      _userData =  UserInfo.instanceInit()!.userData!;
      weatherList =  await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);
    }

    isLoader = false;
    _eventComplete(emit);
  }

  _eventComplete(Emitter<AddWelderRepairState>emit) {
    emit(FetchAddWelderRepairDataState(
        welderData: welderData,
        welderList: welderList,
        wpsTypeData: wpsTypeData,
        wpsTypeList: wpsTypeList,
        segmentStatusList: segmentStatusList,
        selectedSegmentStatusList: selectedSegmentStatusList,
        dateController: dateController,
        file: file,
        activityRemarkController: activityRemarkController,
        alignmentData: alignmentData,
        alignmentList: alignmentList,
        e81TM21ABController: e81TM21ABController,
        e6010Controller: e6010Controller,
        e8010P1Controller: e8010P1Controller,
        e9045P2Controller: e9045P2Controller,
        er70s6Controller: er70s6Controller,
        isLoader: isLoader,
        weatherData: weatherData,
        weatherList: weatherList,
        jointNumberList: jointNumberList,
        jointNumberData: jointNumberData,
        jointTypeData: jointTypeData,
        jointTypeList: jointTypeList,
        welderRepairStatusData: welderRepairStatusData,
        welderRepairStatusList: welderRepairStatusList,
        isJointNumberLoader: isJointNumberLoader,
        preHeatingTemperatureController: preHeatingTemperatureController,
        isWelderLoader: isWelderLoader,
    ));
  }

}
