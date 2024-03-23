import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/concrete_coating_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_stringing_event.dart';
part 'add_stringing_state.dart';

class AddStringingBloc extends Bloc<AddStringingEvent, AddStringingState> {

  List<ConcreteCoatingModel> _concreteCoatingList = [];
  List<ConcreteCoatingModel> get concreteCoatingList => _concreteCoatingList;

  ConcreteCoatingModel _concreteCoatingData =  ConcreteCoatingModel();
  ConcreteCoatingModel get concreteCoatingData => _concreteCoatingData;

  List<PipeModel> _pipeList = [];
  List<PipeModel> get pipeList => _pipeList;

  List<dynamic> _searchPipeList = [];
  List<dynamic> get searchPipeList => _searchPipeList;

  bool _searchPipeLoader =  false;
  bool get searchPipeLoader => _searchPipeLoader;

  PipeModel _pipeData =  PipeModel();
  PipeModel get pipeData => _pipeData;

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  List<AlignmentModel> _alignmentList = [];
  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData =  AlignmentModel();
  AlignmentModel get alignmentData => _alignmentData;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController pipeLengthController = TextEditingController();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  File file = File("");

  List<WeatherModel> _weatherList = [];
  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData =  WeatherModel();
  WeatherModel get weatherData => _weatherData;

  TextEditingController chainageFromController =  TextEditingController();
  TextEditingController chainageToController =  TextEditingController();
  TextEditingController searchPipeController =  TextEditingController();

  List<PipeModel> pipeLengthList = [];

  AddStringingBloc() : super(AddStringingInitial()) {
    on<AddStringingPageLoadEvent>(_pageLoadEvent);
    on<AddStringingSubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddStringingSelectAlignmentEvent>(_selectAlignment);
    on<AddStringingSelectDateEvent>(_selectDate);
    on<AddStringingSelectPipeDataEvent>(_selectPipe);
    on<AddStringingAddPipeLengthEvent>(_addPipeLength);
    on<AddStringingDeletePipeLengthEvent>(_deletePipeLength);
    on<AddStringingSearchPipeDataEvent>(_searchPipeData);
    on<AddStringingSelectConcreteCoatingEvent>(_selectConcreteCoating);
    on<AddStringingAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddStringingPageLoadEvent event, emit) async {
    emit(AddStringingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    pipeLengthController.text = "";
    _pipeData =  PipeModel();
    _pipeList = [];
    _searchPipeLoader =  false;
    _concreteCoatingList = [];
    pipeLengthList = [];
    _concreteCoatingData  =  ConcreteCoatingModel();
    _isLoader =  false;
    _alignmentList =  [];
    file = File("");
    _alignmentData =  AlignmentModel();
    _weatherData = WeatherModel();
    chainageFromController.text = "";
    chainageToController.text = "";
    searchPipeController.text = "";
    _userData =  UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);
    var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: event.context, userData: userData);
    if(res != null){
      _alignmentList =  res;
    }

    var resConcreteCoating =  await AddStringingHelper.fetchConcreteCoatingData(context: event.context);
    if(resConcreteCoating != null){
      _concreteCoatingList =  resConcreteCoating;
    }

    _eventComplete(emit);
  }


  _selectDate(AddStringingSelectDateEvent event, emit) async {
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

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData =  event.weatherData;
    _eventComplete(emit);
  }


  _selectAlignment(AddStringingSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectConcreteCoating(AddStringingSelectConcreteCoatingEvent event, emit) {
    _concreteCoatingData = event.concreteCoatingData;
    _eventComplete(emit);
  }

  _selectPipe(AddStringingSelectPipeDataEvent event, emit) {
    _pipeData = event.pipeData;
    _searchPipeList = [];
    searchPipeController.text = "${pipeData.pipeNumber.toString()}|${pipeData.heatNumber.toString()}|${pipeData.pipeLength.toString()}";
    _eventComplete(emit);
  }

  _addPipeLength(AddStringingAddPipeLengthEvent event, emit) {
    if(searchPipeController.text.toString().isEmpty){
      SnackBarErrorWidget(event.context).show(message: "Please enter pipe length");
      return;
    }
    _isLoader =  true;
    _eventComplete(emit);
    pipeLengthList.add(pipeData);
    searchPipeController.text = "";
    _isLoader =  false;
    _eventComplete(emit);
  }

  _deletePipeLength(AddStringingDeletePipeLengthEvent event, emit) {
    _isLoader =  true;
    _eventComplete(emit);
    pipeLengthList.removeAt(event.index);
    _isLoader =  false;
    _eventComplete(emit);
  }

  _searchPipeData(AddStringingSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader =  true;
    _eventComplete(emit);
    var resPipe =  await AddStringingHelper.fetchPipeData(context: event.context,
        userData: userData, searchKeyword: event.keyword.toString(), type: "stringing");
    if(resPipe != null){
      _pipeList =  resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader =  false;
    _eventComplete(emit);
  }

  _selectFile(AddStringingAddImageEvent event, emit) async {
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

  _submitData(AddStringingSubmitDataEvent event, emit) async  {
/*    var textFiledValidation =  await AddStringingHelper.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        concreteCoatingData: concreteCoatingData,
        pipeData: pipeData,
        activityRemark: activityRemarkController.text.toString());
    if(textFiledValidation == false){
      return;
    }*/
    _isLoader =  true;
    _eventComplete(emit);
    var res =  await AddStringingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        concreteCoatingData: concreteCoatingData,
        pipeData: pipeData,
        activityRemark: activityRemarkController.text.toString(),
        userData: userData, file: file,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        weatherData: weatherData,
        pipeLength: pipeLengthList,
    );
    _isLoader =  false;
    _eventComplete(emit);
    if(res != null){
      dateController.text = "";
      reportNumberController.text = "";
      _pipeData =  PipeModel();
      _concreteCoatingData =  ConcreteCoatingModel();
      activityRemarkController.text = "";
      _isLoader =  false;
      file = File("");
      chainageFromController.text = "";
      chainageToController.text = "";
      searchPipeController.text = "";
      pipeLengthController.text = "";
      _alignmentData =  AlignmentModel();
      _weatherData =  WeatherModel();
      pipeLengthList = [];
      _eventComplete(emit);
    }
  }


  _eventComplete(Emitter<AddStringingState>emit) {
    emit(FetchAddStringingDataState(isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      reportNumberController: reportNumberController,
      alignmentData: alignmentData,
      file: file,
      concreteCoatingData: concreteCoatingData,
      concreteCoatingList: concreteCoatingList,
      pipeData: pipeData,
      pipeList: pipeList,
      weatherData:  weatherData,
      weatherList:  weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      searchPipeList: searchPipeList,
      searchPipeController: searchPipeController,
      pipeLengthController: pipeLengthController,
      searchPipeLoader: searchPipeLoader,
      pipeLengthList: pipeLengthList,

    ));
  }
}
