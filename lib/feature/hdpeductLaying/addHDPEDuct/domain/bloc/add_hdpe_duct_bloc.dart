import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_hdpe_duct_event.dart';
part 'add_hdpe_duct_state.dart';

class AddHdpeDuctBloc extends Bloc<AddHdpeDuctEvent, AddHdpeDuctState> {

  TextEditingController dateController =  TextEditingController();
  TextEditingController reportNumberController =  TextEditingController();
  TextEditingController activityRemarkController =  TextEditingController();
  TextEditingController chainageFromController =  TextEditingController();
  TextEditingController chainageToController =  TextEditingController();
  TextEditingController jointPitController =  TextEditingController();
  TextEditingController lengthController =  TextEditingController();

  List<PaddingModel> warningMeterList = [];
  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];
  List<PaddingModel> paddingList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel  alignmentData =  AlignmentModel();
  bool isLoader =  false;
  PaddingModel warningMeterData = PaddingModel();
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData =  JointTypeModel();
  bool isJointNumberLoader = false;
  File file =  File("");
  WeatherModel weatherData =  WeatherModel();
  PaddingModel paddingData =  PaddingModel();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;


  AddHdpeDuctBloc() : super(AddHdpeDuctInitial()) {
    on<AddHdpeDuctPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddHdpeDuctSelectAlignmentEvent>(_selectAlignment);
    on<AddHdpeDuctSelectPaddingDataEvent>(_selectPaddingData);
    on<AddHdpeDuctSelectFromJointDataEvent>(_selectJointFrom);
    on<AddHdpeDuctSelectToJointDataEvent>(_selectJointTo);
    on<AddHdpeDuctSelectJointTypeDataEvent>(_selectJointType);
    on<AddHdpeDuctSelectWarningMeterDataEvent>(_selectWarningData);
    on<AddHdpeDuctSelectDateEvent>(_selectDate);
    on<AddHdpeDuctAddImageEvent>(_selectFile);
    on<AddHdpeDuctSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddHdpeDuctPageLoadEvent event, emit) async {
    emit(AddHdpeDuctPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    jointPitController.text = "";
    lengthController.text = "";
    warningMeterList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData =  AlignmentModel();
    isLoader =  false;
    warningMeterData = PaddingModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData =  JointTypeModel();
    isJointNumberLoader = false;
    file =  File("");
    weatherData =  WeatherModel();
    paddingList = [];
    paddingData =  PaddingModel();
     _userData =  UserInfo.instanceInit()!.userData!;
    weatherList =  await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);

    var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: event.context, userData: userData);
    if(res != null){
      alignmentList =  res;
    }

    var resJointType =  await AddWeldingHelper.fetchJointType(context: event.context, userData: userData);
    if(resJointType != null){
      jointTypeList =  resJointType;
    }

    var resPadding =  await AddHDPEDuctHelper.fetchPaddingData(context: event.context);
    if(resPadding != null){
      paddingList =  resPadding;
      warningMeterList = paddingList;
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddHdpeDuctSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectPaddingData(AddHdpeDuctSelectPaddingDataEvent event, emit) {
    paddingData = event.paddingData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddHdpeDuctSelectFromJointDataEvent event, emit) {
    fromJointData =  event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddHdpeDuctSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectWarningData(AddHdpeDuctSelectWarningMeterDataEvent event, emit) {
    warningMeterData =  event.warningMeterData;
    _eventComplete(emit);
  }

  _selectJointType(AddHdpeDuctSelectJointTypeDataEvent event, emit) async {
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

  _selectDate(AddHdpeDuctSelectDateEvent event, emit) async {
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

  _selectFile(AddHdpeDuctAddImageEvent event, emit) async {
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

  _submitData(AddHdpeDuctSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddHDPEDuctHelper.submitData(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        warningMeterData: warningMeterData,
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        jointPit: jointPitController.text.toString(),
        paddingData: paddingData,
        length: lengthController.text.toString(),
        file: file);
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      jointPitController.text = "";
      lengthController.text = "";
      alignmentData =  AlignmentModel();
      isLoader =  false;
      warningMeterData = PaddingModel();
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData =  JointTypeModel();
      isJointNumberLoader = false;
      file =  File("");
      weatherData =  WeatherModel();
      paddingData =  PaddingModel();
      _eventComplete(emit);
    }
  }
  
  _eventComplete(Emitter<AddHdpeDuctState>emit) {
    emit(FetchAddHdpeDuctDataState(isLoader: isLoader,
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
        warningMeterData: warningMeterData,
        warningMeterList: warningMeterList,
        jointPitController: jointPitController,
        lengthController: lengthController,
        toJointData: toJointData,
        paddingList: paddingList,
        paddingData: paddingData,
    ));
  }
}
