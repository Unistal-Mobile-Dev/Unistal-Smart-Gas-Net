import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/swabbing/addSwabbing/helper/add_swabbing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_swabbing_event.dart';
part 'add_swabbing_state.dart';

class AddSwabbingBloc extends Bloc<AddSwabbingEvent, AddSwabbingState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  bool isLoader = false;
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  AddSwabbingBloc() : super(AddSwabbingInitial()) {
    on<AddSwabbingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddSwabbingSelectAlignmentEvent>(_selectAlignment);
    on<AddSwabbingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddSwabbingSelectFromJointDataEvent>(_selectJointFrom);
    on<AddSwabbingSelectToJointDataEvent>(_selectJointTo);
    on<AddSwabbingSelectJointTypeDataEvent>(_selectJointType);
    on<AddSwabbingSelectDateEvent>(_selectDate);
    on<AddSwabbingAddImageEvent>(_selectFile);
    on<AddSwabbingSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddSwabbingPageLoadEvent event, emit) async {
    emit(AddSwabbingPageLoadState());
    dateController.text = "";
    activityRemarkController.text = "";
    lengthController.text = "";
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    isLoader = false;
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    weatherData = WeatherModel();
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData();

    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }

    var resJointNumber = await DashboardHelper.fetchJointNumberData(
        type:  AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
            ? AppConfig.instanceInit()!.activitySectionData.appJoint!
            :"afterwelding"

    );
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddSwabbingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddSwabbingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectJointFrom(AddSwabbingSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddSwabbingSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddSwabbingSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointFromList = [];
    jointToList = [];
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);

    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectDate(AddSwabbingSelectDateEvent event, emit) async {
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

  _selectFile(AddSwabbingAddImageEvent event, emit) async {
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

  _submitData(AddSwabbingSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddSwabbingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        length: lengthController.text.toString(),
        file: file);
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      activityRemarkController.text = "";
      lengthController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddSwabbingState> emit) {
    emit(FetchAddSwabbingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      weatherList: weatherList,
      weatherData: weatherData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      fromJointData: fromJointData,
      jointFromList: jointFromList,
      jointToList: jointToList,
      lengthController: lengthController,
      toJointData: toJointData,
    ));
  }
}
