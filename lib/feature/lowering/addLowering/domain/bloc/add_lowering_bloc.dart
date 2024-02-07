import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/helper/add_lowering_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_lowering_event.dart';
part 'add_lowering_state.dart';

class AddLoweringBloc extends Bloc<AddLoweringEvent, AddLoweringState> {

  TextEditingController dateController = TextEditingController();
  TextEditingController calibarationDateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController holidayDetectorDetailsController = TextEditingController();
  TextEditingController testVoltageController = TextEditingController();
  TextEditingController repairCoatingController = TextEditingController();
  TextEditingController postPaddingController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  List<HolidayChecksModel> holidayCheckList = [];
  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel  alignmentData =  AlignmentModel();
  bool isLoader =  false;
  HolidayChecksModel holidayChecksData = HolidayChecksModel();
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData =  JointTypeModel();
  bool isJointNumberLoader = false;
  File file =  File("");
  WeatherModel weatherData =  WeatherModel();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  AddLoweringBloc() : super(AddLoweringInitial()) {
    on<AddLoweringPageLoadEvent>(_pageLoader);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddLoweringSelectAlignmentEvent>(_selectAlignment);
    on<AddLoweringSelectHolidayDataEvent>(_selectHolidayData);
    on<AddLoweringSelectFromJointDataEvent>(_selectJointFrom);
    on<AddLoweringSelectToJointDataEvent>(_selectJointTo);
    on<AddLoweringSelectJointTypeDataEvent>(_selectJointType);
    on<AddLoweringSelectDateEvent>(_selectDate);
    on<AddLoweringCalibarationDataEvent>(_selectCabilabrationData);
    on<AddLoweringAddImageEvent>(_selectFile);
    on<AddLoweringSubmitDataEvent>(_submitData);
  }

  _pageLoader(AddLoweringPageLoadEvent event, emit) async {
    emit(AddLoweringPageLoadState());
    dateController.text = "";
    calibarationDateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    modelController.text = "";
    locationController.text = "";
    holidayDetectorDetailsController.text = "";
    testVoltageController.text = "";
    repairCoatingController.text = "";
    postPaddingController.text = "";
    lengthController.text = "";
    holidayCheckList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData =  AlignmentModel();
    isLoader =  false;
    holidayChecksData = HolidayChecksModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData =  JointTypeModel();
    isJointNumberLoader = false;
    file =  File("");
    weatherData =  WeatherModel();
    weatherList =  WeatherModel.getWeatherData();
    _userData =  UserInfo.instanceInit()!.userData!;

    var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: event.context, userData: userData);
    if(res != null){
      alignmentList =  res;
    }
    var resJointType =  await AddWeldingHelper.fetchJointType(context: event.context, userData: userData);
    if(resJointType != null){
      jointTypeList =  resJointType;
    }

    var resHoliday =  await AddBendingHelper.fetchHolidayData(context: event.context);
    if(resHoliday != null){
      holidayCheckList =  resHoliday;
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddLoweringSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectHolidayData(AddLoweringSelectHolidayDataEvent event, emit) {
    holidayChecksData = event.holidayChecksData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddLoweringSelectFromJointDataEvent event, emit) {
    fromJointData =  event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddLoweringSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddLoweringSelectJointTypeDataEvent event, emit) async {
    jointTypeData =  event.jointTypeData;
    jointFromList = [];
    jointToList  = [];
    fromJointData =  JointNumberModel();
    toJointData =  JointNumberModel();
    isJointNumberLoader =  true;
    _eventComplete(emit);
    var resJointNumber =  await AddWeldingHelper.fetchJointNumberData(context: event.context, userData: userData,
        jointTypeData: jointTypeData);
    if(resJointNumber != null){
      jointFromList =  resJointNumber;
      jointToList =  jointFromList;
    }
    isJointNumberLoader =  false;
    _eventComplete(emit);
  }

  _selectDate(AddLoweringSelectDateEvent event, emit) async {
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

  _selectCabilabrationData(AddLoweringCalibarationDataEvent event, emit) async {
    DateTime firstDayCurrentMonth = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day+1);
    DateTime? pickedDate = await showDatePicker(context: event.context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      calibarationDateController.text =  formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      print("Date is not selected");
    }
  }


  _selectFile(AddLoweringAddImageEvent event, emit) async {
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

  _submitData(AddLoweringSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddLoweringHelper.submitData(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        holidayChecksData: holidayChecksData,
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        postPadding: postPaddingController.text.toString(),
        file: file,
        calibarationDate: calibarationDateController.text.toString(),
        holidayDetectorDetail: holidayDetectorDetailsController.text.toString(),
        locationName: locationController.text.toString(),
        makeModel: modelController.text.toString(),
        repairOfCoatingDamage: repairCoatingController.text.toString(),
        length: lengthController.text.toString(),
        testVoltage: testVoltageController.text.toString(),
    );
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      postPaddingController.text = "";
      alignmentData =  AlignmentModel();
      isLoader =  false;
      holidayChecksData = HolidayChecksModel();
      testVoltageController.text = "";
      locationController.text = "";
      holidayDetectorDetailsController.text = "";
      repairCoatingController.text = "";
      calibarationDateController.text = "";
      lengthController.text = "";
      modelController.text = "";
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData =  JointTypeModel();
      isJointNumberLoader = false;
      file =  File("");
      weatherData =  WeatherModel();
      _eventComplete(emit);
    }
  }
  

  _eventComplete(Emitter<AddLoweringState>emit) {
     emit(FetchAddLoweringDataState(isLoader: isLoader,
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
         fromJointData: fromJointData,
         jointFromList: jointFromList,
         jointToList: jointToList,
         modelController: modelController,
         locationController: locationController,
         toJointData: toJointData,
         holidayDetectorDetailsController: holidayDetectorDetailsController,
         holidayChecksData: holidayChecksData,
         calibarationDateController: calibarationDateController,
         holidayCheckList: holidayCheckList,
         repairCoatingController: repairCoatingController,
         testVoltageController: testVoltageController,
         postPaddingController: postPaddingController,
         lengthController: lengthController,
     ));
  }

}
