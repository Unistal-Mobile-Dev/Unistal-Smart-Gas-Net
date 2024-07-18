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

part 'add_thermit_weld_event.dart';
part 'add_thermit_weld_state.dart';

class AddThermitWeldBloc extends Bloc<AddThermitWeldEvent, AddThermitWeldState> {
  AddThermitWeldBloc() : super(AddThermitWeldInitial()) {
    on<AddThermitWeldPageLoadEvent>(_pageLoadEvent);
    on<AddThermitWeldSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddTestStationBoxTLPTypeEvent>(_selectTLPType);
    on<AddTestStationBoxPinBrazingEvent>(_selectPinBrazing);
    on<AddTestStationBoxContinuityCheckEvent>(_selectContinuityCheck);
    on<AddTestStationBoxRestorationCheckEvent>(_selectRestorationCheck);
    on<AddThermitWeldSelectAlignmentEvent>(_selectAlignment);
    on<AddThermitWeldAddImageEvent>(_selectFile);
    on<AddThermitWeldSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();

 

  TextEditingController dateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController testStationLocationController = TextEditingController();
  TextEditingController testStationTypeController = TextEditingController();
  TextEditingController spacingController = TextEditingController();
  TextEditingController cableController = TextEditingController();
  TextEditingController epoxyController = TextEditingController();
  TextEditingController cableSizeController = TextEditingController();
  TextEditingController cableLengthController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();
  
  VisualChecksModel pinBrazingValue = VisualChecksModel();
  List<VisualChecksModel> listOfPinBrazing = [];
  
  VisualChecksModel continuityCheckValue = VisualChecksModel();
  List<VisualChecksModel> listOfContinuityCheck = [];
  
  VisualChecksModel restorationCheckValue = VisualChecksModel();
  List<VisualChecksModel> listOfRestorationCheck = [];

  _pageLoadEvent(AddThermitWeldPageLoadEvent event, emit) async {
    emit(AddThermitWeldPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfPinBrazing = [];
    listOfContinuityCheck = [];
    listOfRestorationCheck = [];
    alignmentData = AlignmentModel();
    weatherData = WeatherModel();
    tlpTypeValue = TlpTypeModel();
    pinBrazingValue = VisualChecksModel();
    continuityCheckValue = VisualChecksModel();
    restorationCheckValue = VisualChecksModel();
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
      listOfPinBrazing = resVisual;
      listOfContinuityCheck = listOfPinBrazing;
      listOfRestorationCheck = listOfPinBrazing;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddThermitWeldSelectAlignmentEvent event, emit) {
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

  _selectPinBrazing(AddTestStationBoxPinBrazingEvent event, emit) {
    pinBrazingValue = event.pinBrazingValue;
    _eventComplete(emit);
  }

  _selectContinuityCheck(AddTestStationBoxContinuityCheckEvent event, emit) {
    continuityCheckValue = event.continuityCheckValue;
    _eventComplete(emit);
  }

  _selectRestorationCheck(AddTestStationBoxRestorationCheckEvent event, emit) {
    restorationCheckValue = event.restorationCheckValue;
    _eventComplete(emit);
  }

  _selectDate(AddThermitWeldSelectDateEvent event, emit) async {
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

  _selectFile(AddThermitWeldAddImageEvent event, emit) async {
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

  _submitData(AddThermitWeldSubmitDataEvent event, emit) async {
  }

  _eventComplete(Emitter<AddThermitWeldState> emit) {
    emit(FetchAddThermitWeldState(
      file : file,
      isLoader : isLoader,
      alignmentData : alignmentData,
      alignmentList : alignmentList,
      weatherList : weatherList,
      weatherData : weatherData,
      listOfTLPType : listOfTLPType,
      tlpTypeValue :tlpTypeValue ,
      pinBrazingValue : pinBrazingValue,
      listOfPinBrazing : listOfPinBrazing,
      continuityCheckValue : continuityCheckValue,
      listOfContinuityCheck : listOfContinuityCheck,
      restorationCheckValue : restorationCheckValue,
      listOfRestorationCheck : listOfRestorationCheck,
      dateController : dateController,
      areaController : areaController,
      chainageController : chainageController,
      testStationLocationController : testStationLocationController,
      testStationTypeController : testStationTypeController,
      spacingController : spacingController,
      cableController : cableController,
      epoxyController : epoxyController,
      cableSizeController : cableSizeController,
      cableLengthController : cableLengthController,
      reportNumberController : reportNumberController,
      activityRemarkController : activityRemarkController,

    ));
  }
}