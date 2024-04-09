import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/levelling/addLevelling/helper/add_levelling_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_levelling_event.dart';
part 'add_levelling_state.dart';

class AddLevellingBloc extends Bloc<AddLevellingEvent, AddLevellingState> {

  TextEditingController dateController =  TextEditingController();
  TextEditingController reportNumberController =  TextEditingController();
  TextEditingController activityRemarkController =  TextEditingController();
  TextEditingController chainageFromController =  TextEditingController();
  TextEditingController chainageToController =  TextEditingController();
  TextEditingController gpsCoordinateNorthController =  TextEditingController();
  TextEditingController gpsCoordinateEastController =  TextEditingController();
  TextEditingController elevationPipetopController =  TextEditingController();
  TextEditingController natureGroundLeveController =  TextEditingController();
  TextEditingController coverController =  TextEditingController();

  List<JointNumberModel> jointList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel  alignmentData =  AlignmentModel();
  bool isLoader =  false;
  JointNumberModel jointData = JointNumberModel();
  JointTypeModel jointTypeData =  JointTypeModel();
  bool isJointNumberLoader = false;
  File file =  File("");
  WeatherModel weatherData =  WeatherModel();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  TextEditingController northingLatController =  TextEditingController();
  TextEditingController northingLongController = TextEditingController();
  TextEditingController eastingLatController =  TextEditingController();
  TextEditingController eastingLongController =  TextEditingController();

  String _accuracy =  "";
  String get accuracy => _accuracy;

  AddLevellingBloc() : super(AddLevellingInitial()) {

    on<AddLevellingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddLevellingSelectAlignmentEvent>(_selectAlignment);
    on<AddLevellingSelectJointDataEvent>(_selectJointTo);
    on<AddLevellingSelectJointTypeDataEvent>(_selectJointType);
    on<AddLevellingSelectDateEvent>(_selectDate);
    on<AddLevellingAddImageEvent>(_selectFile);
    on<AddLevellingSubmitDataEvent>(_submitData);
    on<AddLevellingCaptureNorthingLocationEvent>(_selectNorthingLocation);
    on<AddLevellingCaptureEastingLocationEvent>(_selectEastLocation);
  }

  _pageLoad(AddLevellingPageLoadEvent event, emit) async {
    emit(AddLevellingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    gpsCoordinateNorthController.text = "";
    gpsCoordinateEastController.text = "";
    elevationPipetopController.text = "";
    natureGroundLeveController.text = "";
    coverController.text = "";
    jointList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData =  AlignmentModel();
    isLoader =  false;
    jointData = JointNumberModel();
    jointTypeData =  JointTypeModel();
    isJointNumberLoader = false;
    file =  File("");
    eastingLongController.text = "";
    eastingLatController.text = "";
    northingLongController.text = "";
    northingLatController.text = "";
    weatherData =  WeatherModel();
     _userData =  UserInfo.instanceInit()!.userData!;
    weatherList =  await DashboardHelper.fetchWeatherData( userData: userData);


    var location =  await LocationHelper.getLocation(context: event.context);
    LocationModel locationData = LocationModel();
    if(location != null){
      locationData =  location;
      _accuracy =  locationData.accuracy.toString();
    }


    var res =  await AddRouteSurveyHelper.fetchAlignmentData(userData: userData);
    if(res != null){
      alignmentList =  res;
    }

    var resJointType =  await AddWeldingHelper.fetchJointType( userData: userData);
    if(resJointType != null){
      jointTypeList =  resJointType;
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddLevellingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectJointTo(AddLevellingSelectJointDataEvent event, emit) {
    jointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddLevellingSelectJointTypeDataEvent event, emit) async {
    jointTypeData =  event.jointTypeData;
    jointList = [];
    jointData =  JointNumberModel();
    isJointNumberLoader =  true;
    _eventComplete(emit);
    var resJointNumber =  await AddWeldingHelper.fetchJointNumberData(context: event.context, userData: userData,
        jointTypeData: jointTypeData);
    if(resJointNumber != null){
      jointList =  resJointNumber;
    }
    isJointNumberLoader =  false;
    _eventComplete(emit);
  }


  _selectDate(AddLevellingSelectDateEvent event, emit) async {
    
    DateTime? pickedDate = await showDatePicker(context: event.context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text =  formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      log("Date is not selected");
    }
  }

  _selectNorthingLocation(AddLevellingCaptureNorthingLocationEvent event, emit) async {
    isLoader  =  true;
    _eventComplete(emit);
    var location =  await LocationHelper.getLocation(context: event.context);
    LocationModel locationData = LocationModel();
    if(location != null){
      locationData =  location;
      _accuracy =  locationData.accuracy.toString();
      northingLongController.text =  locationData.long.toString();
      northingLatController.text =  locationData.lat.toString();
    }
    isLoader  =  false;
    _eventComplete(emit);
  }

  _selectEastLocation(AddLevellingCaptureEastingLocationEvent event, emit) async {
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

  _selectFile(AddLevellingAddImageEvent event, emit) async {
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
   Navigator.pop(event.context.mounted ? event.context : event.context);
    _eventComplete(emit);
  }

  _submitData(AddLevellingSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddLevellingHelper.submitData(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        jointData: jointData,
        cover: coverController.text.toString(),
        gpsCoordinateEast: "${eastingLatController.text},${eastingLongController.text}",
        gpsCoordinateNorth: "${northingLatController.text},${northingLongController.text}",
        elevationPipetop: elevationPipetopController.text.toString(),
        natureGroundLeve: natureGroundLeveController.text.toString(),
        file: file);
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      gpsCoordinateNorthController.text = "";
      gpsCoordinateEastController.text = "";
      elevationPipetopController.text = "";
      natureGroundLeveController.text = "";
      coverController.text = "";
      eastingLongController.text = "";
      eastingLatController.text = "";
      northingLongController.text = "";
      northingLatController.text = "";
      alignmentData =  AlignmentModel();
      isLoader =  false;
      jointData =  JointNumberModel();
      jointTypeData =  JointTypeModel();
      isJointNumberLoader = false;
      file =  File("");
      weatherData =  WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddLevellingState>emit) {
    emit(FetchAddLevellingDataState(isLoader: isLoader,
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
        jointData: jointData,
        jointList: jointList,
        gpsCoordinateNorthController: gpsCoordinateNorthController,
        elevationPipetopController: elevationPipetopController,
        natureGroundLeveController: natureGroundLeveController,
        coverController: coverController,
        gpsCoordinateEastController: gpsCoordinateEastController,
        accuracy: accuracy,
        northingLongController: northingLongController,
        northingLatController: northingLatController,
        eastingLongController: eastingLongController,
        eastingLatController: eastingLatController,
    ));
  }
}
