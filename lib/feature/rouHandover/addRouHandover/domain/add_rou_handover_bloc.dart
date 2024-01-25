import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/rouHandover/addRouHandover/helper/add_rou_handover_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_rou_handover_event.dart';
part 'add_rou_handover_state.dart';

class AddRouHandoverBloc extends Bloc<AddRouHandoverEvent, AddRouHandoverState> {

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  List<AlignmentModel> _alignmentList = [];
  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData =  AlignmentModel();
  AlignmentModel get alignmentData => _alignmentData;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController typeofGroundController = TextEditingController();
  TextEditingController tpChainageNumberController = TextEditingController();
  TextEditingController tpRemarkController = TextEditingController();
  TextEditingController bearingAngleController = TextEditingController();
  TextEditingController terrainController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  File file = File("");
  
  AddRouHandoverBloc() : super(AddRouHandoverInitial()) {
    on<AddRouHandoverLoadEvent>(_pageLoadEvent);
    on<AddRouHandoverSubmitDataEvent>(_submitData);
    on<AddRouHandoverSelectAlignmentEvent>(_selectAlignment);
    on<AddRouHandoverSelectDateEvent>(_selectDate);
    on<AddRouHandoverAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddRouHandoverLoadEvent event, emit) async {
    emit(AddRouHandoverLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    typeofGroundController.text = "";
    tpChainageNumberController.text = "";
    tpRemarkController.text = "";
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

  _selectAlignment(AddRouHandoverSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddRouHandoverSelectDateEvent event, emit) async {
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

  _selectFile(AddRouHandoverAddImageEvent event, emit) async {
    var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
    if(photo != null){
      file  = photo;
    }
    _eventComplete(emit);
  }

  _submitData(AddRouHandoverSubmitDataEvent event, emit) async  {
    var textFiledValidation =  await AddRouHandover.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        typeofGround: typeofGroundController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark:tpRemarkController.text.toString(),
        bearing: bearingAngleController.text.toString(),
        terrain: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString());
    if(textFiledValidation == false){
      return;
    }
    _isLoader =  true;
    _eventComplete(emit);
    var res =  await AddRouHandover.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        typeofGround: typeofGroundController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark:tpRemarkController.text.toString(),
        bearing: bearingAngleController.text.toString(),
        terrain: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData, file: file);
    _isLoader =  false;
    _eventComplete(emit);
    if(res != null){
      dateController.text = "";
      reportNumberController.text = "";
      typeofGroundController.text = "";
      tpChainageNumberController.text = "";
      tpRemarkController.text = "";
      bearingAngleController.text = "";
      terrainController.text = "";
      activityRemarkController.text = "";
      _isLoader =  false;
      _alignmentData =  AlignmentModel();
      _eventComplete(emit);
    }

  }

  _eventComplete(Emitter<AddRouHandoverState>emit) {
    emit(FetchAddRouHandoverDataState(isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      bearingAngleController: bearingAngleController,
      reportNumberController: reportNumberController,
      terrainController: terrainController,
      typeofGroundController: typeofGroundController,
      tpChainageNumberController: tpChainageNumberController,
      tpRemarkController: tpRemarkController,
      alignmentData: alignmentData,
      file: file,
    ));
  }
}
