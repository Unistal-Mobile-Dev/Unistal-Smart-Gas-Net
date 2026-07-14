import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dashboard/helper/dashboard_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/domain/model/marker_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/markerInstallation/addMarkerInstallation/helper/add_marker_installation_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';
part 'add_marker_installation_event.dart';
part 'add_marker_installation_state.dart';

class AddMarkerInstallationBloc extends Bloc<AddMarkerInstallationEvent, AddMarkerInstallationState> {
  AddMarkerInstallationBloc() : super(AddMarkerInstallationInitial()) {
    on<AddMarkerInstallationPageLoadEvent>(_pageLoadEvent);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddMarkerInstallationSelectAlignmentEvent>(_selectAlignment);
    on<AddMarkerInstallationMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<SelectJointEvent>(_selectJoint);
    on<SelectMarkerTypeEvent>(_selectMarkerType);
    on<AddMarkerInstallationSelectDateEvent>(_selectDate);
    on<AddMarkerInstallationAddImageEvent>(_selectFile);
    on<AddMarkerInstallationSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();


  List<JointNumberModel> listOfJoint = [];
  List<JointTypeModel> listOfJointType = [];
  List<MarkerTypeModel> listOfMarkerType = [];

  JointNumberModel jointValue = JointNumberModel();
  JointTypeModel jointTypeDataValue = JointTypeModel();
  MarkerTypeModel markerTypeDataValue = MarkerTypeModel();

  _pageLoadEvent(AddMarkerInstallationPageLoadEvent event, emit) async {
    emit(AddMarkerInstallationPageLoadState());
    isLoader = false;
    file = File("");
    dateController.text = "";

    reportNumberController.text = "";
    chainageController.text = "";
    descriptionController.text = "";
    activityRemarkController.text = "";
    listOfJointType = [];
    listOfJoint = [];
    alignmentList = [];
    listOfMarkerType = [];
    markerTypeDataValue = MarkerTypeModel();
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    weatherData = WeatherModel();
    jointValue = JointNumberModel();
    jointTypeDataValue = JointTypeModel();
    weatherData = WeatherModel();
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData();
    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }

    var resJointNumber = await DashboardHelper.fetchJointNumberData(
      type:  AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
          ? AppConfig.instanceInit()!.activitySectionData.appJoint!
          : "afterwelding",);
    if (resJointNumber != null) {
      listOfJoint = resJointNumber;
    }

    var resMarkerType = await DashboardHelper.fetchMarkerType();
    if (resJointNumber != null) {
      listOfMarkerType = resMarkerType ?? [];
    }

    var resJointType = await DashboardHelper.fetchJointType();
    if (resJointType != null) {
      listOfJointType = resJointType;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddMarkerInstallationSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddMarkerInstallationMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectDate(AddMarkerInstallationSelectDateEvent event, emit) async {
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

  _selectJoint(SelectJointEvent event, emit) {
    jointValue = event.jointValue;
    _eventComplete(emit);
  }

  _selectMarkerType(SelectMarkerTypeEvent event, emit) {
    markerTypeDataValue = event.markerTypeValue;
    _eventComplete(emit);
  }

  _selectFile(AddMarkerInstallationAddImageEvent event, emit) async {
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

  _submitData(AddMarkerInstallationSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddMarkerInstallationHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      jointData: jointValue,
      chainage: chainageController.text.trim().toString(),
      description: descriptionController.text.trim().toString(),
      markerTypeDataValue :markerTypeDataValue,

    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      dateController.text = "";
      reportNumberController.text = "";
      chainageController.text = "";
      descriptionController.text = "";
      activityRemarkController.text = "";
      markerTypeDataValue = MarkerTypeModel();
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      weatherData = WeatherModel();
      jointValue = JointNumberModel();
      jointTypeDataValue = JointTypeModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddMarkerInstallationState> emit) {
    emit(FetchAddMarkerInstallationDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      jointValue: jointValue,
      listOfJoint: listOfJoint,
      dateController : dateController,
      reportNumberController : reportNumberController,
      chainageController : chainageController,
      descriptionController : descriptionController,
      activityRemarkController : activityRemarkController,
      jointTypeDataValue: jointTypeDataValue,
      listOfJointType: listOfJointType,
      markerTypeDataValue: markerTypeDataValue,
      listOfMarkerType: listOfMarkerType,
    ));
  }
}


