import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/aut_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_layer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/domain/model/defect_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtAut/addNdtAut/helper/add_ndt_aut_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_ndt_aut_event.dart';

part 'add_ndt_aut_state.dart';

class AddNdtAutBloc extends Bloc<AddNdtAutEvent, AddNdtAutState> {
  List<WelderModel> welderList = [];
  List<WelderModel> selectedWelderList = [];
  List<WPSModel> wpsTypeList = [];
  WPSModel wpsTypeData = WPSModel();
  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  TextEditingController dateController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController defectLocationController = TextEditingController();
  File file = File("");
  bool isLoader = false;
  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();
  List<JointTypeModel> jointTypeList = [];
  JointTypeModel jointTypeData = JointTypeModel();
  List<JointNumberModel> jointNumberList = [];
  JointNumberModel jointNumberData = JointNumberModel();
  bool isJointNumberLoader = false;
  bool isWelderLoader = false;
  List<AutStatusModel> autStatusList = [];
  AutStatusModel autStatusData = AutStatusModel();
  List<DefectLayerModel> defectLayerList = [];
  List<DefectLayerModel> selectedDefectLayerList = [];
  List<DefectTypeModel> defectTypeList = [];
  List<DefectTypeModel> selectedDefectTypeList = [];

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  AddNdtAutBloc() : super(AddNdtAutInitial()) {
    on<AddNdtAutLoadEvent>(_pageLoad);
    on<AddNdtAutSelectDateEvent>(_selectDate);
    on<AddNdtAutSelectAlignmentEvent>(_selectAlignment);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddNdtAutSelectJointTypeEvent>(_selectJointType);
    on<AddNdtAutSelectAutDataEvent>(_selectAutStatus);
    on<AddNdtAutSelectDefectTypeEvent>(_selectDefectType);
    on<AddNdtAutSelectDefectLayerEvent>(_selectDefectLayer);
    on<AddNdtAutSelectJointNumberEvent>(_selectJointNumber);
    on<AddNdtAutSelectWPSTypeEvent>(_selectWpsType);
    on<AddNdtAutSelectWelderEvent>(_selectWelder);
    on<AddNdtAutAddImageEvent>(_selectFile);
    on<AddNdtAutSubmitDataEvent>(_submit);
  }

  _pageLoad(AddNdtAutLoadEvent event, emit) async {
    emit(AddNdtAutPageLoadState());
    welderList = [];
    selectedWelderList = [];
    wpsTypeList = [];
    wpsTypeData = WPSModel();
    alignmentList = [];
    alignmentData = AlignmentModel();
    dateController.text = "";
    activityRemarkController.text = "";
    defectLocationController.text = "";
    file = File("");
    isLoader = false;
    weatherList = [];
    weatherData = WeatherModel();
    jointTypeList = [];
    jointTypeData = JointTypeModel();
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    isJointNumberLoader = false;
    isWelderLoader = false;
    autStatusList = [];
    autStatusData = AutStatusModel();
    defectLayerList = [];
    selectedDefectLayerList = [];
    defectTypeList = [];
    selectedDefectTypeList = [];
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);
    _userData = UserInfo.instanceInit()!.userData!;

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
    var resWPS = await AddWeldingHelper.fetchWPSType(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resWPS != null) {
      wpsTypeList = resWPS;
    }

    var resDefectType = await AddNdtAutHelper.fetchDefectTypeData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resDefectType != null) {
      defectTypeList = resDefectType;
    }
    var resDefectLayer = await AddNdtAutHelper.fetchDefectLayerData(
        context: !event.context.mounted ? event.context : event.context);
    if (resDefectLayer != null) {
      defectLayerList = resDefectLayer;
    }
    var resAut = await AddNdtAutHelper.fetchAutStatusData(
        context: !event.context.mounted ? event.context : event.context);
    if (resAut != null) {
      autStatusList = resAut;
    }
    _eventComplete(emit);
  }

  _selectDate(AddNdtAutSelectDateEvent event, emit) async {
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

  _selectAlignment(AddNdtAutSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectJointType(AddNdtAutSelectJointTypeEvent event, emit) async {
    jointTypeData = event.jointTypeModel;
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        jointTypeData: jointTypeData);
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }
    isJointNumberLoader = false;
    _eventComplete(emit);
    _eventComplete(emit);
  }

  _selectAutStatus(AddNdtAutSelectAutDataEvent event, emit) {
    autStatusData = event.autStatusData;
    _eventComplete(emit);
  }

  _selectDefectType(AddNdtAutSelectDefectTypeEvent event, emit) {
    selectedDefectTypeList = event.selectedDefectType;
    _eventComplete(emit);
  }

  _selectDefectLayer(AddNdtAutSelectDefectLayerEvent event, emit) {
    selectedDefectLayerList = event.selectedDefectLayer;
    _eventComplete(emit);
  }

  _selectJointNumber(AddNdtAutSelectJointNumberEvent event, emit) {
    jointNumberData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectWpsType(AddNdtAutSelectWPSTypeEvent event, emit) async {
    wpsTypeData = event.wpsTypeData;
    isWelderLoader = true;
    _eventComplete(emit);
    selectedWelderList = [];
    var resWelder = await AddWeldingHelper.fetchWelderData(
        context: event.context, userData: userData, wpsData: wpsTypeData);
    if (resWelder != null) {
      welderList = resWelder;
    }
    isWelderLoader = false;
    _eventComplete(emit);
  }

  _selectWelder(AddNdtAutSelectWelderEvent event, emit) {
    selectedWelderList = event.selectedWelderList;
    _eventComplete(emit);
  }

  _selectFile(AddNdtAutAddImageEvent event, emit) async {
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

  _submit(AddNdtAutSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);

    var res = await AddNdtAutHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        jointNumberData: jointNumberData,
        wpsTypeData: wpsTypeData,
        selectedWelderList: selectedWelderList,
        selectedDefectTypeList: selectedDefectTypeList,
        selectedDefectLayer: selectedDefectLayerList,
        defectLocation: defectLocationController.text.toString(),
        autStatusData: autStatusData,
        file: file);

    if (res != null) {
      selectedWelderList = [];
      wpsTypeData = WPSModel();
      alignmentData = AlignmentModel();
      dateController.text = "";
      activityRemarkController.text = "";
      defectLocationController.text = "";
      file = File("");
      isLoader = false;
      weatherData = WeatherModel();
      jointTypeData = JointTypeModel();
      jointNumberData = JointNumberModel();
      isJointNumberLoader = false;
      isWelderLoader = false;
      autStatusData = AutStatusModel();
      selectedDefectLayerList = [];
      selectedDefectTypeList = [];
      weatherList = await DashboardHelper.fetchWeatherData(
          context: !event.context.mounted ? event.context : event.context,
          userData: userData);
      _userData = UserInfo.instanceInit()!.userData!;
    }

    isLoader = false;
    _eventComplete(emit);
  }

  _eventComplete(Emitter<AddNdtAutState> emit) {
    emit(FetchAddNdtAutDataState(
      selectedWelderList: selectedWelderList,
      welderList: welderList,
      wpsTypeData: wpsTypeData,
      wpsTypeList: wpsTypeList,
      dateController: dateController,
      file: file,
      activityRemarkController: activityRemarkController,
      alignmentData: alignmentData,
      alignmentList: alignmentList,
      isLoader: isLoader,
      weatherData: weatherData,
      weatherList: weatherList,
      jointNumberList: jointNumberList,
      jointNumberData: jointNumberData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      isWelderLoader: isWelderLoader,
      defectLocationController: defectLocationController,
      autStatusData: autStatusData,
      autStatusList: autStatusList,
      defectLayerList: defectLayerList,
      defectTypeList: defectTypeList,
      selectedDefectLayerList: selectedDefectLayerList,
      selectedDefectTypeList: selectedDefectTypeList,
    ));
  }
}
