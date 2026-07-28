import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/helper/add_concrete_coating_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

import '../../../../stringing/addStringing/domain/model/pipe_model.dart';

part 'add_concrete_coating_event.dart';
part 'add_concrete_coating_state.dart';

class AddConcreteCoatingBloc extends Bloc<AddConcreteCoatingEvent, AddConcreteCoatingState> {

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  bool _isLoader = false;

  bool get isLoader => _isLoader;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController concreteCoatingLengthController =
      TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  File file = File("");

  List<PipeModel> _pipeList = [];

  List<PipeModel> get pipeList => _pipeList;

  List<ThicknessModel> _thicknessList = [];

  List<ThicknessModel> get thicknessList => _thicknessList;

  ThicknessModel _thicknessData = ThicknessModel();

  ThicknessModel get thicknessData => _thicknessData;

  PipeModel _pipeData = PipeModel();

  PipeModel get pipeData => _pipeData;

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  List<dynamic> _searchPipeList = [];

  List<dynamic> get searchPipeList => _searchPipeList;

  TextEditingController searchPipeController = TextEditingController();

  bool _searchPipeLoader = false;

  bool get searchPipeLoader => _searchPipeLoader;

  AddConcreteCoatingBloc() : super(AddConcreteCoatingInitial()) {
    on<AddConcreteCoatingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddConcreteCoatingSelectAlignmentEvent>(_selectAlignment);
    on<AddConcreteCoatingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddConcreteCoatingSelectDateEvent>(_selectDate);
    on<AddConcreteCoatingSelectSelectPipeDataEvent>(_selectPipeData);
    on<AddConcreteCoatingSelectSelectThicknessDataEvent>(_selectThickness);
    on<AddConcreteCoatingAddSearchPipeDataEvent>(_searchPipeData);
    on<AddConcreteCoatingAddImageEvent>(_selectFile);
    on<AddConcreteCoatingSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddConcreteCoatingPageLoadEvent event, emit) async {
    emit(AddConcreteCoatingPageLoadState());
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];

    _isLoader = false;
    dateController.text = "";
    reportNumberController.text = "";
    concreteCoatingLengthController.text = "";
    activityRemarkController.text = "";
    chainageController.text = "";
    file = File("");
    _pipeList = [];
    _pipeData = PipeModel();
    _weatherData = WeatherModel();
    _thicknessList = [];
    _thicknessData = ThicknessModel();
    _userData = UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData();

    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }

    var thicknessRes = await AddConcreteCoatingHelper.fetchThicknessData();
    if (res != null) {
      _thicknessList = thicknessRes;
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddConcreteCoatingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddConcreteCoatingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddConcreteCoatingSelectDateEvent event, emit) async {
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

  _selectPipeData(AddConcreteCoatingSelectSelectPipeDataEvent event, emit) {
    _pipeData = event.pipeData;
    _searchPipeList = [];
    searchPipeController.text = pipeData.pipeNumber.toString();
    _eventComplete(emit);
  }

  _selectThickness(
      AddConcreteCoatingSelectSelectThicknessDataEvent event, emit) {
    _thicknessData = event.thicknessData;
    _eventComplete(emit);
  }

  _searchPipeData(AddConcreteCoatingAddSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader = true;
    _eventComplete(emit);
    var resPipe = await AddStringingHelper.fetchPipeData(
        context: event.context,
        userData: userData,
        searchKeyword: event.keyword.toString(),
        type: "");
    if (resPipe != null) {
      _pipeList = resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader = false;
    _eventComplete(emit);
  }

  _selectFile(AddConcreteCoatingAddImageEvent event, emit) async {
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

  _submitData(AddConcreteCoatingSubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddConcreteCoatingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        concreteCoatingLength: concreteCoatingLengthController.text.toString(),
        date: dateController.text.toString(),
        reportNumber: reportNumberController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        chainage: chainageController.text.toString(),
        pipeData: pipeData,
        weatherData: weatherData,
        userData: userData,
        file: file,
        thicknessData: thicknessData,
        remark: activityRemarkController.text.toString());
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      _isLoader = false;
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      concreteCoatingLengthController.text = "";
      chainageController.text = "";
      _thicknessData = ThicknessModel();
      file = File("");
      _pipeData = PipeModel();
      _pipeList = [];
      searchPipeController.text = "";
      _weatherData = WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddConcreteCoatingState> emit) {
    emit(FetchAddConcreteCoatingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      reportNumberController: reportNumberController,
      activityRemarkController: activityRemarkController,
      concreteCoatingLengthController: concreteCoatingLengthController,
      chainageController: chainageController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      pipeList: pipeList,
      pipeData: pipeData,
      weatherData: weatherData,
      weatherList: weatherList,
      thicknessData: thicknessData,
      thicknessList: thicknessList,
      searchPipeLoader: searchPipeLoader,
      searchPipeList: searchPipeList,
      searchPipeController: searchPipeController,
    ));
  }
}
