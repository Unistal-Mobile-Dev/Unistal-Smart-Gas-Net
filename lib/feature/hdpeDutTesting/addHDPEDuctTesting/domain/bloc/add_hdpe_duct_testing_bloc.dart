import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeDutTesting/addHDPEDuctTesting/helper/add_hdpe_duct_testing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_hdpe_duct_testing_event.dart';
part 'add_hdpe_duct_testing_state.dart';

class AddHdpeDuctTestingBloc
    extends Bloc<AddHdpeDuctTestingEvent, AddHdpeDuctTestingState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController airPressureTestController = TextEditingController();
  TextEditingController ductCleaningController = TextEditingController();
  TextEditingController ductIntegrityTestController = TextEditingController();

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

  AddHdpeDuctTestingBloc() : super(AddHdpeDuctTestingInitial()) {
    on<AddHdpeDuctTestingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddHdpeDuctTestingSelectAlignmentEvent>(_selectAlignment);
    on<AddHdpeDuctTestingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddHdpeDuctTestingSelectFromJointDataEvent>(_selectJointFrom);
    on<AddHdpeDuctTestingSelectToJointDataEvent>(_selectJointTo);
    on<AddHdpeDuctTestingSelectJointTypeDataEvent>(_selectJointType);
    on<AddHdpeDuctTestingSelectDateEvent>(_selectDate);
    on<AddHdpeDuctTestingAddImageEvent>(_selectFile);
    on<AddHdpeDuctTestingSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddHdpeDuctTestingPageLoadEvent event, emit) async {
    emit(AddHdpeDuctTestingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    lengthController.text = "";
    airPressureTestController.text = "";
    ductCleaningController.text = "";
    ductIntegrityTestController.text = "";
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
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }

    var resJointType = await AddWeldingHelper.fetchJointType(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resJointType != null) {
      jointTypeList = resJointType;
    }


    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
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

  _selectAlignment(AddHdpeDuctTestingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddHdpeDuctTestingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddHdpeDuctTestingSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddHdpeDuctTestingSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(
      AddHdpeDuctTestingSelectJointTypeDataEvent event, emit) async {
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

  _selectDate(AddHdpeDuctTestingSelectDateEvent event, emit) async {
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

  _selectFile(AddHdpeDuctTestingAddImageEvent event, emit) async {
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

  _submitData(AddHdpeDuctTestingSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddHdpeDuctTestingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        date: dateController.text.toString(),
        reportNumber: reportNumberController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        length: lengthController.text.toString(),
        ductCleaning: ductCleaningController.text.toString(),
        ductIntegrityTest: ductIntegrityTestController.text.toString(),
        airPressureTest: airPressureTestController.text.toString(),
        file: file);
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      lengthController.text = "";
      alignmentData  =  AlignmentModel();
      multipleAlignmentData  = [];
      isLoader = false;
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      airPressureTestController.text = "";
      ductCleaningController.text = "";
      ductIntegrityTestController.text = "";
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddHdpeDuctTestingState> emit) {
    emit(FetchAddHdpeDuctTestingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      reportNumberController: reportNumberController,
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
      airPressureTestController: airPressureTestController,
      ductCleaningController: ductCleaningController,
      ductIntegrityTestController: ductIntegrityTestController,
    ));
  }
}
