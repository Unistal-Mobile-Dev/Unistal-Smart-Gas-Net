import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/helper/add_concrete_coating_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/helper/add_radiography_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welderRepair/addWelderRepair/helper/add_welder_repair_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_welder_repair_event.dart';
part 'add_welder_repair_state.dart';

class AddWelderRepairBloc extends Bloc<AddWelderRepairEvent, AddWelderRepairState> {
  List<WelderModel> welderList = [];
  WelderModel welderData = WelderModel();
  List<WPSModel> wpsTypeList = [];
  WPSModel wpsTypeData = WPSModel();
  List<SegmentModel> segmentStatusList = [];
  List<SegmentModel> selectedSegmentStatusList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController e6010Controller = TextEditingController();
  TextEditingController e8010P1Controller = TextEditingController();
  TextEditingController e9045P2Controller = TextEditingController();
  TextEditingController er70s6Controller = TextEditingController();
  TextEditingController e81TM21ABController = TextEditingController();
  TextEditingController preHeatingTemperatureController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController rootPassController = TextEditingController();
  TextEditingController hotPassController = TextEditingController();
  TextEditingController otherPassController = TextEditingController();
  TextEditingController locationController= TextEditingController();
  TextEditingController proposedLengthController= TextEditingController();


  File file = File("");
  bool isLoader = false;
  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();
  List<JointTypeModel> jointTypeList = [];
  JointTypeModel jointTypeData = JointTypeModel();
  List<JointNumberModel> jointNumberList = [];
  JointNumberModel jointNumberData = JointNumberModel();

  VisualChecksModel _weldVisualData = VisualChecksModel();
  VisualChecksModel get weldVisualData => _weldVisualData;
  List<VisualChecksModel> _weldVisualList = [];
  List<VisualChecksModel> get weldVisualList => _weldVisualList;

  List<ThicknessModel> listOfPipeThickness = [];
  ThicknessModel pipeThicknessValue = ThicknessModel();


  bool isJointNumberLoader = false;
  bool isWelderLoader = false;

  LoginDataModel _userData = LoginDataModel();
  LoginDataModel get userData => _userData;

  AddWelderRepairBloc() : super(AddWelderRepairInitial()) {
    on<AddWelderRepairLoadEvent>(_pageLoad);
    on<AddWelderRepairSelectDateEvent>(_selectDate);
    on<AddWelderRepairSelectAlignmentEvent>(_selectAlignment);
    on<AddWelderRepairMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddWeldingCalculateLengthEvent>(_calculateChainage);
    on<AddLoweringSelectPipeThicknessEvent>(_selectPipeThickness);
    on<AddWelderRepairSelectJointTypeEvent>(_selectJointType);
    on<AddWelderRepairSelectJointNumberEvent>(_selectJointNumber);
    on<AddWelderRepairSelectWeldVisualEvent>(_selectWelderRepairStatus);
    on<AddWelderRepairSelectSegmentEvent>(_selectSegment);
    on<AddWelderRepairSelectWPSTypeEvent>(_selectWpsType);
    on<AddWelderRepairSelectWelderEvent>(_selectWelder);
    on<AddWelderRepairAddImageEvent>(_selectFile);
    on<AddWelderRepairSubmitDataEvent>(_submit);
  }

  _pageLoad(AddWelderRepairLoadEvent event, emit) async {
    emit(AddWelderRepairPageLoadState());
    welderData = WelderModel();
    wpsTypeData = WPSModel();
    jointNumberData = JointNumberModel();
    jointTypeData = JointTypeModel();
    alignmentData =  AlignmentModel();
    weatherData = WeatherModel();
    _weldVisualData = VisualChecksModel();
    pipeThicknessValue = ThicknessModel();
    multipleAlignmentData = [];
    listOfPipeThickness = [];
    weatherList = [];
    alignmentList = [];
    jointTypeList = [];
    jointNumberList = [];
    _weldVisualList = [];
    selectedSegmentStatusList = [];
    welderList = [];
    wpsTypeList = [];
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    e6010Controller.text = "";
    e8010P1Controller.text = "";
    e9045P2Controller.text = "";
    er70s6Controller.text = "";
    e81TM21ABController.text = "";
    preHeatingTemperatureController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    lengthController.text = "";
    rootPassController.text = "";
    hotPassController.text = "";
    otherPassController.text = "";
    locationController.text = "";
    proposedLengthController.text = "";
    isWelderLoader = false;
    isJointNumberLoader = false;
    isLoader = false;
    file = File("");
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData();

    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }

    var resJointType = await DashboardHelper.fetchJointType();
    if (resJointType != null) {
      jointTypeList = resJointType;
    }
    var thicknessRes = await AddConcreteCoatingHelper.fetchThicknessData();
    if (thicknessRes != null) {
      listOfPipeThickness = thicknessRes;
    }
    var resJointNumber = await DashboardHelper.fetchJointNumberData(
      type:  AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
          ? AppConfig.instanceInit()!.activitySectionData.appJoint!
          :"afterndtrtreject",
    );
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }

    var resSegment = await AddRadiographyHelper.fetchSegmentData(
        context: !event.context.mounted ? event.context : event.context, userData: userData, welderList: welderList);
    if (resSegment != null) {
      segmentStatusList = resSegment;
    }
    var resVisual = await AddBendingHelper.fetchVisualChecks();
    if (resVisual != null) {
      _weldVisualList = resVisual;
    }


    var resWPS = await DashboardHelper.fetchWPSType();
    if (resWPS != null) {
      wpsTypeList = resWPS;
    }

    _eventComplete(emit);
  }

  _selectDate(AddWelderRepairSelectDateEvent event, emit) async {
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

  _selectAlignment(AddWelderRepairSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddWelderRepairMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _calculateChainage(AddWeldingCalculateLengthEvent event, emit) {
    bool isChainageTo = event.isChainageTo;
    String value = event.value;
    if (value.isEmpty) {
      lengthController.text = "";
    } else if (isChainageTo == true &&
        value.isNotEmpty &&
        chainageFromController.text.toString().isNotEmpty) {
      double chainageTo = double.parse(value.toString());
      double chainageFrom =
      double.parse(chainageFromController.text.toString());
      lengthController.text = "${chainageTo - chainageFrom}";
    } else if (isChainageTo == false &&
        value.isNotEmpty &&
        chainageToController.text.toString().isNotEmpty) {
      double chainageTo = double.parse(chainageToController.text.toString());
      double chainageFrom = double.parse(value);
      lengthController.text = "${chainageTo - chainageFrom}";
    }
    _eventComplete(emit);
  }

  _selectPipeThickness(AddLoweringSelectPipeThicknessEvent event, emit) {
    pipeThicknessValue = event.pipeThicknessValue;
    _eventComplete(emit);
  }

  _selectJointType(AddWelderRepairSelectJointTypeEvent event, emit) async {
    jointTypeData = event.jointTypeModel;
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);

    isJointNumberLoader = false;
    _eventComplete(emit);
    _eventComplete(emit);
  }

  _selectWelderRepairStatus(AddWelderRepairSelectWeldVisualEvent event, emit) {
    _weldVisualData = event.weldVisualData;
    _eventComplete(emit);
  }

  _selectJointNumber(AddWelderRepairSelectJointNumberEvent event, emit) {
    jointNumberData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectSegment(AddWelderRepairSelectSegmentEvent event, emit) {
    selectedSegmentStatusList = event.selectedSegmentList;
    _eventComplete(emit);
  }

  _selectWpsType(AddWelderRepairSelectWPSTypeEvent event, emit) async {
    wpsTypeData = event.wpsTypeData;
    isWelderLoader = true;
    _eventComplete(emit);
    welderData = WelderModel();
    var resWelder = await DashboardHelper.fetchWelderData(wpsData: wpsTypeData);
    if (resWelder != null) {
      welderList = resWelder;
    }
    isWelderLoader = false;
    _eventComplete(emit);
  }

  _selectWelder(AddWelderRepairSelectWelderEvent event, emit) {
    welderData = event.welderData;
    _eventComplete(emit);
  }

  _selectFile(AddWelderRepairAddImageEvent event, emit) async {
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

  _submit(AddWelderRepairSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);

    var res = await AddWelderRepairHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        date: dateController.text.toString(),
        reportNo: reportNumberController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        jointNumberData: jointNumberData,
        segmentList: selectedSegmentStatusList,
        weldVisualData: weldVisualData,
        wpsTypeData: wpsTypeData,
        welderData: welderData,
        e6010: e6010Controller.text.toString(),
        e8010P1: e8010P1Controller.text.toString(),
        e9045P2: e9045P2Controller.text.toString(),
        er70s6: er70s6Controller.text.toString(),
        e81TM21AB: e81TM21ABController.text.toString(),
        preHeatingTemperature: preHeatingTemperatureController.text.toString(),
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        totalLength: lengthController.text.toString(),
        hotPass: hotPassController.text.toString(),
        otherPass: otherPassController.text.toString(),
        location: locationController.text.toString(),
        proposedLength: proposedLengthController.text.toString(),
        rootPass: rootPassController.text.toString(),

        file: file);
    if (res != null) {
      welderData = WelderModel();
      wpsTypeData = WPSModel();
      weatherData = WeatherModel();
      jointNumberData = JointNumberModel();
      jointTypeData = JointTypeModel();
      alignmentData =  AlignmentModel();
      multipleAlignmentData = [];
      _weldVisualData = VisualChecksModel();
      selectedSegmentStatusList = [];
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      e6010Controller.text = "";
      e8010P1Controller.text = "";
      e9045P2Controller.text = "";
      er70s6Controller.text = "";
      e81TM21ABController.text = "";
      preHeatingTemperatureController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      lengthController.text = "";
      rootPassController.text = "";
      hotPassController.text = "";
      otherPassController.text = "";
      locationController.text = "";
      proposedLengthController.text = "";
      isWelderLoader = false;
      isJointNumberLoader = false;
      isLoader = false;
      file = File("");
      _userData = UserInfo.instanceInit()!.userData!;
      weatherList = await DashboardHelper.fetchWeatherData();
    }

    isLoader = false;
    _eventComplete(emit);
  }

  _eventComplete(Emitter<AddWelderRepairState> emit) {
    emit(FetchAddWelderRepairDataState(
      welderData: welderData,
      welderList: welderList,
      wpsTypeData: wpsTypeData,
      wpsTypeList: wpsTypeList,
      segmentStatusList: segmentStatusList,
      selectedSegmentStatusList: selectedSegmentStatusList,
      dateController: dateController,
      reportNumberController: reportNumberController,
      file: file,
      activityRemarkController: activityRemarkController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      alignmentList: alignmentList,
      e81TM21ABController: e81TM21ABController,
      e6010Controller: e6010Controller,
      e8010P1Controller: e8010P1Controller,
      e9045P2Controller: e9045P2Controller,
      er70s6Controller: er70s6Controller,
      isLoader: isLoader,
      weatherData: weatherData,
      weatherList: weatherList,
      jointNumberList: jointNumberList,
      jointNumberData: jointNumberData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      weldVisualData: weldVisualData,
      weldVisualList: weldVisualList,
      isJointNumberLoader: isJointNumberLoader,
      preHeatingTemperatureController: preHeatingTemperatureController,
      isWelderLoader: isWelderLoader,
      listOfPipeThickness: listOfPipeThickness,
      pipeThicknessValue: pipeThicknessValue,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      lengthController: lengthController,
      hotPassController: hotPassController,
      otherPassController: otherPassController,
      rootPassController: rootPassController,
      locationController: locationController,
      proposedLengthController: proposedLengthController,
    ));
  }
}
