import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/ssd/addSSD/helper/add_ssd_helper.dart';
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

part 'add_ssd_event.dart';
part 'add_ssd_state.dart';

class AddSsdBloc extends Bloc<AddSsdEvent, AddSsdState> {
  AddSsdBloc() : super(AddSsdInitial()) {
    on<AddSsdPageLoadEvent>(_pageLoadEvent);
    on<AddSsdSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddSsdTLPTypeEvent>(_selectTlpType);
    on<AddSsdInstallationEvent>(_selectInstallation);
    on<AddSsdCableTerminationEvent>(_selectCableTermination);
    on<AddSsdCheckACVolEvent>(_selectCheckACVol);
    on<AddSsdFinalRestorationEvent>(_selectFinalRestoration);
    on<AddSsdPSPEvent>(_selectPspValue);
    on<AddSsdSelectAlignmentEvent>(_selectAlignment);
    on<AddSsdMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddSsdAddImageEvent>(_selectFile);
    on<AddSsdSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController= TextEditingController();
  TextEditingController reportNumberController= TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController locationController= TextEditingController();
  TextEditingController voltageController= TextEditingController();
  TextEditingController htTowerController= TextEditingController();
  TextEditingController activityRemarkController= TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();

  VisualChecksModel installationValue = VisualChecksModel();
  List<VisualChecksModel> listOfInstallation = [];

  VisualChecksModel cableTerminationValue = VisualChecksModel();
  List<VisualChecksModel> listOfCableTermination = [];

  VisualChecksModel checkACVolValue = VisualChecksModel();
  List<VisualChecksModel> listOfCheckACVol = [];

  VisualChecksModel pspValue = VisualChecksModel();
  List<VisualChecksModel> listOfPSP = [];

  VisualChecksModel finalRestorationValue = VisualChecksModel();
  List<VisualChecksModel> listOfFinalRestoration = [];

  _pageLoadEvent(AddSsdPageLoadEvent event, emit) async {
    emit(AddSsdPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    reportNumberController.text = "";
    chainageController.text = "";
    areaController.text = "";
    locationController.text = "";
    voltageController.text = "";
    htTowerController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfInstallation = [];
    listOfCableTermination = [];
    listOfCheckACVol = [];
    listOfPSP = [];
    listOfFinalRestoration = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    weatherData = WeatherModel();
    tlpTypeValue = TlpTypeModel();
    installationValue = VisualChecksModel();
    cableTerminationValue = VisualChecksModel();
    checkACVolValue = VisualChecksModel();
    pspValue = VisualChecksModel();
    finalRestorationValue = VisualChecksModel();
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData();
    userData = UserInfo.instanceInit()!.userData!;
    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }
    var resTLPType = await AddTestStationBoxHelper.fetchTLPType();
    if (resTLPType != null) {
      listOfTLPType = resTLPType;
    }
    var resVisual = await AddBendingHelper.fetchVisualChecks();
    if (resVisual != null) {
      listOfInstallation = resVisual;
      listOfCableTermination = listOfInstallation;
      listOfCheckACVol = listOfInstallation;
      listOfPSP = listOfInstallation;
      listOfFinalRestoration = listOfInstallation;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddSsdSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddSsdMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }



  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectTlpType(AddSsdTLPTypeEvent event, emit) {
    tlpTypeValue = event.tlpTypeValue;
    _eventComplete(emit);
  }

  _selectInstallation(AddSsdInstallationEvent event, emit) {
    installationValue = event.installationValue;
    _eventComplete(emit);
  }

  _selectPspValue(AddSsdPSPEvent event, emit) {
    pspValue = event.pspValue;
    _eventComplete(emit);
  }

  _selectCableTermination(AddSsdCableTerminationEvent event, emit) {
    cableTerminationValue = event.cableTerminationValue;
    _eventComplete(emit);
  }

  _selectCheckACVol(AddSsdCheckACVolEvent event,emit) {
    checkACVolValue = event.checkACVolValue;
    _eventComplete(emit);
  }

  _selectFinalRestoration(AddSsdFinalRestorationEvent event, emit) {
    finalRestorationValue = event.finalRestorationValue;
    _eventComplete(emit);
  }

  _selectDate(AddSsdSelectDateEvent event, emit) async {
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

  _selectFile(AddSsdAddImageEvent event, emit) async {
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

  _submitData(AddSsdSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddSSDHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      area: areaController.text.trim().toString(),
      tlpTypeId: tlpTypeValue,
      chainage: chainageController.text.trim().toString(),
      voltage: voltageController.text.trim().toString(),
      properFittingCheck: installationValue,
      cableTermination: cableTerminationValue,
      acVolatgePolarisationCheck: checkACVolValue,
      backfillRestore: finalRestorationValue,
      htTowerFootingDistance: htTowerController.text.trim().toString(),
      locationChainage: locationController.text.trim().toString(),
      psp:pspValue
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      dateController.text = "";
      reportNumberController.text = "";
      chainageController.text = "";
      areaController.text = "";
      locationController.text = "";
      voltageController.text = "";
      htTowerController.text = "";
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      weatherData = WeatherModel();
      tlpTypeValue = TlpTypeModel();
      installationValue = VisualChecksModel();
      cableTerminationValue = VisualChecksModel();
      checkACVolValue = VisualChecksModel();
      pspValue = VisualChecksModel();
      finalRestorationValue = VisualChecksModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddSsdState> emit) {
    emit(FetchAddSsdState(
      isLoader : isLoader,
      alignmentList : alignmentList,
      alignmentData : alignmentData,
      multipleAlignmentData : multipleAlignmentData,
      file : file,
      weatherList : weatherList,
      weatherData : weatherData,
      listOfTLPType : listOfTLPType,
      tlpTypeValue : tlpTypeValue,
      installationValue : installationValue,
      listOfInstallation : listOfInstallation,
      cableTerminationValue : cableTerminationValue,
      listOfCableTermination : listOfCableTermination,
      checkACVolValue : checkACVolValue,
      listOfCheckACVol : listOfCheckACVol,
      pspValue : pspValue,
      listOfPSP : listOfPSP,
      finalRestorationValue : finalRestorationValue,
      listOfFinalRestoration : listOfFinalRestoration,
      dateController : dateController,
      reportNumberController : reportNumberController,
      chainageController: chainageController,
      areaController: areaController,
      locationController : locationController,
      voltageController : voltageController,
      htTowerController : htTowerController,
      activityRemarkController : activityRemarkController,
    ));
  }
}