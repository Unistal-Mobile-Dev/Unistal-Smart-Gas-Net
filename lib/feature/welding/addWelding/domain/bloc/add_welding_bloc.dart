import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_welding_event.dart';
part 'add_welding_state.dart';

class AddWeldingBloc extends Bloc<AddWeldingEvent, AddWeldingState> {
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  List<WelderModel> rootWelders1List = [];
  List<WelderModel> rootWelders2List = [];
  List<WelderModel> hotWelders1List = [];
  List<WelderModel> hotWelders2List = [];
  List<WelderModel> filler1Welders1List = [];
  List<WelderModel> filler1Welders2List = [];
  List<WelderModel> filler2Welders1List = [];
  List<WelderModel> filler2Welders2List = [];
  List<WelderModel> filler3Welders1List = [];
  List<WelderModel> filler3Welders2List = [];
  List<WelderModel> filler4Welders1List = [];
  List<WelderModel> filler4Welders2List = [];
  List<WelderModel> filler5Welders1List = [];
  List<WelderModel> filler5Welders2List = [];
  List<WelderModel> filler6Welders1List = [];
  List<WelderModel> filler6Welders2List = [];
  List<WelderModel> filler7Welders1List = [];
  List<WelderModel> filler7Welders2List = [];
  List<WelderModel> filler8Welders1List = [];
  List<WelderModel> filler8Welders2List = [];

  List<WelderModel> cappingWelder1List = [];
  List<WelderModel> cappingWelder2List = [];
  List<WelderModel> stripWelder1List = [];
  List<WelderModel> stripWelder2List = [];

  WelderModel rootWelders1Data = WelderModel();
  WelderModel rootWelders2Data = WelderModel();
  WelderModel hotWelders1Data = WelderModel();
  WelderModel hotWelders2Data = WelderModel();
  WelderModel filler1Welders1Data = WelderModel();
  WelderModel filler1Welders2Data = WelderModel();
  WelderModel filler2Welders1Data = WelderModel();
  WelderModel filler2Welders2Data = WelderModel();
  WelderModel filler3Welders1Data = WelderModel();
  WelderModel filler3Welders2Data = WelderModel();
  WelderModel filler4Welders1Data = WelderModel();
  WelderModel filler4Welders2Data = WelderModel();
  WelderModel filler5Welders1Data = WelderModel();
  WelderModel filler5Welders2Data = WelderModel();
  WelderModel filler6Welders1Data = WelderModel();
  WelderModel filler6Welders2Data = WelderModel();
  WelderModel filler7Welders1Data = WelderModel();
  WelderModel filler7Welders2Data = WelderModel();
  WelderModel filler8Welders1Data = WelderModel();
  WelderModel filler8Welders2Data = WelderModel();

  WelderModel cappingWelder1Data = WelderModel();
  WelderModel cappingWelder2Data = WelderModel();
  WelderModel stripWelder1Data = WelderModel();
  WelderModel stripWelder2Data = WelderModel();

  TextEditingController electrodeDiaE6010Controller = TextEditingController();
  TextEditingController electrodeDiaE6010BatchController =
      TextEditingController();
  TextEditingController electrodeEiaE8010p1BatchController =
      TextEditingController();
  TextEditingController electrodeEiaE8010p1Controller = TextEditingController();
  TextEditingController electrodeDiaE9045p2Controller = TextEditingController();
  TextEditingController electrodeDiaE9045p2BatchController =
      TextEditingController();
  TextEditingController electrodeDiaE81t8gBatchController =
      TextEditingController();
  TextEditingController electrodeDiaE81t8gController = TextEditingController();

  TextEditingController leftPipeNumberController = TextEditingController();
  TextEditingController rightPipeNumberController = TextEditingController();

  List<VisualChecksModel> _fitupList = [];

  List<VisualChecksModel> get fitupList => _fitupList;

  VisualChecksModel _fitupData = VisualChecksModel();

  VisualChecksModel get fitupData => _fitupData;

  List<VisualChecksModel> _weldVisualList = [];

  List<VisualChecksModel> get weldVisualList => _weldVisualList;

  VisualChecksModel _weldVisualData = VisualChecksModel();

  VisualChecksModel get weldVisualData => _weldVisualData;

  List<AlignmentModel> _alignmentList = [];

  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData = AlignmentModel();

  AlignmentModel get alignmentData => _alignmentData;

  List<WPSModel> _wpsList = [];

  List<WPSModel> get wpsList => _wpsList;

  WPSModel _wpsData = WPSModel();

  WPSModel get wpsData => _wpsData;

  List<WelderModel> _welderList = [];

  List<WelderModel> get welderList => _welderList;

  WelderModel _welderData = WelderModel();

  WelderModel get welderData => _welderData;

  List<JointNumberModel> _jointNumberList = [];

  List<JointNumberModel> get jointNumberList => _jointNumberList;

  JointNumberModel _jointNumberData = JointNumberModel();

  JointNumberModel get jointNumberData => _jointNumberData;

  bool _isLoader = false;

  bool get isLoader => _isLoader;

  File file = File("");

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  bool _isWelderLoader = false;

  bool get isWelderLoader => _isWelderLoader;

  List<JointTypeModel> _jointTypeList = [];

  List<JointTypeModel> get jointTypeList => _jointTypeList;

  JointTypeModel _jointTypeData = JointTypeModel();

  JointTypeModel get jointTypeData => _jointTypeData;

  bool _isJointNumberLoader = false;

  bool get isJointNumberLoader => _isJointNumberLoader;

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();

  List<PipeModel> leftPipeList = [];
  List<PipeModel> rightPipeList = [];

  PipeModel leftPipeData = PipeModel();
  PipeModel rightPipeData = PipeModel();

  List<dynamic> _searchLeftPipeList = [];

  List<dynamic> get searchLeftPipeList => _searchLeftPipeList;

  TextEditingController searchLeftPipeController = TextEditingController();

  bool _searchLeftPipeLoader = false;

  bool get searchLeftPipeLoader => _searchLeftPipeLoader;

  List<dynamic> _searchRightPipeList = [];

  List<dynamic> get searchRightPipeList => _searchRightPipeList;

  TextEditingController searchRightPipeController = TextEditingController();

  bool _searchRightPipeLoader = false;

  bool get searchRightPipeLoader => _searchRightPipeLoader;

  AddWeldingBloc() : super(AddWeldingInitial()) {
    on<AddWeldingPageLoadEvent>(_pageLoadEvent);
    on<AddWeldingSelectWPSEvent>(_selectWPS);
    on<AddWeldingSearchPipeDataEvent>(_searchPipeData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddWeldingSelectLeftPipeDataEvent>(_selectLeftPipe);
    on<AddWeldingSelectRightPipeDataEvent>(_selectRigthPipe);
    on<AddWeldingSelectMultiWelderEvent>(_selectMultiWelder);
    on<AddWeldingSelectWelderEvent>(_selectWelder);
    on<AddWeldingSelectAlignmentEvent>(_selectAlignment);
    on<AddWeldingSelectDateEvent>(_selectDate);
    on<AddWeldingSelectJointTypeEvent>(_selectJointType);
    on<AddWeldingSelectJointNumberEvent>(_selectJointNumber);
    on<AddWeldingSelectFitupDataEvent>(_selectFitUp);
    on<AddWeldingSelectWeldVisualEvent>(_selectWeldVisual);
    on<AddWeldingAddImageEvent>(_selectFile);
    on<AddWeldingSubmitDataEvent>(_submit);
  }

  _pageLoadEvent(AddWeldingPageLoadEvent event, emit) async {
    emit(AddWeldingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    rootWelders1List = [];
    rootWelders2List = [];
    hotWelders1List = [];
    hotWelders2List = [];
    filler1Welders1List = [];
    filler1Welders2List = [];
    filler2Welders1List = [];
    filler2Welders2List = [];
    filler3Welders1List = [];
    filler3Welders2List = [];
    filler4Welders1List = [];
    filler4Welders2List = [];
    filler5Welders1List = [];
    filler5Welders2List = [];
    filler6Welders1List = [];
    filler6Welders2List = [];
    filler7Welders1List = [];
    filler7Welders2List = [];
    filler8Welders1List = [];
    filler8Welders2List = [];
    cappingWelder1List = [];
    cappingWelder2List = [];
    stripWelder1List = [];
    stripWelder2List = [];
    rootWelders1Data = WelderModel();
    rootWelders2Data = WelderModel();
    hotWelders1Data = WelderModel();
    hotWelders2Data = WelderModel();
    filler1Welders1Data = WelderModel();
    filler1Welders2Data = WelderModel();
    filler2Welders1Data = WelderModel();
    filler2Welders2Data = WelderModel();
    filler3Welders1Data = WelderModel();
    filler3Welders2Data = WelderModel();
    filler4Welders1Data = WelderModel();
    filler4Welders2Data = WelderModel();
    filler5Welders1Data = WelderModel();
    filler5Welders2Data = WelderModel();
    filler6Welders1Data = WelderModel();
    filler6Welders2Data = WelderModel();
    filler7Welders1Data = WelderModel();
    filler7Welders2Data = WelderModel();
    filler8Welders1Data = WelderModel();
    filler8Welders2Data = WelderModel();

    cappingWelder1Data = WelderModel();
    cappingWelder2Data = WelderModel();
    stripWelder1Data = WelderModel();
    stripWelder2Data = WelderModel();
    electrodeDiaE81t8gBatchController.text = "";
    electrodeDiaE81t8gController.text = "";
    electrodeDiaE6010BatchController.text = "";
    electrodeDiaE6010Controller.text = "";
    electrodeDiaE9045p2BatchController.text = "";
    electrodeDiaE9045p2Controller.text = "";
    electrodeEiaE8010p1BatchController.text = "";
    electrodeEiaE8010p1Controller.text = "";
    leftPipeNumberController.text = "";
    rightPipeNumberController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    searchLeftPipeController.text = "";
    searchRightPipeController.text = "";
    _searchRightPipeLoader = false;
    _searchLeftPipeLoader = false;

    _welderData = WelderModel();
    _welderList = [];
    _jointNumberData = JointNumberModel();
    _jointNumberList = [];
    _alignmentData = AlignmentModel();
    _alignmentList = [];
    _wpsData = WPSModel();
    _wpsList = [];
    _weldVisualData = VisualChecksModel();
    _weldVisualList = [];
    _fitupData = VisualChecksModel();
    _fitupList = [];
    _isLoader = false;
    _isWelderLoader = false;
    file = File("");
    _jointTypeData = JointTypeModel();
    _jointTypeList = [];
    _weatherData = WeatherModel();
    _weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);
    _userData = UserInfo.instanceInit()!.userData!;
    _isJointNumberLoader = false;
    leftPipeList = [];
    rightPipeList = [];

    leftPipeData = PipeModel();
    rightPipeData = PipeModel();

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: event.context, userData: userData);
    if (res != null) {
      _alignmentList = res;
    }

    var resWPS = await AddWeldingHelper.fetchWPSType(
        context: event.context, userData: userData);
    if (resWPS != null) {
      _wpsList = resWPS;
    }

    var resJointType = await AddWeldingHelper.fetchJointType(
        context: event.context, userData: userData);
    if (resJointType != null) {
      _jointTypeList = resJointType;
    }

    var resVisual =
        await AddBendingHelper.fetchVisualChecks(context: event.context);
    if (resVisual != null) {
      _fitupList = resVisual;
    }

    _weldVisualList = fitupList;

    _eventComplete(emit);
  }

  _searchPipeData(AddWeldingSearchPipeDataEvent event, emit) async {
    if (event.isLeftPipe == true) {
      leftPipeList = [];
      _searchLeftPipeLoader = true;
      _eventComplete(emit);
      var resPipe = await AddStringingHelper.fetchPipeData(
          context: event.context,
          userData: userData,
          searchKeyword: event.keyword.toString(),
          type: "welding");
      if (resPipe != null) {
        leftPipeList = resPipe;
        _searchLeftPipeList = leftPipeList;
      }
      _searchLeftPipeLoader = false;
      _eventComplete(emit);
    } else if (event.isRightPipe == true) {
      rightPipeList = [];
      _searchRightPipeLoader = true;
      _eventComplete(emit);
      var resPipe = await AddStringingHelper.fetchPipeData(
          context: event.context,
          userData: userData,
          searchKeyword: event.keyword.toString(),
          type: "welding");
      if (resPipe != null) {
        rightPipeList = resPipe;
        _searchRightPipeList = rightPipeList;
      }
      _searchRightPipeLoader = false;
      _eventComplete(emit);
    }
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectLeftPipe(AddWeldingSelectLeftPipeDataEvent event, emit) {
    leftPipeData = event.leftPipeData;
    _searchLeftPipeList = [];
    searchLeftPipeController.text = leftPipeData.pipeNumber.toString();
    _eventComplete(emit);
  }

  _selectRigthPipe(AddWeldingSelectRightPipeDataEvent event, emit) {
    rightPipeData = event.rightPipeData;
    _searchRightPipeList = [];
    searchRightPipeController.text = rightPipeData.pipeNumber.toString();
    _eventComplete(emit);
  }

  _selectWPS(AddWeldingSelectWPSEvent event, emit) async {
    _wpsData = event.wpsData;
    _welderList = [];
    _welderData = WelderModel();
    _isWelderLoader = true;
    _eventComplete(emit);
    var resWelder = await AddWeldingHelper.fetchWelderData(
        context: event.context, userData: userData, wpsData: wpsData);
    if (resWelder != null) {
      _welderList = resWelder;
    }
    welderList.forEach((element) {
      print("Name =============== ${element.welderName}");
    });
    rootWelders1List = welderList;
    rootWelders2List = welderList;
    hotWelders1List = welderList;
    hotWelders2List = welderList;
    filler1Welders1List = welderList;
    filler1Welders2List = welderList;
    filler2Welders1List = welderList;
    filler2Welders2List = welderList;
    filler3Welders1List = welderList;
    filler3Welders2List = welderList;
    filler4Welders1List = welderList;
    filler4Welders2List = welderList;
    filler5Welders1List = welderList;
    filler5Welders2List = welderList;
    filler6Welders1List = welderList;
    filler6Welders2List = welderList;
    filler7Welders1List = welderList;
    filler7Welders2List = welderList;
    filler8Welders1List = welderList;
    filler8Welders2List = welderList;
    cappingWelder1List = welderList;
    cappingWelder2List = welderList;
    stripWelder1List = welderList;
    stripWelder2List = welderList;

    stripWelder2List.forEach((element) {});
    _isWelderLoader = false;
    _eventComplete(emit);
  }

  _selectMultiWelder(AddWeldingSelectMultiWelderEvent event, emit) {
    if (event.name == AppString.rootWelders1) {
      rootWelders1Data = event.welderData;
    } else if (event.name == AppString.rootWelders2) {
      rootWelders2Data = event.welderData;
    } else if (event.name == AppString.hotWelders1) {
      hotWelders1Data = event.welderData;
    } else if (event.name == AppString.hotWelders2) {
      hotWelders2Data = event.welderData;
    } else if (event.name == AppString.filler1Welders1) {
      filler1Welders1Data = event.welderData;
    } else if (event.name == AppString.filler1Welders2) {
      filler1Welders2Data = event.welderData;
    } else if (event.name == AppString.filler2Welders1) {
      filler2Welders1Data = event.welderData;
    } else if (event.name == AppString.filler2Welders2) {
      filler2Welders2Data = event.welderData;
    } else if (event.name == AppString.filler3Welders1) {
      filler3Welders1Data = event.welderData;
    } else if (event.name == AppString.filler3Welders2) {
      filler3Welders2Data = event.welderData;
    } else if (event.name == AppString.filler4Welders1) {
      filler4Welders1Data = event.welderData;
    } else if (event.name == AppString.filler4Welders2) {
      filler4Welders2Data = event.welderData;
    } else if (event.name == AppString.filler5Welders1) {
      filler5Welders1Data = event.welderData;
    } else if (event.name == AppString.filler5Welders2) {
      filler5Welders2Data = event.welderData;
    } else if (event.name == AppString.filler6Welders1) {
      filler6Welders1Data = event.welderData;
    } else if (event.name == AppString.filler6Welders2) {
      filler6Welders2Data = event.welderData;
    } else if (event.name == AppString.filler7Welders1) {
      filler7Welders1Data = event.welderData;
    } else if (event.name == AppString.filler7Welders2) {
      filler7Welders2Data = event.welderData;
    } else if (event.name == AppString.filler8Welders1) {
      filler8Welders1Data = event.welderData;
    } else if (event.name == AppString.filler8Welders2) {
      filler8Welders2Data = event.welderData;
    } else if (event.name == AppString.stripWelder1) {
      stripWelder1Data = event.welderData;
    } else if (event.name == AppString.stripWelder2) {
      stripWelder2Data = event.welderData;
    } else if (event.name == AppString.cappingWelder1) {
      cappingWelder1Data = event.welderData;
    } else if (event.name == AppString.cappingWelder2) {
      cappingWelder2Data = event.welderData;
    }

    _eventComplete(emit);
  }

  _selectWelder(AddWeldingSelectWelderEvent event, emit) {
    _welderData = event.welderData;
    _eventComplete(emit);
  }

  _selectAlignment(AddWeldingSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddWeldingSelectDateEvent event, emit) async {

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
      print("Date is not selected");
    }
  }

  _selectJointType(AddWeldingSelectJointTypeEvent event, emit) async {
    _jointTypeData = event.jointTypeData;
    _jointNumberList = [];
    _jointNumberData = JointNumberModel();
    _isJointNumberLoader = true;
    _eventComplete(emit);
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        jointTypeData: jointTypeData);
    if (resJointNumber != null) {
      _jointNumberList = resJointNumber;
    }
    _isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectJointNumber(AddWeldingSelectJointNumberEvent event, emit) async {
    _jointNumberData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectFitUp(AddWeldingSelectFitupDataEvent event, emit) {
    _fitupData = event.fitupData;
    _eventComplete(emit);
  }

  _selectWeldVisual(AddWeldingSelectWeldVisualEvent event, emit) {
    _weldVisualData = event.weldVisualData;
    _eventComplete(emit);
  }

  _selectFile(AddWeldingAddImageEvent event, emit) async {
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
    Navigator.pop(event.context);
    _eventComplete(emit);
  }

  _submit(AddWeldingSubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddWeldingHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      rootWelders1Data: rootWelders1Data,
      rootWelders2Data: rootWelders2Data,
      hotWelders1Data: hotWelders1Data,
      hotWelders2Data: hotWelders2Data,
      filler1Welders1Data: filler1Welders1Data,
      filler1Welders2Data: filler1Welders2Data,
      filler2Welders1Data: filler2Welders1Data,
      filler2Welders2Data: filler2Welders2Data,
      filler3Welders2Data: filler3Welders2Data,
      filler4Welders1Data: filler4Welders1Data,
      filler4Welders2Data: filler4Welders2Data,
      filler3Welders1Data: filler3Welders1Data,
      filler5Welders1Data: filler5Welders1Data,
      filler5Welders2Data: filler5Welders2Data,
      filler6Welders1Data: filler6Welders1Data,
      filler6Welders2Data: filler6Welders2Data,
      filler7Welders1Data: filler7Welders1Data,
      filler7Welders2Data: filler7Welders2Data,
      filler8Welders1Data: filler8Welders1Data,
      filler8Welders2Data: filler8Welders2Data,
      cappingWelder1Data: cappingWelder1Data,
      cappingWelder2Data: cappingWelder2Data,
      stripWelder1Data: stripWelder1Data,
      stripWelder2Data: stripWelder2Data,
      electrodeDiaE81t8gBatch:
          electrodeDiaE81t8gBatchController.text.toString(),
      electrodeDiaE81t8g: electrodeDiaE81t8gController.text.toString(),
      electrodeDiaE6010Batch: electrodeDiaE6010BatchController.text.toString(),
      electrodeDiaE6010: electrodeDiaE6010Controller.text.toString(),
      electrodeDiaE9045p2Batch:
          electrodeDiaE9045p2BatchController.text.toString(),
      electrodeDiaE9045p2: electrodeDiaE9045p2Controller.text.toString(),
      electrodeEiaE8010p1Batch:
          electrodeEiaE8010p1BatchController.text.toString(),
      electrodeEiaE8010p1: electrodeEiaE8010p1Controller.text.toString(),
      leftPipeData: leftPipeData,
      rightPipeData: rightPipeData,
      wpsData: wpsData,
      jointTypeData: jointTypeData,
      jointNumberData: jointNumberData,
      fitupData: fitupData,
      weldVisualData: weldVisualData,
      file: file,
      userData: userData,
      weatherData: weatherData,
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
    );
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      electrodeDiaE81t8gBatchController.text = "";
      electrodeDiaE81t8gController.text = "";
      electrodeDiaE6010BatchController.text = "";
      electrodeDiaE6010Controller.text = "";
      electrodeDiaE9045p2BatchController.text = "";
      electrodeDiaE9045p2Controller.text = "";
      electrodeEiaE8010p1BatchController.text = "";
      electrodeEiaE8010p1Controller.text = "";
      leftPipeNumberController.text = "";
      rightPipeNumberController.text = "";
      _welderData = WelderModel();
      _jointNumberData = JointNumberModel();
      _alignmentData = AlignmentModel();
      _wpsData = WPSModel();
      _weldVisualData = VisualChecksModel();
      _fitupData = VisualChecksModel();
      _isLoader = false;
      _isWelderLoader = false;
      file = File("");
      _jointTypeData = JointTypeModel();
      rootWelders1Data = WelderModel();
      rootWelders2Data = WelderModel();
      hotWelders1Data = WelderModel();
      hotWelders2Data = WelderModel();
      filler1Welders1Data = WelderModel();
      filler1Welders2Data = WelderModel();
      filler2Welders1Data = WelderModel();
      filler2Welders2Data = WelderModel();
      filler3Welders1Data = WelderModel();
      filler3Welders2Data = WelderModel();
      filler4Welders1Data = WelderModel();
      filler4Welders2Data = WelderModel();
      filler5Welders1Data = WelderModel();
      filler5Welders2Data = WelderModel();
      filler6Welders1Data = WelderModel();
      filler6Welders2Data = WelderModel();
      filler7Welders1Data = WelderModel();
      filler7Welders2Data = WelderModel();
      filler8Welders1Data = WelderModel();
      filler8Welders2Data = WelderModel();
      cappingWelder1Data = WelderModel();
      cappingWelder2Data = WelderModel();
      stripWelder1Data = WelderModel();
      stripWelder2Data = WelderModel();
      chainageFromController.text = "";
      chainageToController.text = "";
      rightPipeData = PipeModel();
      leftPipeData = PipeModel();
      _weatherData = WeatherModel();
    }
    _eventComplete(emit);
  }

  _eventComplete(Emitter<AddWeldingState> emit) {
    emit(FetchAddWeldingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      reportNumberController: reportNumberController,
      activityRemarkController: activityRemarkController,
      alignmentData: alignmentData,
      file: file,
      welderData: welderData,
      welderList: welderList,
      wpsData: wpsData,
      wpsList: wpsList,
      jointNumberData: jointNumberData,
      jointNumberList: jointNumberList,
      rootWelders1List: rootWelders1List,
      rootWelders2List: rootWelders2List,
      hotWelders1List: hotWelders1List,
      hotWelders2List: hotWelders2List,
      filler1Welders1List: filler1Welders1List,
      filler1Welders2List: filler1Welders2List,
      filler2Welders1List: filler2Welders1List,
      filler2Welders2List: filler2Welders2List,
      filler3Welders1List: filler3Welders1List,
      filler3Welders2List: filler3Welders2List,
      filler4Welders1List: filler4Welders1List,
      filler4Welders2List: filler4Welders2List,
      filler5Welders1List: filler5Welders1List,
      filler5Welders2List: filler5Welders2List,
      filler6Welders1List: filler6Welders1List,
      filler6Welders2List: filler6Welders2List,
      filler7Welders1List: filler7Welders1List,
      filler7Welders2List: filler7Welders2List,
      filler8Welders1List: filler8Welders1List,
      filler8Welders2List: filler8Welders2List,
      cappingWelder1List: cappingWelder1List,
      cappingWelder2List: cappingWelder2List,
      fitupData: fitupData,
      fitupList: fitupList,
      stripWelder1List: stripWelder1List,
      stripWelder2List: stripWelder2List,
      weldVisualData: weldVisualData,
      weldVisualList: weldVisualList,
      electrodeDiaE81t8gBatchController: electrodeDiaE81t8gBatchController,
      electrodeDiaE81t8gController: electrodeDiaE81t8gController,
      electrodeDiaE6010BatchController: electrodeDiaE6010BatchController,
      electrodeDiaE6010Controller: electrodeDiaE6010Controller,
      electrodeDiaE9045p2BatchController: electrodeDiaE9045p2BatchController,
      electrodeDiaE9045p2Controller: electrodeDiaE9045p2Controller,
      electrodeEiaE8010p1BatchController: electrodeEiaE8010p1BatchController,
      electrodeEiaE8010p1Controller: electrodeEiaE8010p1Controller,
      isWelderLoader: isWelderLoader,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      leftPipeNumberController: leftPipeNumberController,
      rightPipeNumberController: rightPipeNumberController,
      rootWelders1Data: rootWelders1Data,
      rootWelders2Data: rootWelders2Data,
      hotWelders1Data: hotWelders1Data,
      hotWelders2Data: hotWelders2Data,
      filler1Welders1Data: filler1Welders1Data,
      filler1Welders2Data: filler1Welders2Data,
      filler2Welders1Data: filler2Welders1Data,
      filler2Welders2Data: filler2Welders2Data,
      filler3Welders1Data: filler3Welders1Data,
      filler3Welders2Data: filler3Welders2Data,
      filler4Welders1Data: filler4Welders1Data,
      filler4Welders2Data: filler4Welders2Data,
      filler5Welders1Data: filler5Welders1Data,
      filler5Welders2Data: filler5Welders2Data,
      filler6Welders1Data: filler6Welders1Data,
      filler6Welders2Data: filler6Welders2Data,
      filler7Welders1Data: filler7Welders1Data,
      filler7Welders2Data: filler7Welders2Data,
      filler8Welders1Data: filler8Welders1Data,
      filler8Welders2Data: filler8Welders2Data,
      cappingWelder1Data: cappingWelder1Data,
      cappingWelder2Data: cappingWelder2Data,
      stripWelder1Data: stripWelder1Data,
      stripWelder2Data: stripWelder2Data,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      leftPipeData: leftPipeData,
      rightPipeData: rightPipeData,
      leftPipeList: leftPipeList,
      rightPipeList: rightPipeList,
      searchLeftPipeController: searchLeftPipeController,
      searchLeftPipeList: searchLeftPipeList,
      searchLeftPipeLoader: searchLeftPipeLoader,
      searchPipeRightController: searchRightPipeController,
      searchRightPipeList: searchRightPipeList,
      searchRightPipeLoader: searchRightPipeLoader,
    ));
  }
}
