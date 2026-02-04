import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/helper/clearing_grading_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/ground_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_clearing_grading_event.dart';
part 'add_clearing_grading_state.dart';

class AddClearingGradingBloc
    extends Bloc<AddClearingGradingEvent, AddClearingGradingState> {
  bool _isLoader = false;

  bool get isLoader => _isLoader;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController tpChainageController = TextEditingController();
  TextEditingController tpChainageNumberController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController structureNameController = TextEditingController();
  TextEditingController boundaryLocation = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController groundTypeController = TextEditingController();
  TextEditingController boundaryLocationController = TextEditingController();
  TextEditingController ipNumberController = TextEditingController();
  TextEditingController ipNumberFromController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController gapLengthController = TextEditingController();
  TextEditingController gapDescriptionController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  File file = File("");

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  List<GroundTypeModel> groundTypeList = [];
  GroundTypeModel groundTypeData = GroundTypeModel();

  List<TerrainTypeModel> terrainTypeList = [];
  TerrainTypeModel terrainTypeData = TerrainTypeModel();

  AddClearingGradingBloc() : super(AddClearingGradingInitial()) {
    on<AddClearingGradingPageLoadEvent>(_pageLoadEvent);
    on<AddClearingGradingSubmitDataEvent>(_submitData);
    on<AddClearingGradingSelectAlignmentEvent>(_selectAlignment);
    on<AddClearingGradingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddClearingGradingSelectGroundTypeEvent>(_selectGroundType);
    on<AddClearingGradingSelectTerrainEvent>(_selectTerrain);
    on<AddClearingGradingSelectDateEvent>(_selectDate);
    on<AddClearingGradingAddImageEvent>(_selectFile);
    on<SelectWeatherEvent>(_selectWeather);
    on<CalculateLengthEvent>(_calculateChainage);
  }

  _pageLoadEvent(AddClearingGradingPageLoadEvent event, emit) async {
    emit(AddClearingGradingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    tpChainageController.text = "";
    tpChainageNumberController.text = "";
    tpRemarkNumberController.text = "";
    structureNameController.text = "";
    boundaryLocation.text = "";
    activityRemarkController.text = "";
    groundTypeController.text = "";
    gapLengthController.text = "";
    gapDescriptionController.text = "";
    _isLoader = false;
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    ipNumberController.text = "";
    ipNumberFromController.text = "";
    boundaryLocationController.text = "";
    boundaryLocation.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    chainageController.text = "";
    lengthController.text = "";
    terrainTypeList = [];
    terrainTypeData = TerrainTypeModel();
    file = File("");
    _weatherData = WeatherModel();
     groundTypeList = [];
     groundTypeData = GroundTypeModel();
    _userData = UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }
    var groundTypeRes = await AddRouteSurveyHelper.fetchGroundTypeData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      groundTypeList = groundTypeRes;
    }
    var resTerrain = await AddClearingGradingHelper.fetchTerrainData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resTerrain != null) {
      terrainTypeList = resTerrain;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _calculateChainage(CalculateLengthEvent event, emit) {
    bool isChainageTo =  event.isChainageTo;
    String value =  event.value;

    if(value.isEmpty) {
      lengthController.text = "";
    } else if(isChainageTo == true && value.isNotEmpty && chainageFromController.text.toString().isNotEmpty){
      double chainageTo =  double.parse(value.toString());
      double chainageFrom =  double.parse(chainageFromController.text.toString());
      if(chainageTo < chainageFrom){
        lengthController.text = "";
        SnackBarErrorWidget(event.context).show(message: "Chainage TO must be greater than or equal to Chainage FROM");
      }else {
        lengthController.text = "${chainageTo - chainageFrom}";
      }
    } else if(isChainageTo == false && value.isNotEmpty && chainageToController.text.toString().isNotEmpty){
      double chainageTo =  double.parse(chainageToController.text.toString());
      double chainageFrom =  double.parse(value);
      if(chainageTo < chainageFrom){
        lengthController.text = "";
        SnackBarErrorWidget(event.context).show(message: "Chainage TO must be greater than or equal to Chainage FROM");
      }else {
        lengthController.text = "${chainageTo - chainageFrom}";
      }
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddClearingGradingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddClearingGradingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectGroundType(AddClearingGradingSelectGroundTypeEvent event, emit) {
    groundTypeData = event.groundTypeData;
    _eventComplete(emit);
  }

  _selectTerrain(AddClearingGradingSelectTerrainEvent event, emit) {
    terrainTypeData = event.terrainTypeData;
    _eventComplete(emit);
  }

  _selectDate(AddClearingGradingSelectDateEvent event, emit) async {
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

  _selectFile(AddClearingGradingAddImageEvent event, emit) async {
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

  _submitData(AddClearingGradingSubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddClearingGradingHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      tpIpChainage: tpChainageController.text.toString(),
      tpIpNOS: tpChainageNumberController.text.toString(),
      tpIpRemark: tpRemarkNumberController.text.toString(),
      structureDetail: structureNameController.text.toString(),
      boundaryLocation: boundaryLocationController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      groundType: AppConfig.instanceInit()!.client == Client.vppl ? terrainTypeData.id.toString() :groundTypeController.text.toString(),
      userData: userData,
      file: file,
      ipNumber: ipNumberController.text.toString(),
      ipNumberFrom: ipNumberFromController.text.toString(),
      weatherData: weatherData,
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      chainage: chainageController.text.toString(),
      terrainTypeData: terrainTypeData,
      gapDescription: gapDescriptionController.text.toString(),
      gapLength: gapLengthController.text.toString(),
    );
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      tpChainageController.text = "";
      tpChainageNumberController.text = "";
      tpRemarkNumberController.text = "";
      structureNameController.text = "";
      boundaryLocation.text = "";
      activityRemarkController.text = "";
      groundTypeController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      ipNumberController.text = "";
      ipNumberFromController.text = "";
      boundaryLocationController.text = "";
      boundaryLocation.text = "";
      _isLoader = false;
      file = File("");
      chainageFromController.text = "";
      chainageToController.text = "";
      chainageController.text = "";
      gapLengthController.text = "";
      gapDescriptionController.text = "";
      lengthController.text = "";
      _weatherData = WeatherModel();
      terrainTypeData = TerrainTypeModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddClearingGradingState> emit) {
    emit(FetchAddClearingGradingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      structureNameController: structureNameController,
      reportNumberController: reportNumberController,
      chainageController: chainageController,
      tpChainageController: tpChainageController,
      tpChainageNumberController: tpChainageNumberController,
      tpRemarkNumberController: tpRemarkNumberController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      groundTypeController: groundTypeController,
      boundaryLocationController: boundaryLocationController,
      ipNumberController: ipNumberController,
      ipNumberFromController: ipNumberFromController,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      terrainTypeData: terrainTypeData,
      terrainTypeList: terrainTypeList,
      gapDescriptionController: gapDescriptionController,
      gapLengthController: gapLengthController,
      lengthController: lengthController,
      groundTypeData: groundTypeData,
      groundTypeList: groundTypeList,
    ));
  }
}
