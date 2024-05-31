import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/soilResistivity/addSoilResistivity/helper/add_soil_resistivity_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_soil_resistivity_event.dart';

part 'add_soil_resistivity_state.dart';

class AddSoilResistivityBloc
    extends Bloc<AddSoilResistivityEvent, AddSoilResistivityState> {
  bool _isLoader = false;

  bool get isLoader => _isLoader;

  List<AlignmentModel> _alignmentList = [];

  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData = AlignmentModel();

  AlignmentModel get alignmentData => _alignmentData;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController tpChainageController = TextEditingController();
  TextEditingController tpChainageNumberController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController bearingAngleController = TextEditingController();
  TextEditingController terrainController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  File file = File("");

  AddSoilResistivityBloc() : super(AddSoilResistivityInitial()) {
    on<AddSoilResistivityPageLoadEvent>(_pageLoadEvent);
    on<AddSoilResistivitySubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddSoilResistivitySelectAlignmentEvent>(_selectAlignment);
    on<AddSoilResistivitySelectDateEvent>(_selectDate);
    on<AddSoilResistivityAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddSoilResistivityPageLoadEvent event, emit) async {
    emit(AddSoilResistivityPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    tpChainageController.text = "";
    tpChainageNumberController.text = "";
    tpRemarkNumberController.text = "";
    bearingAngleController.text = "";
    terrainController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    _isLoader = false;
    _alignmentList = [];
    file = File("");
    _alignmentData = AlignmentModel();
    _weatherData = WeatherModel();
    _userData = UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);
    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: event.context, userData: userData);
    if (res != null) {
      _alignmentList = res;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddSoilResistivitySelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectDate(AddSoilResistivitySelectDateEvent event, emit) async {
    DateTime firstDayCurrentMonth = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
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
      print("Date is not selected");
    }
  }

  _selectFile(AddSoilResistivityAddImageEvent event, emit) async {
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
    Navigator.pop(event.context);
    _eventComplete(emit);
  }

  _submitData(AddSoilResistivitySubmitDataEvent event, emit) async {
/*    var textFiledValidation =  await AddSoilResistivityHelper.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        tpIpChainage: tpChainageController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark:tpRemarkNumberController.text.toString(),
        bearing: bearingAngleController.text.toString(),
        terrain: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString());
    if(textFiledValidation == false){
      return;
    }*/
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddSoilResistivityHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        tpIpChainage: tpChainageController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark: tpRemarkNumberController.text.toString(),
        bearing: bearingAngleController.text.toString(),
        terrain: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData,
        file: file,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        weatherData: weatherData);
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      tpChainageController.text = "";
      tpChainageNumberController.text = "";
      tpRemarkNumberController.text = "";
      bearingAngleController.text = "";
      terrainController.text = "";
      activityRemarkController.text = "";
      _isLoader = false;
      _alignmentData = AlignmentModel();
      file = File("");
      chainageFromController.text = "";
      chainageToController.text = "";
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddSoilResistivityState> emit) {
    emit(FetchAddSoilResistivityDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      bearingAngleController: bearingAngleController,
      reportNumberController: reportNumberController,
      terrainController: terrainController,
      tpChainageController: tpChainageController,
      tpChainageNumberController: tpChainageNumberController,
      tpRemarkNumberController: tpRemarkNumberController,
      alignmentData: alignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
    ));
  }
}
