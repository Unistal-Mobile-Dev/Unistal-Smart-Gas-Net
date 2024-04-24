import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/helper/add_building_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rightWay/addRightWay/helper/add_right_way_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_right_way_event.dart';
part 'add_right_way_state.dart';

class AddRightWayBloc extends Bloc<AddRightWayEvent, AddRightWayState> {

  TextEditingController dateController =  TextEditingController();
  TextEditingController reportNumberController =  TextEditingController();
  TextEditingController activityRemarkController =  TextEditingController();
  TextEditingController roadLengthController =  TextEditingController();
  TextEditingController typeController =  TextEditingController();
  TextEditingController gpsCoordinateNorthController =  TextEditingController();
  TextEditingController gpsCoordinateEastController =  TextEditingController();
  TextEditingController roadWidthController =  TextEditingController();
  TextEditingController locationController =  TextEditingController();
  TextEditingController materialTypeController =  TextEditingController();
  TextEditingController latitudeController =  TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController eastingLatController =  TextEditingController();
  TextEditingController eastingLongController =  TextEditingController();
  TextEditingController roadNameController =  TextEditingController();

  String _accuracy =  "";
  String get accuracy => _accuracy;

  List<WeatherModel> weatherList = [];
  bool isLoader =  false;
  bool isJointNumberLoader = false;
  bool isAlignmentLoader = false;
  File file =  File("");
  WeatherModel weatherData =  WeatherModel();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  List<SpreadTypeModel> spreadList = [];
  SpreadTypeModel spreadTypeData =  SpreadTypeModel();
  List<SectionTypeModel> sectionList = [];
  SectionTypeModel sectionTypeData =  SectionTypeModel();

  String rodeSideValue = "";


  AddRightWayBloc() : super(AddRightWayInitial()) {

    on<AddRightWayPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddRightWaySelectSpreadEvent>(_selectSpread);
    on<AddRightWaySelectSectionEvent>(_selectSection);
    on<AddRightWaySelectDateEvent>(_selectDate);
    on<AddRightWayCaptureNorthingLocationEvent>(_selectNorthingLocation);
    on<AddRightWayCaptureEastingLocationEvent>(_selectEastLocation);
    on<AddRightWaySelectRodeSideEvent>(_selectRoadSide);
    on<AddRightWayAddImageEvent>(_selectFile);
    on<AddRightWaySubmitDataEvent>(_submitData);
  }

  _pageLoad(AddRightWayPageLoadEvent event, emit) async {
    emit(AddRightWayPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    roadLengthController.text = "";
    typeController.text = "";
    gpsCoordinateNorthController.text = "";
    gpsCoordinateEastController.text = "";
    roadWidthController.text = "";
    locationController.text = "";
    materialTypeController.text = "";
    eastingLongController.text = "";
    eastingLatController.text = "";
    longitudeController.text = "";
    latitudeController.text = "";
    roadNameController.text = "";

    weatherList = [];
    spreadList = [];
    sectionList = [];
    spreadTypeData =  SpreadTypeModel();
    sectionTypeData =  SectionTypeModel();
    isLoader =  false;
    isJointNumberLoader = false;
    isAlignmentLoader = false;
    file =  File("");
    weatherData =  WeatherModel();
    _userData =  UserInfo.instanceInit()!.userData!;

    var location =  await LocationHelper.getLocation(context: event.context);
    LocationModel locationData = LocationModel();
    if(location != null){
      locationData =  location;
      _accuracy =  locationData.accuracy.toString();
    }

    weatherList =  await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);


    var resSection =  await AddBuildingHelper.fetchSectionData(spreadId: userData.spreadId.toString().isEmpty ? "0" : userData.spreadId.toString());
    if(resSection != null){
      sectionList =  resSection;
      for(var section in sectionList){
        if(section.id.toString() == userData.sectionId.toString()){
          sectionTypeData =  section;
        }
      }
    }

    var resSpread =  await AddBuildingHelper.fetchSpreadData();
    if(resSpread != null){
      spreadList =  resSpread;
      for(var spread in spreadList){
        if(spread.id.toString() == userData.spreadId.toString()){
          spreadTypeData =  spread;
        }
      }
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }


  _selectSpread(AddRightWaySelectSpreadEvent event, emit) async {
    spreadTypeData = event.spreadTypeData;
    isJointNumberLoader =  true;
    sectionList = [];
    _eventComplete(emit);

    var resSection =  await AddBuildingHelper.fetchSectionData(
        spreadId: spreadTypeData.id.toString());
    if(resSection != null){
      sectionList =  resSection;
    }
    isJointNumberLoader =  false;
    _eventComplete(emit);
  }

  _selectSection(AddRightWaySelectSectionEvent event, emit) async {
    sectionTypeData = event.sectionTypeData;
    isAlignmentLoader =  true;
    _eventComplete(emit);
  }


  _selectDate(AddRightWaySelectDateEvent event, emit) async {
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

  _selectNorthingLocation(AddRightWayCaptureNorthingLocationEvent event, emit) async {
    isLoader  =  true;
    _eventComplete(emit);
    var location =  await LocationHelper.getLocation(context: event.context);
    LocationModel locationData = LocationModel();
    if(location != null){
      locationData =  location;
      _accuracy =  locationData.accuracy.toString();
      longitudeController.text =  locationData.long.toString();
      latitudeController.text =  locationData.lat.toString();
    }
    isLoader  =  false;
    _eventComplete(emit);
  }

  _selectEastLocation(AddRightWayCaptureEastingLocationEvent event, emit) async {
    isLoader  =  true;
    _eventComplete(emit);
    var location =  await LocationHelper.getLocation(context: event.context);
    LocationModel locationData = LocationModel();
    if(location != null){
      locationData =  location;
      _accuracy =  locationData.accuracy.toString();
      eastingLongController.text =  locationData.long.toString();
      eastingLatController.text =  locationData.lat.toString();
      _eventComplete(emit);
    }
    isLoader  =  false;
    _eventComplete(emit);
  }

  _selectRoadSide(AddRightWaySelectRodeSideEvent event, emit) {
    rodeSideValue =  event.rodeSideValue;
    _eventComplete(emit);
  }

  _selectFile(AddRightWayAddImageEvent event, emit) async {
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

  _submitData(AddRightWaySubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddRightWayHelper.submitData(context: event.context,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        roadLength: roadLengthController.text.toString(),
        type: typeController.text.toString(),
        materialType: materialTypeController.text.toString(),
        latitude: latitudeController.text.toString(),
        longitude: longitudeController.text.toString(),
        roadWidth: roadWidthController.text.toString(),
        locationm: locationController.text.toString(),
        sectionTypeData: sectionTypeData,
        spreadTypeData: spreadTypeData,
        roadName: roadNameController.text.toString(),
        rodeSideValue: rodeSideValue,
        file: file);
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      roadLengthController.text = "";
      typeController.text = "";
      gpsCoordinateNorthController.text = "";
      gpsCoordinateEastController.text = "";
      roadWidthController.text = "";
      locationController.text = "";
      eastingLatController.text = "";
      eastingLongController.text = "";
      latitudeController.text = "";
      latitudeController.text = "";
      materialTypeController.text = "";
      roadNameController.text = "";
      sectionTypeData =  SectionTypeModel();
      spreadTypeData =  SpreadTypeModel();
      longitudeController.text = "";
      isLoader =  false;
      isJointNumberLoader = false;
      isAlignmentLoader = false;
      rodeSideValue = "";
      file =  File("");
      weatherData =  WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddRightWayState>emit) {
    emit(FetchAddRightWayDataState(isLoader: isLoader,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      reportNumberController: reportNumberController,
      roadLengthController: roadLengthController,
      typeController: typeController,
      file: file,
      weatherList: weatherList,
      weatherData: weatherData,
      isJointNumberLoader: isJointNumberLoader,
      gpsCoordinateNorthController: gpsCoordinateNorthController,
      roadWidthController: roadWidthController,
      locationController: locationController,
      materialTypeController: materialTypeController,
      gpsCoordinateEastController: gpsCoordinateEastController,
      eastingLatController: eastingLatController,
      eastingLongController: eastingLongController,
      latitudeController: latitudeController,
      longitudeController: longitudeController,
      accuracy: accuracy,
      sectionTypeData: sectionTypeData,
      spreadTypeData: spreadTypeData,
      sectionList: sectionList,
      spreadList: spreadList,
      roadNameController: roadNameController,
      isAlignmentLoader: isAlignmentLoader,
      rodeSideValue :rodeSideValue
    ));
  }
}