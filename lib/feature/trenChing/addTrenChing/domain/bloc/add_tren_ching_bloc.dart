import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/hepler/add_tren_ching_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_tren_ching_event.dart';
part 'add_tren_ching_state.dart';

class AddTrenChingBloc extends Bloc<AddTrenChingEvent, AddTrenChingState> {

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  List<AlignmentModel> _alignmentList = [];
  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData =  AlignmentModel();
  AlignmentModel get alignmentData => _alignmentData;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController toJointIdController = TextEditingController();
  TextEditingController trenchingDepthController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController fromJointIdController = TextEditingController();
  TextEditingController terrainController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  List<JointNumberModel>  _jointNumberList =  [];
  List<JointNumberModel>  get jointNumberList => _jointNumberList;

  JointNumberModel _jointNumberData =  JointNumberModel();
  JointNumberModel get jointNumberData => _jointNumberData;

  File file = File("");

  AddTrenChingBloc() : super(AddTrenChingInitial()) {
    on<AddTrenChingPageLoadEvent>(_pageLoadEvent);
    on<AddTrenChingSelectAlignmentEvent>(_selectAlignment);
    on<AddTrenChingSelectDateEvent>(_selectDate);
    on<AddTrenChingAddImageEvent>(_selectFile);
    on<AddTrenChingSubmitDataEvent>(_submitData);
  }

  _pageLoadEvent(AddTrenChingPageLoadEvent event, emit) async {
    emit(AddTrenChingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    fromJointIdController.text = "";
    toJointIdController.text = "";
    tpRemarkNumberController.text = "";
    trenchingDepthController.text = "";
    terrainController.text = "";
    activityRemarkController.text = "";
    _isLoader =  false;
    _alignmentList =  [];
    file = File("");
    _alignmentData =  AlignmentModel();
    _jointNumberData =  JointNumberModel();
    _jointNumberList = [];
    _userData =  UserInfo.instanceInit()!.userData!;
    var res =  await AddRouteSurveyHelper.fetchAlignmentData(context: event.context, userData: userData);
    if(res != null){
      _alignmentList =  res;
    }

    var resJoint    =  await AddTrenChingHelper.fetchjointNumberData(context: event.context, userData: userData);
    if(resJoint != null){
      _jointNumberList =  resJoint;
    }

    _eventComplete(emit);
  }

  _selectAlignment(AddTrenChingSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddTrenChingSelectDateEvent event, emit) async {
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

  _selectFile(AddTrenChingAddImageEvent event, emit) async {
    var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
    if(photo != null){
      file  = photo;
    }
    _eventComplete(emit);
  }

  _submitData(AddTrenChingSubmitDataEvent event, emit) async {
    var textFiledValidation =  await AddTrenChingHelper.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        fromJointId: fromJointIdController.text.toString(),
        toJointId: toJointIdController.text.toString(),
        trenchingDepth:trenchingDepthController.text.toString(),
        terrainType: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString()
    );
    if(textFiledValidation == false){
      return;
    }
    _isLoader =  true;
    _eventComplete(emit);
    var res =  await AddTrenChingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        fromJointId: fromJointIdController.text.toString(),
        toJointId: toJointIdController.text.toString(),
        trenchingDepth:trenchingDepthController.text.toString(),
        terrainType: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData, file: file);
    _isLoader =  false;
    _eventComplete(emit);
    if(res != null){
      dateController.text = "";
      reportNumberController.text = "";
      fromJointIdController.text = "";
      toJointIdController.text = "";
      tpRemarkNumberController.text = "";
      terrainController.text = "";
      trenchingDepthController.text = "";
      activityRemarkController.text = "";
      _isLoader =  false;
      _alignmentData =  AlignmentModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddTrenChingState>emit) {
    emit(FetchAddTrenChingDataState(isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      fromJointIdController: fromJointIdController,
      reportNumberController: reportNumberController,
      terrainController: terrainController,
      toJointIdController: toJointIdController,
      trenchingDepthController: trenchingDepthController,
      alignmentData: alignmentData,
      file: file,
      jointNumberList: jointNumberList,
      jointNumberData: jointNumberData,
    ));
  }
}
