import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcBlowing/addOFCBlowing/helper/ofc_blowing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_ofc_blowing_event.dart';
part 'add_ofc_blowing_state.dart';

class AddOFCBlowingBloc
    extends Bloc<AddOFCBlowingEvent, AddOFCBlowingState> {
  bool _isLoader = false;

  bool get isLoader => _isLoader;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController ofcDrumNoController = TextEditingController();
  TextEditingController ofcDrumLengthController = TextEditingController();
  TextEditingController smmController = TextEditingController();
  TextEditingController pitCableLengthController = TextEditingController();
  TextEditingController loopPitController = TextEditingController();
  TextEditingController locationBPController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  List<JointNumberModel> listOfFromJoint = [];
  List<JointNumberModel> listOfToJoint = [];
  JointNumberModel fromJointValue = JointNumberModel();
  JointNumberModel toJointValue = JointNumberModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  File file = File("");

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;




  AddOFCBlowingBloc() : super(AddOFCBlowingInitial()) {
    on<AddOFCBlowingPageLoadEvent>(_pageLoadEvent);
    on<AddOFCBlowingSubmitDataEvent>(_submitData);
    on<AddOFCBlowingSelectAlignmentEvent>(_selectAlignment);
    on<AddOFCBlowingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddOFCBlowingSelectDateEvent>(_selectDate);
    on<AddOFCBlowingAddImageEvent>(_selectFile);
    on<SelectWeatherEvent>(_selectWeather);
    on<SelectFromJointEvent>(_selectFromJoint);
    on<SelectToJointEvent>(_selectToJoint);
    on<CalculateLengthEvent>(_calculateChainage);
  }

  _pageLoadEvent(AddOFCBlowingPageLoadEvent event, emit) async {
    emit(AddOFCBlowingPageLoadState());
    dateController = TextEditingController();
    reportNumberController = TextEditingController();
    chainageFromController = TextEditingController();
    chainageToController = TextEditingController();
    lengthController = TextEditingController();
    ofcDrumNoController = TextEditingController();
    ofcDrumLengthController = TextEditingController();
    smmController = TextEditingController();
    pitCableLengthController = TextEditingController();
    loopPitController = TextEditingController();
    locationBPController = TextEditingController();
    activityRemarkController = TextEditingController();
    _isLoader = false;
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    listOfFromJoint = [];
    listOfToJoint = [];
    fromJointValue = JointNumberModel();
    toJointValue = JointNumberModel();
    file = File("");
    _weatherData = WeatherModel();
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
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
      context: event.context,
      userData: userData,
      type: "welding",);
    if (resJointNumber != null) {
      listOfFromJoint = resJointNumber;
      listOfToJoint = listOfFromJoint;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectFromJoint(SelectFromJointEvent event, emit) {
    fromJointValue = event.fromJointValue;
    _eventComplete(emit);
  }

  _selectToJoint(SelectToJointEvent event, emit) {
    toJointValue = event.toJointValue;
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

  _selectAlignment(AddOFCBlowingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddOFCBlowingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectDate(AddOFCBlowingSelectDateEvent event, emit) async {
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

  _selectFile(AddOFCBlowingAddImageEvent event, emit) async {
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

  _submitData(AddOFCBlowingSubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddOFCBlowingHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
     userData: userData,
      file: file,
      weatherData: weatherData,
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      blowingPitLocationNo: loopPitController.text.toString(),
      ofcDrumNo: ofcDrumNoController.text.toString(),
      ofcSMM: smmController.text.toString(),
      ofDrumLength: ofcDrumLengthController.text.toString(),
      pitCableLength: pitCableLengthController.text.toString(),
      pitLoop: loopPitController.text.toString(),
      fromJointData: fromJointValue,
      toJointData: toJointValue,
    );
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController = TextEditingController();
      reportNumberController = TextEditingController();
      chainageFromController = TextEditingController();
      chainageToController = TextEditingController();
      lengthController = TextEditingController();
      ofcDrumNoController = TextEditingController();
      ofcDrumLengthController = TextEditingController();
      smmController = TextEditingController();
      pitCableLengthController = TextEditingController();
      loopPitController = TextEditingController();
      locationBPController = TextEditingController();
      activityRemarkController = TextEditingController();
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      _isLoader = false;
      file = File("");
      _weatherData = WeatherModel();
      fromJointValue = JointNumberModel();
      toJointValue= JointNumberModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddOFCBlowingState> emit) {
    emit(FetchAddOFCBlowingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController :dateController,
      reportNumberController :reportNumberController,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      lengthController :lengthController,
      ofcDrumNoController :ofcDrumNoController,
      ofcDrumLengthController:ofcDrumLengthController,
      smmController :smmController,
      pitCableLengthController :pitCableLengthController,
      loopPitController :loopPitController,
      locationBPController :locationBPController,
      activityRemarkController :activityRemarkController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      listOfFromJoint: listOfFromJoint,
      listOfToJoint: listOfToJoint,
      fromJointValue: fromJointValue,
      toJointValue: toJointValue,

    ));
  }
}
