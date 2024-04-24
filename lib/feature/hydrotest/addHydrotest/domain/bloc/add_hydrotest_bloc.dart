import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/domain/file_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/helper/add_hydrotest_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_hydrotest_event.dart';
part 'add_hydrotest_state.dart';

class AddHydrotestBloc extends Bloc<AddHydrotestEvent, AddHydrotestState> {

  TextEditingController dateController =  TextEditingController();
  TextEditingController activityRemarkController =  TextEditingController();
  TextEditingController lengthController =  TextEditingController();

  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel  alignmentData =  AlignmentModel();
  bool isLoader =  false;
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData =  JointTypeModel();
  bool isJointNumberLoader = false;
  List<FileModel> fileList =  [];
  WeatherModel weatherData =  WeatherModel();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  AddHydrotestBloc() : super(AddHydrotestInitial()) {
    on<AddHydrotestPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddHydrotestSelectAlignmentEvent>(_selectAlignment);
    on<AddHydrotestSelectFromJointDataEvent>(_selectJointFrom);
    on<AddHydrotestSelectToJointDataEvent>(_selectJointTo);
    on<AddHydrotestSelectJointTypeDataEvent>(_selectJointType);
    on<AddHydrotestSelectDateEvent>(_selectDate);
    on<AddHydrotestAddImageEvent>(_selectFile);
    on<AddHydrotestSubmitDataEvent>(_submitData);
    
  }
  _pageLoad(AddHydrotestPageLoadEvent event, emit) async {
    emit(AddHydrotestPageLoadState());
    dateController.text = "";
    activityRemarkController.text = "";
    lengthController.text = "";
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData =  AlignmentModel();
    isLoader =  false;
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData =  JointTypeModel();
    isJointNumberLoader = false;
    fileList =  await AddHydroTestHelper.fetchFilesData();
    weatherData =  WeatherModel();
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

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddHydrotestSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddHydrotestSelectFromJointDataEvent event, emit) {
    fromJointData =  event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddHydrotestSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }


  _selectJointType(AddHydrotestSelectJointTypeDataEvent event, emit) async {
    jointTypeData =  event.jointTypeData;
    jointFromList = [];
    jointToList  = [];
    fromJointData =  JointNumberModel();
    toJointData =  JointNumberModel();
    isJointNumberLoader =  true;
    _eventComplete(emit);
    var resJointNumber =  await AddWeldingHelper.fetchJointNumberData(context: event.context, userData: userData,
        jointTypeData: jointTypeData);
    if(resJointNumber != null){
      jointFromList =  resJointNumber;
      jointToList =  jointFromList;
    }
    isJointNumberLoader =  false;
    _eventComplete(emit);
  }

  _selectDate(AddHydrotestSelectDateEvent event, emit) async {
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

  _selectFile(AddHydrotestAddImageEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    if(event.mediaType == 1) {
      var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
      if(photo != null){
        fileList[event.index].file  = photo;
      }
    } else{
      var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
      if(photo != null){
        fileList[event.index].file  = photo;
      }
    }
    Navigator.pop(event.context);
    isLoader =  false;
    _eventComplete(emit);
  }

  _submitData(AddHydrotestSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddHydroTestHelper.submitData(context: event.context,
        alignmentData: alignmentData,
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        length: lengthController.text.toString(),
        fileList: fileList);
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      activityRemarkController.text = "";
      lengthController.text = "";
      alignmentData =  AlignmentModel();
      isLoader =  false;
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData =  JointTypeModel();
      isJointNumberLoader = false;
      fileList =  await AddHydroTestHelper.fetchFilesData();
      _eventComplete(emit);
    }

  }

  _eventComplete(Emitter<AddHydrotestState>emit) {
    emit(FetchAddHydrotestDataState(isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      alignmentData: alignmentData,
      fileList: fileList,
      weatherData: weatherData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      fromJointData: fromJointData,
      jointFromList: jointFromList,
      jointToList: jointToList,
      lengthController: lengthController,
      toJointData: toJointData,
    ));
  }
}