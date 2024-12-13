import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/domain/model/lpt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

import '../../helper/add_lpt_helper.dart';

part 'add_lpt_event.dart';

part 'add_lpt_state.dart';

class AddLptBloc extends Bloc<AddLptEvent, AddLptState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController observationResultsController = TextEditingController();
  TextEditingController searchPipeController = TextEditingController();

  List<JointNumberModel> jointList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  bool isLoader = false;
  JointNumberModel jointData = JointNumberModel();
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<LptStatusModel> lptStatusList = [];
  LptStatusModel lptStatusData = LptStatusModel();

  List<PipeModel> _pipeList = [];

  List<PipeModel> get pipeList => _pipeList;

  List<PipeModel> _searchPipeList = [];

  List<PipeModel> get searchPipeList => _searchPipeList;

  bool _searchPipeLoader = false;

  bool get searchPipeLoader => _searchPipeLoader;

  PipeModel _pipeData = PipeModel();

  PipeModel get pipeData => _pipeData;

  AddLptBloc() : super(AddLptInitial()) {
    on<AddLptPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddLptSelectAlignmentEvent>(_selectAlignment);
    on<AddLptSelectJointDataEvent>(_selectJointTo);
    on<AddLptSelectJointTypeDataEvent>(_selectJointType);
    on<AddLptSelectLptStatusDataEvent>(_selectLptStatus);
    on<AddLptSelectDateEvent>(_selectDate);
    on<AddLptSearchPipeDataEvent>(_searchPipeNumber);
    on<AddLptSelectPipeDataEvent>(_selectPipe);
    on<AddLptAddImageEvent>(_selectFile);
    on<AddLptSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddLptPageLoadEvent event, emit) async {
    emit(AddLptPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    observationResultsController.text = "";
    searchPipeController.text = "";
    _searchPipeLoader = false;
    jointList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    _pipeList = [];
    _searchPipeList = [];
    alignmentData = AlignmentModel();
    isLoader = false;
    jointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    weatherData = WeatherModel();
    lptStatusData = LptStatusModel();
    _pipeData = PipeModel();
    lptStatusList = [];
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }

/*    var resJointType = await AddWeldingHelper.fetchJointType(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resJointType != null) {
      jointTypeList = resJointType;
    }*/

    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData,
        jointTypeData: jointTypeData);
    if (resJointNumber != null) {
      jointList = resJointNumber;
    }

    var resLpt = await AddLptHelper.fetchLptData(
        context: !event.context.mounted ? event.context : event.context);
    if (resLpt != null) {
      lptStatusList = resLpt;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddLptSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _searchPipeNumber(AddLptSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader = true;
    _eventComplete(emit);
    var resPipe = await AddStringingHelper.fetchPipeData(
        context: event.context,
        userData: userData,
        searchKeyword: event.keyword.toString(),
        type: "lpt");
    if (resPipe != null) {
      _pipeList = resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader = false;
    _eventComplete(emit);
  }

  _selectPipe(AddLptSelectPipeDataEvent event, emit) {
    _pipeData = event.pipeData;
    _pipeList = [];
    searchPipeController.text =
        "${pipeData.pipeNumber.toString()}|${pipeData.heatNumber.toString()}|${pipeData.pipeLength.toString()}";
    _eventComplete(emit);
  }

  _selectJointTo(AddLptSelectJointDataEvent event, emit) {
    jointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddLptSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointList = [];
    jointData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        jointTypeData: jointTypeData);
    if (resJointNumber != null) {
      jointList = resJointNumber;
    }
    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectLptStatus(AddLptSelectLptStatusDataEvent event, emit) {
    lptStatusData = event.lptStatusData;
    _eventComplete(emit);
  }

  _selectDate(AddLptSelectDateEvent event, emit) async {
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

  _selectFile(AddLptAddImageEvent event, emit) async {
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

  _submitData(AddLptSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddLptHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        jointData: jointData,
        lptStatusData: lptStatusData,
        observationResults: observationResultsController.text.toString(),
        pipeData: pipeData,
        file: file);
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      observationResultsController.text = "";
      alignmentData = AlignmentModel();
      isLoader = false;
      jointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      lptStatusData = LptStatusModel();
      _pipeData = PipeModel();
      searchPipeController.text = "";
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddLptState> emit) {
    emit(FetchAddLptDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      reportNumberController: reportNumberController,
      observationResultsController: observationResultsController,
      alignmentData: alignmentData,
      file: file,
      weatherList: weatherList,
      weatherData: weatherData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      jointData: jointData,
      jointList: jointList,
      lptStatusData: lptStatusData,
      lptStatusList: lptStatusList,
      pipeList: pipeList,
      searchPipeLoader: searchPipeLoader,
      searchPipeController: searchPipeController,
    ));
  }
}
