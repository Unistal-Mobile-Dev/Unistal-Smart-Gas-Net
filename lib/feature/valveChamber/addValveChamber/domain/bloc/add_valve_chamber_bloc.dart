

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/valveChamber/addValveChamber/helper/add_valve_chamber_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_valve_chamber_event.dart';
part 'add_valve_chamber_state.dart';

class AddValveChamberBloc extends Bloc<AddValveChamberEvent, AddValveChamberState> {

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  List<AlignmentModel> _alignmentList = [];
  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData =  AlignmentModel();
  AlignmentModel get alignmentData => _alignmentData;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController toJointIdController = TextEditingController();
  TextEditingController descriptionOfStructureMemberController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController fromJointIdController = TextEditingController();
  TextEditingController unitWeight = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  File file = File("");

  List<WeatherModel> _weatherList = [];
  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData =  WeatherModel();
  WeatherModel get weatherData => _weatherData;

  bool isJointNumberLoader = false;

  TextEditingController chainageFromController =  TextEditingController();
  TextEditingController weightController =  TextEditingController();


  AddValveChamberBloc() : super(AddValveChamberInitial()) {
    on<AddValveChamberPageLoadEvent>(_pageLoadEvent);
    on<AddValveChamberSelectAlignmentEvent>(_selectAlignment);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddValveChamberSelectDateEvent>(_selectDate);
    on<AddValveChamberAddImageEvent>(_selectFile);
    on<AddValveChamberSubmitDataEvent>(_submitData);
  }

  _pageLoadEvent(AddValveChamberPageLoadEvent event, emit) async {
    emit(AddValveChamberPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    fromJointIdController.text = "";
    toJointIdController.text = "";
    tpRemarkNumberController.text = "";
    descriptionOfStructureMemberController.text = "";
    unitWeight.text = "";
    activityRemarkController.text = "";
    lengthController.text = "";
    heightController.text = "";
    _isLoader =  false;
    _alignmentList =  [];
    file = File("");
    _weatherData = WeatherModel();
    _userData =  UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData( userData: userData);
    _alignmentData =  AlignmentModel();
    isJointNumberLoader = false;
    chainageFromController.text = "";
    weightController.text = "";

    var res =  await AddRouteSurveyHelper.fetchAlignmentData(userData: userData);
    if(res != null){
      _alignmentList =  res;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddValveChamberSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddValveChamberSelectDateEvent event, emit) async {
    
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


  _selectFile(AddValveChamberAddImageEvent event, emit) async {
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


  _submitData(AddValveChamberSubmitDataEvent event, emit) async {
    _isLoader =  true;
    _eventComplete(emit);
    var res =  await AddValveChamberHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      descriptionOfStructureMember:descriptionOfStructureMemberController.text.toString(),
      unitWeight: unitWeight.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      userData: userData, file: file,
      weatherData: weatherData,
      chainageFrom: chainageFromController.text.toString(),
      weight: weightController.text.toString(),
      length: lengthController.text.toString(),
      height: heightController.text.toString(),
    );
    _isLoader =  false;
    _eventComplete(emit);
    if(res != null){
      dateController.text = "";
      reportNumberController.text = "";
      fromJointIdController.text = "";
      toJointIdController.text = "";
      tpRemarkNumberController.text = "";
      unitWeight.text = "";
      descriptionOfStructureMemberController.text = "";
      activityRemarkController.text = "";
      lengthController.text = "";
      heightController.text = "";
      _isLoader =  false;
      _alignmentData =  AlignmentModel();
      file =  File("");
      chainageFromController.text = "";
      weightController.text = "";
      _weatherData =  WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddValveChamberState>emit) {
    emit(FetchAddValveChamberDataState(isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      fromJointIdController: fromJointIdController,
      reportNumberController: reportNumberController,
      unitWeight: unitWeight,
      toJointIdController: toJointIdController,
      descriptionOfStructureMemberController: descriptionOfStructureMemberController,
      alignmentData: alignmentData,
      file: file,
      weatherData:  weatherData,
      weatherList:  weatherList,
      isJointNumberLoader: isJointNumberLoader,
      chainageFromController: chainageFromController,
      weightController: weightController,
      lengthController: lengthController,
      heightController: heightController,
    ));
  }
}
