import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/domain/file_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hydrotest/addHydrotest/helper/add_hydrotest_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_hydrotest_event.dart';
part 'add_hydrotest_state.dart';

class AddHydrotestBloc extends Bloc<AddHydrotestEvent, AddHydrotestState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();

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
  List<ImageRequestObject> fileList = [];
  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;
  List<File> images = [];
  AddHydrotestBloc() : super(AddHydrotestInitial()) {
    on<AddHydrotestPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddHydrotestSelectAlignmentEvent>(_selectAlignment);
    on<AddHydrotestMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddHydrotestSelectFromJointDataEvent>(_selectJointFrom);
    on<AddHydrotestSelectToJointDataEvent>(_selectJointTo);
    on<AddHydrotestSelectJointTypeDataEvent>(_selectJointType);
    on<AddHydrotestSelectDateEvent>(_selectDate);
    on<AddHydrotestAddImageEvent>(_selectFile);
    on<SelectCameraCaptureEvent>(_selectCameraCapture);
    on<SelectGalleryCaptureEvent>(_selectGalleryCapture);
    on<AddHydrotestSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddHydrotestPageLoadEvent event, emit) async {
    emit(AddHydrotestPageLoadState());
    dateController.text = "";
    activityRemarkController.text = "";
    lengthController.text = "";
    reportNumberController.text = "";
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    images = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    isLoader = false;
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    fileList = await AddHydroTestHelper.fetchFilesData();
    weatherData = WeatherModel();
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }

    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData,
      type:  AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
          ? AppConfig.instanceInit()!.activitySectionData.appJoint!
          :"afterwelding",
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

  _selectAlignment(AddHydrotestSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddHydrotestMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddHydrotestSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddHydrotestSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;

    _eventComplete(emit);
  }

  _selectJointType(AddHydrotestSelectJointTypeDataEvent event, emit) async {
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

  _selectDate(AddHydrotestSelectDateEvent event, emit) async {
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

  _selectFile(AddHydrotestAddImageEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    if (event.mediaType == 1) {
      var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
      if (photo != null) {
        fileList[event.index].path = photo;
      }
    } else {
      var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
      if (photo != null) {
        fileList[event.index].path = photo;
      }
    }
    Navigator.pop(!event.context.mounted ? event.context : event.context);
    isLoader = false;
    _eventComplete(emit);
  }

  _selectCameraCapture(SelectCameraCaptureEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var photo = await DashboardHelper.cameraCapture();

    if (photo != null) {
      fileList[event.index].path = photo.path.toString();
    }
    isLoader = false;
    _eventComplete(emit);
  }

  _selectGalleryCapture(SelectGalleryCaptureEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var photo = await DashboardHelper.galleryCapture();

    if (photo != null) {
      fileList[event.index].path = photo.path.toString();
      _eventComplete(emit);
    }
    isLoader = false;
    _eventComplete(emit);
  }

  _submitData(AddHydrotestSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddHydroTestHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        length: lengthController.text.toString(),
        reportNumber: reportNumberController.text.toString(),
        fileList: fileList);
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      activityRemarkController.text = "";
      reportNumberController.text = "";
      lengthController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      fileList = await AddHydroTestHelper.fetchFilesData();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddHydrotestState> emit) {
    emit(FetchAddHydrotestDataState(
      images: images,
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      fileList: fileList,
      weatherData: weatherData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      fromJointData: fromJointData,
      jointFromList: jointFromList,
      jointToList: jointToList,
      lengthController: lengthController,
      toJointData: toJointData,
      reportNumberController: reportNumberController,
    ));
  }
}
