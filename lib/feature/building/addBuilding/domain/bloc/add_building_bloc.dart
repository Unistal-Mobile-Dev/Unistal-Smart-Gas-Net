import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/building_category_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/section_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/domain/model/spread_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/building/addBuilding/helper/add_building_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_building_event.dart';
part 'add_building_state.dart';

class AddBuildingBloc extends Bloc<AddBuildingEvent, AddBuildingState> {

  TextEditingController dateController =  TextEditingController();
  TextEditingController reportNumberController =  TextEditingController();
  TextEditingController activityRemarkController =  TextEditingController();
  TextEditingController buildingCategoryControlller =  TextEditingController();
  TextEditingController buildingNameController =  TextEditingController();
  TextEditingController gpsCoordinateNorthController =  TextEditingController();
  TextEditingController gpsCoordinateEastController =  TextEditingController();
  TextEditingController floorNoController =  TextEditingController();
  TextEditingController locationController =  TextEditingController();
  TextEditingController flatNoController =  TextEditingController();
  TextEditingController latitudeController =  TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController eastingLatController =  TextEditingController();
  TextEditingController eastingLongController =  TextEditingController();
  TextEditingController buildingNumberController =  TextEditingController();

  String _accuracy =  "";
  String get accuracy => _accuracy;

  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel  alignmentData =  AlignmentModel();
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

  List<BuildingCategoryTypeModel> buildingCategoryList = [];
  BuildingCategoryTypeModel buildingCategoryTypeData = BuildingCategoryTypeModel();

  AddBuildingBloc() : super(AddBuildingInitial()) {

    on<AddBuildingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddBuildingSelectAlignmentEvent>(_selectAlignment);
    on<AddBuildingSelectSpreadEvent>(_selectSpread);
    on<AddBuildingSelectSectionEvent>(_selectSection);
    on<AddBuildingSelectBuildingCategoryEvent>(_selectBuildingCategory);
    on<AddBuildingSelectDateEvent>(_selectDate);
    on<AddBuildingCaptureNorthingLocationEvent>(_selectNorthingLocation);
    on<AddBuildingCaptureEastingLocationEvent>(_selectEastLocation);
    on<AddBuildingAddImageEvent>(_selectFile);
    on<AddBuildingSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddBuildingPageLoadEvent event, emit) async {
    emit(AddBuildingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    buildingCategoryControlller.text = "";
    buildingNameController.text = "";
    gpsCoordinateNorthController.text = "";
    gpsCoordinateEastController.text = "";
    floorNoController.text = "";
    locationController.text = "";
    flatNoController.text = "";
    eastingLongController.text = "";
    eastingLatController.text = "";
    longitudeController.text = "";
    latitudeController.text = "";
    buildingNumberController.text = "";

    weatherList = [];
    alignmentList = [];
    spreadList = [];
    sectionList = [];
    buildingCategoryList = [];
    alignmentData =  AlignmentModel();
    spreadTypeData =  SpreadTypeModel();
    sectionTypeData =  SectionTypeModel();
    buildingCategoryTypeData = BuildingCategoryTypeModel();
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

    var resBuildingCategory =  await AddBuildingHelper.fetchBuildingCategoryData();
    if(resBuildingCategory != null){
      buildingCategoryList =  resBuildingCategory;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddBuildingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectSpread(AddBuildingSelectSpreadEvent event, emit) async {
    spreadTypeData = event.spreadTypeData;
    sectionTypeData =  SectionTypeModel();
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

  _selectSection(AddBuildingSelectSectionEvent event, emit) async {
    sectionTypeData = event.sectionTypeData;
    isAlignmentLoader =  true;
    alignmentList = [];
    _eventComplete(emit);
    var res =  await AddRouteSurveyHelper.fetchAlignmentData(
        userData: userData, sectionId: sectionTypeData.id ?? "0",
        spreadId: spreadTypeData.id ?? "0");
    if(res != null){
      alignmentList =  res;
    }
    isAlignmentLoader =  false;
    _eventComplete(emit);
  }

  _selectBuildingCategory(AddBuildingSelectBuildingCategoryEvent event, emit) {
    buildingCategoryTypeData =  event.buildingCategoryTypeData;
    _eventComplete(emit);
  }


  _selectDate(AddBuildingSelectDateEvent event, emit) async {
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

  _selectNorthingLocation(AddBuildingCaptureNorthingLocationEvent event, emit) async {
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

  _selectEastLocation(AddBuildingCaptureEastingLocationEvent event, emit) async {
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

  _selectFile(AddBuildingAddImageEvent event, emit) async {
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

  _submitData(AddBuildingSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddBuildingHelper.submitData(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        buildingCategory: buildingCategoryControlller.text.toString(),
        buildingName: buildingNameController.text.toString(),
        flatNo: flatNoController.text.toString(),
        latitude: latitudeController.text.toString(),
        longitude: longitudeController.text.toString(),
        floorNo: floorNoController.text.toString(),
        locationm: locationController.text.toString(),
        sectionTypeData: sectionTypeData,
        spreadTypeData: spreadTypeData,
        buildingNo: buildingNumberController.text.toString(),
        buildingCategoryTypeData: buildingCategoryTypeData,
        file: file);
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      buildingCategoryControlller.text = "";
      buildingNameController.text = "";
      gpsCoordinateNorthController.text = "";
      gpsCoordinateEastController.text = "";
      floorNoController.text = "";
      locationController.text = "";
      eastingLatController.text = "";
      eastingLongController.text = "";
      latitudeController.text = "";
      latitudeController.text = "";
      flatNoController.text = "";
      buildingNumberController.text = "";
      alignmentData =  AlignmentModel();
      sectionTypeData =  SectionTypeModel();
      spreadTypeData =  SpreadTypeModel();
      longitudeController.text = "";
      buildingCategoryTypeData =  BuildingCategoryTypeModel();
      isLoader =  false;
      isJointNumberLoader = false;
      isAlignmentLoader = false;
      file =  File("");
      weatherData =  WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddBuildingState>emit) {
    emit(FetchAddBuildingDataState(isLoader: isLoader,
        alignmentList: alignmentList,
        dateController: dateController,
        activityRemarkController: activityRemarkController,
        reportNumberController: reportNumberController,
        buildingCategoryControlller: buildingCategoryControlller,
        buildingNameController: buildingNameController,
        alignmentData: alignmentData,
        file: file,
        weatherList: weatherList,
        weatherData: weatherData,
        isJointNumberLoader: isJointNumberLoader,
        gpsCoordinateNorthController: gpsCoordinateNorthController,
        floorNoController: floorNoController,
        locationController: locationController,
        flatNoController: flatNoController,
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
        buildingNumberController: buildingNumberController,
        isAlignmentLoader: isAlignmentLoader,
        buildingCategoryList: buildingCategoryList,
        buildingCategoryTypeData: buildingCategoryTypeData,
    ));
  }
}
