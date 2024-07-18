import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

part 'add_polarisation_coupan_event.dart';
part 'add_polarisation_coupan_state.dart';

class AddPolarisationCoupanBloc extends Bloc<AddPolarisationCoupanEvent, AddPolarisationCoupanState> {
  AddPolarisationCoupanBloc() : super(AddPolarisationCoupanInitial()) {
    on<AddPolarisationCoupanPageLoadEvent>(_pageLoadEvent);
    on<AddPolarisationCoupanSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddPolarisationCoupanTLPTypeEvent>(_selectTLPType);
    on<AddPolarisationCoupanCorrosionEvent>(_selectCorrosion);
    on<AddPolarisationCoupanCableTerminationEvent>(_selectCableTermination);
    on<AddPolarisationCoupanDateCalibrationEvent>(_selectDateCalibration);
    on<AddPolarisationCoupanSelectAlignmentEvent>(_selectAlignment);
    on<AddPolarisationCoupanAddImageEvent>(_selectFile);
    on<AddPolarisationCoupanSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();

  TextEditingController dateController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController testStationLocationController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController pspMeasurementController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  TextEditingController digitalController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController dateCalibrationController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();
  
  VisualChecksModel corrosionValue = VisualChecksModel();
  List<VisualChecksModel> listOfCorrosion = [];
  
  VisualChecksModel cableTerminationValue =VisualChecksModel();
  List<VisualChecksModel> listOfCableTermination = [];

  _pageLoadEvent(AddPolarisationCoupanPageLoadEvent event, emit) async {
    emit(AddPolarisationCoupanPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    chainageController.text = "";
    areaController.text = "";
    testStationLocationController.text = "";
    distanceController.text = "";
    pspMeasurementController.text = "";
    couponController.text = "";
    digitalController.text = "";
    modelController.text = "";
    makeController.text = "";
    dateCalibrationController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfCorrosion = [];
    listOfCableTermination = [];
    alignmentData = AlignmentModel();
    weatherData = WeatherModel();
    tlpTypeValue = TlpTypeModel();
    corrosionValue = VisualChecksModel();
    cableTerminationValue = VisualChecksModel();
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
      listOfCorrosion = resVisual;
      listOfCableTermination = listOfCorrosion;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddPolarisationCoupanSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

 _selectTLPType(AddPolarisationCoupanTLPTypeEvent event, emit) {
    tlpTypeValue = event.tlpTypeValue;
    _eventComplete(emit);
  }

 _selectCorrosion(AddPolarisationCoupanCorrosionEvent event, emit) {
   corrosionValue = event.corrosionValue;
   _eventComplete(emit);
  }

 _selectCableTermination(AddPolarisationCoupanCableTerminationEvent event, emit) {
   cableTerminationValue = event.cableTerminationValue;
   _eventComplete(emit);
  }

 _selectDateCalibration(AddPolarisationCoupanDateCalibrationEvent event, emit) async {
   DateTime? pickedDate = await showDatePicker(
       context: event.context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2023),
       lastDate: DateTime.now());

   if (pickedDate != null) {
     String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
     dateCalibrationController.text = formattedDateChange.toString();
     _eventComplete(emit);
   } else {
     if (kDebugMode) {
       print("Date is not selected");
     }
   }
  }

  _selectDate(AddPolarisationCoupanSelectDateEvent event, emit) async {
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

  _selectFile(AddPolarisationCoupanAddImageEvent event, emit) async {
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

  _submitData(AddPolarisationCoupanSubmitDataEvent event, emit) async {
  }

  _eventComplete(Emitter<AddPolarisationCoupanState> emit) {
    emit(FetchAddPolarisationCoupanState(
      alignmentList : alignmentList,
      isLoader : isLoader,
      alignmentData : alignmentData,
      file : file,
      weatherList : weatherList,
      weatherData : weatherData,
      listOfTLPType : listOfTLPType,
      tlpTypeValue : tlpTypeValue,
      corrosionValue : corrosionValue,
      listOfCorrosion : listOfCorrosion,
      cableTerminationValue : cableTerminationValue,
      listOfCableTermination : listOfCableTermination,
      dateController : dateController,
      chainageController : chainageController,
      areaController : areaController,
      testStationLocationController : testStationLocationController,
      distanceController : distanceController,
      pspMeasurementController : pspMeasurementController,
      couponController : couponController,
      digitalController : digitalController,
      modelController : modelController,
      makeController : makeController,
      dateCalibrationController : dateCalibrationController,
      reportNumberController : reportNumberController,
      activityRemarkController : activityRemarkController,
    ));
  }
}
