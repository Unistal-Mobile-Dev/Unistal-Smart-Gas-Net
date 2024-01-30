import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/hepler/add_tren_ching_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_tren_ching_event.dart';
part 'add_tren_ching_state.dart';

class AddTrenChingBloc extends Bloc<AddTrenChingEvent, AddTrenChingState> {

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  List<AlignmentModel> _alignmentList = [];
  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData =  AlignmentModel();
  AlignmentModel get alignmentData => _alignmentData;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController toJointIdController = TextEditingController();
  TextEditingController trenchingDepthController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController fromJointIdController = TextEditingController();
  TextEditingController terrainController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  List<JointNumberModel>  _jointNumberList =  [];
  List<JointNumberModel>  get jointNumberList => _jointNumberList;

  JointNumberModel _jointNumberData =  JointNumberModel();
  JointNumberModel get jointNumberData => _jointNumberData;

  File file = File("");

  List<WeatherModel> _weatherList = [];
  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData =  WeatherModel();
  WeatherModel get weatherData => _weatherData;

  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];

  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData =  JointTypeModel();
  bool isJointNumberLoader = false;

  TextEditingController chainageFromController =  TextEditingController();
  TextEditingController chainageToController =  TextEditingController();

  AddTrenChingBloc() : super(AddTrenChingInitial()) {
    on<AddTrenChingPageLoadEvent>(_pageLoadEvent);
    on<AddTrenChingSelectAlignmentEvent>(_selectAlignment);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddTrenChingSelectDateEvent>(_selectDate);
    on<AddTrenChingAddImageEvent>(_selectFile);
    on<AddTrenChingSelectFromJointDataEvent>(_selectJointFrom);
    on<AddTrenChingSelectToJointDataEvent>(_selectJointTo);
    on<AddTrenChingSelectJointTypeDataEvent>(_selectJointType);
    on<AddTrenChingSubmitDataEvent>(_submitData);
  }

  _pageLoadEvent(AddTrenChingPageLoadEvent event, emit) async {
    emit(AddTrenChingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    fromJointIdController.text = "";
    toJointIdController.text = "";
    tpRemarkNumberController.text = "";
    trenchingDepthController.text = "";
    terrainController.text = "";
    activityRemarkController.text = "";
    _isLoader =  false;
    _alignmentList =  [];
    file = File("");
    _weatherData = WeatherModel();
    _weatherList = WeatherModel.getWeatherData();
    _alignmentData =  AlignmentModel();
    _jointNumberData =  JointNumberModel();
    _jointNumberList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData =  JointTypeModel();
    isJointNumberLoader = false;
    chainageFromController.text = "";
    chainageToController.text = "";
    _userData =  UserInfo.instanceInit()!.userData!;
    var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: event.context, userData: userData);
    if(res != null){
      _alignmentList =  res;
    }

    var resJointType =  await AddWeldingHelper.fetchJointType(context: event.context, userData: userData);
    if(resJointType != null){
      jointTypeList =  resJointType;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddTrenChingSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddTrenChingSelectDateEvent event, emit) async {
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

  _selectJointFrom(AddTrenChingSelectFromJointDataEvent event, emit) {
    fromJointData =  event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddTrenChingSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddTrenChingSelectJointTypeDataEvent event, emit) async {
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

  _selectFile(AddTrenChingAddImageEvent event, emit) async {
    var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
    if(photo != null){
      file  = photo;
    }
    _eventComplete(emit);
  }

  _submitData(AddTrenChingSubmitDataEvent event, emit) async {
/*    var textFiledValidation =  await AddTrenChingHelper.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        fromJointId: fromJointIdController.text.toString(),
        toJointId: toJointIdController.text.toString(),
        trenchingDepth:trenchingDepthController.text.toString(),
        terrainType: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString()
    );
    if(textFiledValidation == false){
      return;
    }*/
    _isLoader =  true;
    _eventComplete(emit);
    var res =  await AddTrenChingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        jointNumberFromModel: fromJointData,
        jointNumberToModel: toJointData,
        trenchingDepth:trenchingDepthController.text.toString(),
        terrainType: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData, file: file,
        weatherData: weatherData,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
    );
    _isLoader =  false;
    _eventComplete(emit);
    if(res != null){
      dateController.text = "";
      reportNumberController.text = "";
      fromJointIdController.text = "";
      toJointIdController.text = "";
      tpRemarkNumberController.text = "";
      terrainController.text = "";
      trenchingDepthController.text = "";
      activityRemarkController.text = "";
      _isLoader =  false;
      _alignmentData =  AlignmentModel();
      file =  File("");
      chainageFromController.text = "";
      chainageToController.text = "";
      _weatherData =  WeatherModel();
      fromJointData =  JointNumberModel();
      toJointData =  JointNumberModel();
      jointTypeData =  JointTypeModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddTrenChingState>emit) {
    emit(FetchAddTrenChingDataState(isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      fromJointIdController: fromJointIdController,
      reportNumberController: reportNumberController,
      terrainController: terrainController,
      toJointIdController: toJointIdController,
      trenchingDepthController: trenchingDepthController,
      alignmentData: alignmentData,
      file: file,
      jointNumberList: jointNumberList,
      jointNumberData: jointNumberData,
      weatherData:  weatherData,
      weatherList:  weatherList,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      fromJointData: fromJointData,
      jointFromList: jointFromList,
      jointToList: jointToList,
      toJointData: toJointData,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
    ));
  }
}
