import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/molling/addMolling/helper/add_molling_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/concrete_coating_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_molling_event.dart';
part 'add_molling_state.dart';

class AddMollingBloc extends Bloc<AddMollingEvent, AddMollingState> {
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
  TextEditingController descriptionController = TextEditingController();

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

  AddMollingBloc() : super(AddMollingInitial()) {
    on<AddMollingPageLoadEvent>(_pageLoadEvent);
    on<AddMollingSubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddMollingSelectAlignmentEvent>(_selectAlignment);
    on<AddMollingSelectDateEvent>(_selectDate);
    on<AddMollingSelectPipeDataEvent>(_selectPipe);
    on<AddMollingAddPipeLengthEvent>(_addPipeLength);
    on<AddMollingDeletePipeLengthEvent>(_deletePipeLength);
    on<AddMollingSearchPipeDataEvent>(_searchPipeData);
    on<AddMollingSelectConcreteCoatingEvent>(_selectConcreteCoating);
    on<AddMollingAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddMollingPageLoadEvent event, emit) async {
    emit(AddMollingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    descriptionController.text = "";
    _pipeData =  PipeModel();
    _pipeList = [];
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
    _searchPipeLoader =  false;
    _userData =  UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData( userData: userData);
    var res =  await AddRouteSurveyHelper.fetchAlignmentData(userData: userData);
    if(res != null){
      _alignmentList =  res;
    }

    var resConcreteCoating =  await AddStringingHelper.fetchConcreteCoatingData();
    if(resConcreteCoating != null){
      _concreteCoatingList =  resConcreteCoating;
    }

    _eventComplete(emit);
  }


  _selectDate(AddMollingSelectDateEvent event, emit) async {
    
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

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData =  event.weatherData;
    _eventComplete(emit);
  }


  _selectAlignment(AddMollingSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectConcreteCoating(AddMollingSelectConcreteCoatingEvent event, emit) {
    _concreteCoatingData = event.concreteCoatingData;
    _eventComplete(emit);
  }

  _selectPipe(AddMollingSelectPipeDataEvent event, emit) {
    _pipeData = event.pipeData;
    _searchPipeList = [];
    searchPipeController.text = "${pipeData.pipeNumber.toString()}|${pipeData.heatNumber.toString()}|${pipeData.pipeLength.toString()}";
    _eventComplete(emit);
  }

  _addPipeLength(AddMollingAddPipeLengthEvent event, emit) {
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

  _deletePipeLength(AddMollingDeletePipeLengthEvent event, emit) {
    _isLoader =  true;
    _eventComplete(emit);
    pipeLengthList.removeAt(event.index);
    _isLoader =  false;
    _eventComplete(emit);
  }

  _searchPipeData(AddMollingSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader =  true;
    _eventComplete(emit);
    var resPipe =  await AddStringingHelper.fetchPipeData(context: event.context,
        userData: userData, searchKeyword: event.keyword.toString(), type: "Molling");
    if(resPipe != null){
      _pipeList =  resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader =  false;
    _eventComplete(emit);
  }

  _selectFile(AddMollingAddImageEvent event, emit) async {
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

  _submitData(AddMollingSubmitDataEvent event, emit) async  {
/*    var textFiledValidation =  await AddMollingHelper.textFiledValidation(context: event.context,
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
    var res =  await AddMollingHelper.submitData(
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
      description: descriptionController.text.toString(),
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
      descriptionController.text = "";
      _alignmentData =  AlignmentModel();
      _weatherData =  WeatherModel();
      pipeLengthList = [];
      _eventComplete(emit);
    }
  }


  _eventComplete(Emitter<AddMollingState>emit) {
    emit(FetchAddMollingDataState(isLoader: isLoader,
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
      descriptionController: descriptionController,
      searchPipeLoader: searchPipeLoader,
      pipeLengthList: pipeLengthList,

    ));
  }
}
