import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/helper/add_back_filling_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_back_filling_event.dart';
part 'add_back_filling_state.dart';

class AddBackFillingBloc extends Bloc<AddBackFillingEvent, AddBackFillingState> {

  TextEditingController dateController =  TextEditingController();
  TextEditingController reportNumberController =  TextEditingController();
  TextEditingController activityRemarkController =  TextEditingController();
  TextEditingController chainageFromController =  TextEditingController();
  TextEditingController chainageToController =  TextEditingController();
  TextEditingController postPaddingController =  TextEditingController();
  TextEditingController slopeBreakerController =  TextEditingController();
  TextEditingController warningMatController =  TextEditingController();
  TextEditingController antiBuoyancyController =  TextEditingController();

  List<VisualChecksModel> plasticGratingList = [];
  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel  alignmentData =  AlignmentModel();
  bool isLoader =  false;
  VisualChecksModel plasticGratingData = VisualChecksModel();
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData =  JointTypeModel();
  bool isJointNumberLoader = false;
  File file =  File("");
  WeatherModel weatherData =  WeatherModel();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;


  AddBackFillingBloc() : super(AddBackFillingInitial()) {
    on<AddBackFillingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddBackFillingSelectAlignmentEvent>(_selectAlignment);
    on<AddBackFillingSelectPlasticGratingEvent>(_selectPlasticGratingData);
    on<AddBackFillingSelectFromJointDataEvent>(_selectJointFrom);
    on<AddBackFillingSelectToJointDataEvent>(_selectJointTo);
    on<AddBackFillingSelectJointTypeDataEvent>(_selectJointType);
    on<AddBackFillingSelectDateEvent>(_selectDate);
    on<AddBackFillingAddImageEvent>(_selectFile);
    on<AddBackFillingSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddBackFillingPageLoadEvent event, emit) async {
      emit(AddBackFillingPageLoadState());
        dateController.text = "";
        reportNumberController.text = "";
        activityRemarkController.text = "";
        chainageFromController.text = "";
        chainageToController.text = "";
        postPaddingController.text = "";
        slopeBreakerController.text = "";
        warningMatController.text = "";
        antiBuoyancyController.text = "";
        plasticGratingList = [];
        jointFromList = [];
        jointToList = [];
        jointTypeList = [];
        weatherList = [];
        alignmentList = [];
        alignmentData =  AlignmentModel();
        isLoader =  false;
        plasticGratingData = VisualChecksModel();
        fromJointData = JointNumberModel();
        toJointData = JointNumberModel();
        jointTypeData =  JointTypeModel();
        isJointNumberLoader = false;
        file =  File("");
        weatherData =  WeatherModel();
        weatherList =  WeatherModel.getWeatherData();
        _userData =  UserInfo.instanceInit()!.userData!;

        var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: event.context, userData: userData);
        if(res != null){
          alignmentList =  res;
        }

      var resJointType =  await AddWeldingHelper.fetchJointType(context: event.context, userData: userData);
      if(resJointType != null){
        jointTypeList =  resJointType;
      }

        var resPlasticGrating =  await AddBendingHelper.fetchVisualChecks(context: event.context);
        if(resPlasticGrating != null){
          plasticGratingList =  resPlasticGrating;
        }

     _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddBackFillingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectPlasticGratingData(AddBackFillingSelectPlasticGratingEvent event, emit) {
    plasticGratingData = event.plasticGratingData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddBackFillingSelectFromJointDataEvent event, emit) {
    fromJointData =  event.jointNumberData;
     _eventComplete(emit);
  }

  _selectJointTo(AddBackFillingSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddBackFillingSelectJointTypeDataEvent event, emit) async {
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

  _selectDate(AddBackFillingSelectDateEvent event, emit) async {
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

  _selectFile(AddBackFillingAddImageEvent event, emit) async {
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

    _eventComplete(emit);
  }

  _submitData(AddBackFillingSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddBackFillingHelper.submitData(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        plasticGrating: plasticGratingData,
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        warningMat: warningMatController.text.toString(),
        slopeBreaker: slopeBreakerController.text.toString(),
        postPadding: postPaddingController.text.toString(),
        antiBuoyancy: antiBuoyancyController.text.toString(),
        file: file);
     isLoader =  false;
     _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      postPaddingController.text = "";
      slopeBreakerController.text = "";
      warningMatController.text = "";
      antiBuoyancyController.text = "";
      alignmentData =  AlignmentModel();
      isLoader =  false;
      plasticGratingData = VisualChecksModel();
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData =  JointTypeModel();
      isJointNumberLoader = false;
      file =  File("");
      weatherData =  WeatherModel();
      _eventComplete(emit);
    }
  }
  
  _eventComplete(Emitter<AddBackFillingState>emit) {
    emit(FetchAddBackFillingDataState(isLoader: isLoader, 
        alignmentList: alignmentList, 
        dateController: dateController, 
        activityRemarkController: activityRemarkController,
        reportNumberController: reportNumberController, 
        chainageFromController: chainageFromController,
        chainageToController: chainageToController,
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
        plasticGratingData: plasticGratingData, 
        plasticGratingList: plasticGratingList,
        postPaddingController: postPaddingController,
        slopeBreakerController: slopeBreakerController, 
        toJointData: toJointData, 
        warningMatController: warningMatController,
        antiBuoyancyController: antiBuoyancyController,
    ));
  }


}
