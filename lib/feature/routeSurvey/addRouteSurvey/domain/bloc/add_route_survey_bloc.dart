import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_route_survey_event.dart';
part 'add_route_survey_state.dart';

class AddRouteSurveyBloc extends Bloc<AddRouteSurveyEvent, AddRouteSurveyState> {

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  List<AlignmentModel> _alignmentList = [];
  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData =  AlignmentModel();
  AlignmentModel get alignmentData => _alignmentData;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController tpChainageController = TextEditingController();
  TextEditingController tpChainageNumberController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController bearingAngleController = TextEditingController();
  TextEditingController terrainController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  File file = File("");

  AddRouteSurveyBloc() : super(AddRouteSurveyInitial()) {
    on<AddRouteSurveyPageLoadEvent>(_pageLoadEvent);
    on<AddRouteSurveySubmitDataEvent>(_submitData);
    on<AddRouteSurveySelectAlignmentEvent>(_selectAlignment);
    on<AddRouteSurveySelectDateEvent>(_selectDate);
    on<AddRouteSurveyAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddRouteSurveyPageLoadEvent event, emit) async {
    emit(AddRouteSurveyPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    tpChainageController.text = "";
    tpChainageNumberController.text = "";
    tpRemarkNumberController.text = "";
    bearingAngleController.text = "";
    terrainController.text = "";
    activityRemarkController.text = "";
    _isLoader =  false;
    _alignmentList =  [];
    file = File("");
    _alignmentData =  AlignmentModel();
    _userData =  UserInfo.instanceInit()!.userData!;
    var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: event.context, userData: userData);
    if(res != null){
      _alignmentList =  res;
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddRouteSurveySelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddRouteSurveySelectDateEvent event, emit) async {
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

  _selectFile(AddRouteSurveyAddImageEvent event, emit) async {
    var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
    if(photo != null){
      file  = photo;
    }
    _eventComplete(emit);
  }

  _submitData(AddRouteSurveySubmitDataEvent event, emit) async  {
    var textFiledValidation =  await AddRouteSurveyHelper.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        tpIpChainage: tpChainageController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark:tpRemarkNumberController.text.toString(),
        bearing: bearingAngleController.text.toString(),
        terrain: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString());
    if(textFiledValidation == false){
      return;
    }
    _isLoader =  true;
    _eventComplete(emit);
    var res =  await AddRouteSurveyHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        tpIpChainage: tpChainageController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark:tpRemarkNumberController.text.toString(),
        bearing: bearingAngleController.text.toString(),
        terrain: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData, file: file);
    _isLoader =  false;
    _eventComplete(emit);
    if(res != null){
      dateController.text = "";
      reportNumberController.text = "";
      tpChainageController.text = "";
      tpChainageNumberController.text = "";
      tpRemarkNumberController.text = "";
      bearingAngleController.text = "";
      terrainController.text = "";
      activityRemarkController.text = "";
      _isLoader =  false;
      _alignmentData =  AlignmentModel();
      _eventComplete(emit);
    }

  }

 _eventComplete(Emitter<AddRouteSurveyState>emit) {
    emit(FetchAddRouteSurveyDataState(isLoader: isLoader,
        alignmentList: alignmentList,
        dateController: dateController,
        activityRemarkController: activityRemarkController,
        bearingAngleController: bearingAngleController,
        reportNumberController: reportNumberController,
        terrainController: terrainController,
        tpChainageController: tpChainageController,
        tpChainageNumberController: tpChainageNumberController,
        tpRemarkNumberController: tpRemarkNumberController,
        alignmentData: alignmentData,
        file: file,
    ));
 }

}