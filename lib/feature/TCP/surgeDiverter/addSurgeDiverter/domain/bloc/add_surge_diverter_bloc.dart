import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/surgeDiverter/addSurgeDiverter/helper/add_surger_diverter_helper.dart';
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

part 'add_surge_diverter_event.dart';
part 'add_surge_diverter_state.dart';

class AddSurgeDiverterBloc extends Bloc<AddSurgeDiverterEvent, AddSurgeDiverterState> {
  AddSurgeDiverterBloc() : super(AddSurgeDiverterInitial()) {
    on<AddSurgeDiverterPageLoadEvent>(_pageLoadEvent);
    on<AddSurgeDiverterSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddSurgeDiverterTLPTypeEvent>(_selectTLPType);
    on<AddSurgeDiverterInstallationEvent>(_selectInstallation);
    on<AddSurgeDiverterCableConnectionEvent>(_selectCableConnection);
    on<AddSurgeDiverterCableTerminationEvent>(_selectCableTermination);
    on<AddSurgeDiverterBackfillEvent>(_selectBackfill);
    on<AddSurgeDiverterSelectAlignmentEvent>(_selectAlignment);
    on<AddSurgeDiverterAddImageEvent>(_selectFile);
    on<AddSurgeDiverterSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();

  TextEditingController dateController= TextEditingController();
  TextEditingController reportNumberController= TextEditingController();
  TextEditingController areaController= TextEditingController();
  TextEditingController chainageController= TextEditingController();
  TextEditingController locationController= TextEditingController();
  TextEditingController surgeDiverterController= TextEditingController();
  TextEditingController pspReadingProtectionController= TextEditingController();
  TextEditingController pspReadingOtherController= TextEditingController();
  TextEditingController polarityCheckController= TextEditingController();
  TextEditingController activityRemarkController= TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();
  
  VisualChecksModel installationValue = VisualChecksModel();
  List<VisualChecksModel> listOfInstallation = [];
  
  VisualChecksModel cableConnectionValue = VisualChecksModel();
  List<VisualChecksModel> listOfCableConnection = [];
  
  VisualChecksModel cableTerminationValue= VisualChecksModel();
  List<VisualChecksModel> listOfCableTermination = [];
  
  VisualChecksModel backfillValue= VisualChecksModel();
  List<VisualChecksModel> listOfBackfill = [];

  _pageLoadEvent(AddSurgeDiverterPageLoadEvent event, emit) async {
    emit(AddSurgeDiverterPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";
    reportNumberController.text = "";
    areaController.text = "";
    chainageController.text = "";
    locationController.text = "";
    surgeDiverterController.text = "";
    pspReadingProtectionController.text = "";
    polarityCheckController.text = "";
    pspReadingOtherController.text = "";
    activityRemarkController.text = "";
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfInstallation = [];
    listOfCableConnection = [];
    listOfCableTermination = [];
    listOfBackfill = [];
    alignmentData = AlignmentModel();
    weatherData = WeatherModel();
    tlpTypeValue = TlpTypeModel();
    installationValue = VisualChecksModel();
    cableConnectionValue = VisualChecksModel();
    cableTerminationValue= VisualChecksModel();
    backfillValue= VisualChecksModel();
    userData = UserInfo.instanceInit()!.userData!;
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
      listOfInstallation = resVisual;
      listOfCableConnection = listOfInstallation;
      listOfCableTermination = listOfInstallation;
      listOfBackfill = listOfInstallation;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddSurgeDiverterSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }
  _selectTLPType(AddSurgeDiverterTLPTypeEvent event, emit) {
    tlpTypeValue = event.tlpTypeValue;
    _eventComplete(emit);
  }

  _selectInstallation(AddSurgeDiverterInstallationEvent event, emit) {
    installationValue = event.installationValue;
    _eventComplete(emit);
  }

  _selectCableConnection(AddSurgeDiverterCableConnectionEvent event, emit) {
    cableConnectionValue = event.cableConnectionValue;
    _eventComplete(emit);
  }

  _selectCableTermination(AddSurgeDiverterCableTerminationEvent event, emit) {
    cableTerminationValue = event.cableTerminationValue;
    _eventComplete(emit);
  }

  _selectBackfill(AddSurgeDiverterBackfillEvent event, emit) {
    backfillValue = event.backfillValue;
    _eventComplete(emit);
  }

  _selectDate(AddSurgeDiverterSelectDateEvent event, emit) async {
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

  _selectFile(AddSurgeDiverterAddImageEvent event, emit) async {
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

  _submitData(AddSurgeDiverterSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddSurgerDiverterHelper.submitData(
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
        voltage: "",
        properFittingCheck: installationValue,
        cableTermination: cableTerminationValue,
        acVolatgePolarisationCheck: "",
        backfillRestore: backfillValue,
        htTowerFootingDistance: "",
        locationChainage: locationController.text.trim().toString(),
        psp:polarityCheckController.text.trim().toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      dateController.text = "";
      reportNumberController.text = "";
      areaController.text = "";
      chainageController.text = "";
      locationController.text = "";
      surgeDiverterController.text = "";
      pspReadingProtectionController.text = "";
      polarityCheckController.text = "";
      pspReadingOtherController.text = "";
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      weatherData = WeatherModel();
      tlpTypeValue = TlpTypeModel();
      installationValue = VisualChecksModel();
      cableConnectionValue = VisualChecksModel();
      cableTerminationValue= VisualChecksModel();
      backfillValue= VisualChecksModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddSurgeDiverterState> emit) {
    emit(FetchAddSurgeDiverterState(
      alignmentList : alignmentList,
      isLoader : isLoader,
      alignmentData : alignmentData,
      file : file,
      weatherList : weatherList,
      weatherData : weatherData,
      listOfTLPType : listOfTLPType,
      tlpTypeValue : tlpTypeValue,
      installationValue : installationValue,
      listOfInstallation : listOfInstallation,
      cableConnectionValue : cableConnectionValue,
      listOfCableConnection : listOfCableConnection,
      cableTerminationValue :cableTerminationValue,
      listOfCableTermination : listOfCableTermination,
      backfillValue : backfillValue,
      listOfBackfill  : listOfBackfill,
      dateController : dateController,
      reportNumberController : reportNumberController,
      areaController : areaController,
      chainageController : chainageController,
      locationController : locationController,
      surgeDiverterController : surgeDiverterController,
      pspReadingProtectionController : pspReadingProtectionController,
      pspReadingOtherController : pspReadingOtherController,
      polarityCheckController : polarityCheckController,
      activityRemarkController : activityRemarkController,

    ));
  }
}
