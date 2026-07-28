import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
import 'package:flutter_unistal_smart_gas_net/feature/tieIn/addTiein/helper/add_tiein_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/electrode_batch_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/electrode_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_tiein_event.dart';

part 'add_tiein_state.dart';

class AddTieinBloc extends Bloc<AddTieinEvent, AddTieinState> {
  TextEditingController preheatTempController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController internalCleaningPipeController = TextEditingController();
  TextEditingController pigPassController = TextEditingController();
  TextEditingController thicknessCheckController = TextEditingController();

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

  TextEditingController electrodeDiaE81t8gBatchController = TextEditingController();
  TextEditingController electrodeDiaE81t8gController = TextEditingController();

  TextEditingController leftPipeNumberController = TextEditingController();
  TextEditingController rightPipeNumberController = TextEditingController();

  List<VisualChecksModel> fitupList = [];
  VisualChecksModel fitupData = VisualChecksModel();

  List<VisualChecksModel> weldVisualList = [];
  VisualChecksModel weldVisualData = VisualChecksModel();

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData = [];

  List<WPSModel> wpsList = [];
  WPSModel wpsData = WPSModel();

  List<WelderModel> welderList = [];
  WelderModel welderData = WelderModel();

  List<JointNumberModel> jointNumberList = [];
  JointNumberModel jointNumberData = JointNumberModel();

  bool isLoader = false;
  bool isWelderLoader = false;

  File file = File("");

  LoginDataModel userData = LoginDataModel();

  List<JointTypeModel> jointTypeList = [];
  JointTypeModel jointTypeData = JointTypeModel();

  bool _isJointNumberLoader = false;

  bool get isJointNumberLoader => _isJointNumberLoader;

  bool isLoaderDiaE6010BatchBatch = false;
  bool isLoaderEiaE8010p1BatchBatch = false;
  bool isLoaderDiaE9045p2Batch = false;

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController chainageController = TextEditingController();

  List<PipeModel> leftPipeList = [];
  List<PipeModel> rightPipeList = [];

  PipeModel leftPipeData = PipeModel();
  PipeModel rightPipeData = PipeModel();

  ElectrodeDiaData electrodeDiaE6010Value = ElectrodeDiaData();
  ElectrodeBatchData electrodeDiaE6010BatchValue = ElectrodeBatchData();
  ElectrodeDiaData electrodeEiaE8010p1Value = ElectrodeDiaData();
  ElectrodeBatchData electrodeEiaE8010p1BatchValue = ElectrodeBatchData();
  ElectrodeDiaData electrodeDiaE9045p2Value = ElectrodeDiaData();
  ElectrodeBatchData electrodeDiaE9045p2BatchValue = ElectrodeBatchData();

  TextEditingController searchLeftPipeController = TextEditingController();
  TextEditingController searchRightPipeController = TextEditingController();

  bool searchLeftPipeLoader = false;
  bool searchRightPipeLoader = false;

  List<dynamic> searchRightPipeList = [];
  List<dynamic> searchLeftPipeList = [];

  List<ElectrodeDiaData> electrodeDiaE6010DiaList = [];
  List<ElectrodeBatchData> electrodeDiaE6010BatchList = [];
  List<ElectrodeDiaData> electrodeEiaE8010p1DiaList = [];
  List<ElectrodeBatchData> electrodeEiaE8010p1BatchList = [];
  List<ElectrodeDiaData> electrodeDiaE9045p2List = [];
  List<ElectrodeBatchData> electrodeDiaE9045p2BatchList = [];

  AddTieinBloc() : super(AddTieinInitial()) {
    on<AddTieinPageLoadEvent>(_pageLoadEvent);
    on<AddTieinSelectWPSEvent>(_selectWPS);
    on<AddTieinSearchPipeDataEvent>(_searchPipeData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddTieinSelectLeftPipeDataEvent>(_selectLeftPipe);
    on<AddTieinSelectRightPipeDataEvent>(_selectRigthPipe);
    on<AddTieinSelectMultiWelderEvent>(_selectMultiWelder);
    on<AddTieinSelectWelderEvent>(_selectWelder);
    on<AddTieinSelectAlignmentEvent>(_selectAlignment);
    on<AddTieinMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddTieinSelectDateEvent>(_selectDate);
    on<AddTieinSelectJointTypeEvent>(_selectJointType);
    on<AddTieinSelectJointNumberEvent>(_selectJointNumber);
    on<AddTieinSelectFitupDataEvent>(_selectFitUp);
    on<AddTieinSelectWeldVisualEvent>(_selectWeldVisual);
    on<AddTieinAddImageEvent>(_selectFile);
    on<SelectElectrodeDiaE6010Event>(_selectElectrodeDiaE6010);
    on<SelectElectrodeEiaE7010p1Event>(_selectElectrodeEiaE8010p1);
    on<SelectElectrodeDiaE6010BatchEvent>(_selectElectrodeDiaE6010Batch);
    on<SelectElectrodeEiaE7010p1BatchEvent>(_selectElectrodeEiaE8010p1Batch);
    on<SelectElectrodeDiaE9045p2Event>(_selectElectrodeDiaE9045p2);
    on<SelectElectrodeDiaE9045p2BatchEvent>(_selectElectrodeDiaE9045p2Batch);
    on<AddTieinSubmitDataEvent>(_submit);
  }

  _pageLoadEvent(AddTieinPageLoadEvent event, emit) async {
    emit(AddTieinPageLoadState());
    dateController.text = "";
    preheatTempController.text = "";
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

    leftPipeNumberController.text = "";
    rightPipeNumberController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    chainageController.text = "";
    searchLeftPipeController.text = "";
    searchRightPipeController.text = "";
     internalCleaningPipeController = TextEditingController();
     pigPassController = TextEditingController();
     thicknessCheckController = TextEditingController();
    searchRightPipeLoader = false;
    searchLeftPipeLoader = false;

    welderData = WelderModel();
    welderList = [];
    jointNumberData = JointNumberModel();
    jointNumberList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    alignmentList = [];
    wpsData = WPSModel();
    wpsList = [];
    weldVisualData = VisualChecksModel();
    weldVisualList = [];
    fitupData = VisualChecksModel();
    fitupList = [];
    isLoader = false;
    isWelderLoader = false;
    file = File("");
    jointTypeData = JointTypeModel();
    jointTypeList = [];
    _weatherData = WeatherModel();
    isLoaderDiaE6010BatchBatch = false;
    isLoaderEiaE8010p1BatchBatch = false;
    electrodeDiaE6010Value = ElectrodeDiaData();
    electrodeDiaE6010BatchValue = ElectrodeBatchData();
    electrodeEiaE8010p1Value = ElectrodeDiaData();
    electrodeEiaE8010p1BatchValue = ElectrodeBatchData();
    electrodeDiaE9045p2Value = ElectrodeDiaData();
    electrodeDiaE9045p2BatchValue = ElectrodeBatchData();

    electrodeDiaE6010DiaList = [];
    electrodeDiaE6010BatchList = [];
    electrodeEiaE8010p1DiaList = [];
    electrodeEiaE8010p1BatchList = [];
    electrodeDiaE9045p2List = [];
    electrodeDiaE9045p2BatchList = [];

    userData = UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData();
    _isJointNumberLoader = false;
    leftPipeList = [];
    rightPipeList = [];

    leftPipeData = PipeModel();
    rightPipeData = PipeModel();
    var resElectrodeDia = await DashboardHelper.fetchElectrodeDia();
    if (resElectrodeDia != null) {
      electrodeDiaE6010DiaList = resElectrodeDia;
      electrodeEiaE8010p1DiaList = resElectrodeDia;
    }
    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }

    var resWPS = await DashboardHelper.fetchWPSType();
    if (resWPS != null) {
      wpsList = resWPS;
    }

    var resJointNumber = await DashboardHelper.fetchJointNumberData(
      type: AppConfig.instanceInit()!
                  .activitySectionData
                  .appJoint
                  ?.trim()
                  .isNotEmpty ==
              true
          ? AppConfig.instanceInit()!.activitySectionData.appJoint!
          : "welding",
    );
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }
    var resVisual = await AddBendingHelper.fetchVisualChecks();
    if (resVisual != null) {
      fitupList = resVisual;
    }
    weldVisualList = fitupList;
    _eventComplete(emit);
  }

  _searchPipeData(AddTieinSearchPipeDataEvent event, emit) async {
    if (event.isLeftPipe == true) {
      leftPipeList = [];
      searchLeftPipeLoader = true;
      _eventComplete(emit);
      var resPipe = await AddStringingHelper.fetchPipeData(
          context: event.context,
          userData: userData,
          searchKeyword: event.keyword.toString(),
          type: "welding");
      if (resPipe != null) {
        leftPipeList = resPipe;
        searchLeftPipeList = leftPipeList;
      }
      searchLeftPipeLoader = false;
      _eventComplete(emit);
    } else if (event.isRightPipe == true) {
      rightPipeList = [];
      searchRightPipeLoader = true;
      _eventComplete(emit);
      var resPipe = await AddStringingHelper.fetchPipeData(
          context: event.context,
          userData: userData,
          searchKeyword: event.keyword.toString(),
          type: "welding");
      if (resPipe != null) {
        rightPipeList = resPipe;
        searchRightPipeList = rightPipeList;
      }
      searchRightPipeLoader = false;
      _eventComplete(emit);
    }
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectLeftPipe(AddTieinSelectLeftPipeDataEvent event, emit) {
    leftPipeData = event.leftPipeData;
    searchLeftPipeList = [];
    searchLeftPipeController.text = leftPipeData.pipeNumber.toString();
    _eventComplete(emit);
  }

  _selectRigthPipe(AddTieinSelectRightPipeDataEvent event, emit) {
    rightPipeData = event.rightPipeData;
    searchRightPipeList = [];
    searchRightPipeController.text = rightPipeData.pipeNumber.toString();
    _eventComplete(emit);
  }

  _selectWPS(AddTieinSelectWPSEvent event, emit) async {
    wpsData = event.wpsData;
    welderList = [];
    welderData = WelderModel();
    isWelderLoader = true;
    _eventComplete(emit);
    var resWelder = await DashboardHelper.fetchWelderData(wpsData: wpsData);
    if (resWelder != null) {
      welderList = resWelder;
    }
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

    isWelderLoader = false;
    _eventComplete(emit);
  }

  _selectMultiWelder(AddTieinSelectMultiWelderEvent event, emit) {
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

  _selectWelder(AddTieinSelectWelderEvent event, emit) {
    welderData = event.welderData;
    _eventComplete(emit);
  }

  _selectAlignment(AddTieinSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddTieinMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddTieinSelectDateEvent event, emit) async {
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

  _selectJointType(AddTieinSelectJointTypeEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    _isJointNumberLoader = true;
    _eventComplete(emit);

    _isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectJointNumber(AddTieinSelectJointNumberEvent event, emit) async {
    jointNumberData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectFitUp(AddTieinSelectFitupDataEvent event, emit) {
    fitupData = event.fitupData;
    _eventComplete(emit);
  }

  _selectWeldVisual(AddTieinSelectWeldVisualEvent event, emit) {
    weldVisualData = event.weldVisualData;
    _eventComplete(emit);
  }

  _selectFile(AddTieinAddImageEvent event, emit) async {
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

  _selectElectrodeDiaE6010(SelectElectrodeDiaE6010Event event, emit) async {
    electrodeDiaE6010BatchList = [];
    electrodeDiaE6010BatchValue = ElectrodeBatchData();
    electrodeDiaE6010Value = event.electrodeDiaE6010Value;
    if (electrodeDiaE6010Value.diaValue != null) {
      isLoaderDiaE6010BatchBatch = true;
      _eventComplete(emit);
      var resElectrodeDia = await DashboardHelper.fetchElectrodeBatch(
          diaValue: electrodeDiaE6010Value.diaValue.toString());
      if (resElectrodeDia != null) {
        electrodeDiaE6010BatchList = resElectrodeDia;
      }
    }
    isLoaderDiaE6010BatchBatch = false;
    _eventComplete(emit);
  }

  _selectElectrodeEiaE8010p1(SelectElectrodeEiaE7010p1Event event, emit) async {
    electrodeEiaE8010p1BatchList = [];
    electrodeEiaE8010p1BatchValue = ElectrodeBatchData();
    electrodeEiaE8010p1Value = event.electrodeEiaE8010p1Value;
    if (electrodeDiaE6010Value.diaValue != null) {
      isLoaderEiaE8010p1BatchBatch = true;
      _eventComplete(emit);
      var resElectrodeDia = await DashboardHelper.fetchElectrodeBatch(diaValue: electrodeEiaE8010p1Value.diaValue.toString());
      if (resElectrodeDia != null) {
        electrodeEiaE8010p1BatchList = resElectrodeDia;
      }
    }
    isLoaderEiaE8010p1BatchBatch = false;
    _eventComplete(emit);
  }

  _selectElectrodeDiaE9045p2(SelectElectrodeDiaE9045p2Event event, emit) async {
    electrodeDiaE9045p2BatchList = [];
    electrodeDiaE9045p2BatchValue = ElectrodeBatchData();
    electrodeDiaE9045p2Value = event.electrodeDiaE9045p2Value;
    if (electrodeDiaE9045p2Value.diaValue != null) {
      isLoaderDiaE9045p2Batch = true;
      _eventComplete(emit);
      var resElectrodeDia = await DashboardHelper.fetchElectrodeBatch(diaValue: electrodeDiaE9045p2Value.diaValue.toString());
      if (resElectrodeDia != null) {
        electrodeDiaE9045p2BatchList = resElectrodeDia;
      }
    }
    isLoaderDiaE9045p2Batch = false;
    _eventComplete(emit);
  }

  _selectElectrodeDiaE6010Batch(SelectElectrodeDiaE6010BatchEvent event, emit) {
    electrodeDiaE6010BatchValue = event.electrodeDiaE6010BatchValue;
    _eventComplete(emit);
  }

  _selectElectrodeEiaE8010p1Batch(
      SelectElectrodeEiaE7010p1BatchEvent event, emit) {
    electrodeEiaE8010p1BatchValue = event.electrodeEiaE8010p1BatchValue;
    _eventComplete(emit);
  }

  _selectElectrodeDiaE9045p2Batch(
      SelectElectrodeDiaE9045p2BatchEvent event, emit) {
    electrodeDiaE9045p2BatchValue = event.electrodeDiaE9045p2BatchValue;
    _eventComplete(emit);
  }

  _submit(AddTieinSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddTieinHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      preHeatTempreture: preheatTempController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      welderData: welderData,
      electrodeDiaE81t8gBatch:
          electrodeDiaE81t8gBatchController.text.toString(),
      electrodeDiaE81t8g: electrodeDiaE81t8gController.text.toString(),
      electrodeDiaE6010Batch: electrodeDiaE6010BatchValue.batchNo == null
          ? ""
          : electrodeDiaE6010BatchValue.batchNo.toString(),
      electrodeDiaE6010: electrodeDiaE6010Value.diaValue == null
          ? ""
          : electrodeDiaE6010Value.diaValue.toString(),
      electrodeDiaE9045p2Batch: electrodeDiaE9045p2BatchValue.batchNo == null
          ? ""
          : electrodeDiaE9045p2BatchValue.batchNo.toString(),
      electrodeDiaE9045p2: electrodeDiaE9045p2Value.diaValue == null
          ? ""
          : electrodeDiaE9045p2Value.diaValue.toString(),
      electrodeEiaE7010p1Batch: electrodeEiaE8010p1BatchValue.batchNo == null
          ? ""
          : electrodeEiaE8010p1BatchValue.batchNo.toString(),
      electrodeEiaE7010p1: electrodeEiaE8010p1Value.diaValue == null
          ? ""
          : electrodeEiaE8010p1Value.diaValue.toString(),
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
      chainage: chainageController.text.toString(),
      reportNumber: reportNumberController.text.toString(),
      internalCleaningPipe: internalCleaningPipeController.text.toString(),
      pigPass: pigPassController.text.toString(),
      thicknessCheck: thicknessCheckController.text.toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      preheatTempController.text = "";
      activityRemarkController.text = "";
      electrodeDiaE81t8gBatchController.text = "";
      electrodeDiaE81t8gController.text = "";

      leftPipeNumberController.text = "";
      rightPipeNumberController.text = "";
      welderData = WelderModel();
      jointNumberData = JointNumberModel();
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      wpsData = WPSModel();
      weldVisualData = VisualChecksModel();
      fitupData = VisualChecksModel();
      isLoader = false;
      isWelderLoader = false;
      file = File("");
      jointTypeData = JointTypeModel();
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
      chainageController.text = "";
      rightPipeData = PipeModel();
      leftPipeData = PipeModel();
      _weatherData = WeatherModel();
      searchLeftPipeController.text = "";
      searchRightPipeController.text = "";
      reportNumberController.text = "";
       internalCleaningPipeController = TextEditingController();
       pigPassController = TextEditingController();
       thicknessCheckController = TextEditingController();
      electrodeDiaE6010Value = ElectrodeDiaData();
      electrodeDiaE6010BatchValue = ElectrodeBatchData();
      electrodeEiaE8010p1Value = ElectrodeDiaData();
      electrodeEiaE8010p1BatchValue = ElectrodeBatchData();
      electrodeDiaE9045p2Value = ElectrodeDiaData();
      electrodeDiaE9045p2BatchValue = ElectrodeBatchData();
    }
    _eventComplete(emit);
  }

  _eventComplete(Emitter<AddTieinState> emit) {
    emit(FetchAddTieinDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      preheatTempController: preheatTempController,
      activityRemarkController: activityRemarkController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
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
      chainageController: chainageController,
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
      reportNumberController: reportNumberController,
      electrodeDiaE6010BatchList: electrodeDiaE6010BatchList,
      electrodeDiaE6010BatchValue: electrodeDiaE6010BatchValue,
      electrodeDiaE6010DiaList: electrodeDiaE6010DiaList,
      electrodeDiaE6010Value: electrodeDiaE6010Value,
      electrodeEiaE8010p1BatchList: electrodeEiaE8010p1BatchList,
      electrodeEiaE8010p1BatchValue: electrodeEiaE8010p1BatchValue,
      electrodeEiaE8010p1DiaList: electrodeEiaE8010p1DiaList,
      electrodeEiaE8010p1Value: electrodeEiaE8010p1Value,
      isLoaderDiaE6010BatchBatch: isLoaderDiaE6010BatchBatch,
      isLoaderEiaE8010p1BatchBatch: isLoaderEiaE8010p1BatchBatch,
      isLoaderDiaE9045p2Batch: isLoaderDiaE9045p2Batch,
      electrodeDiaE9045p2BatchList: electrodeDiaE9045p2BatchList,
      electrodeDiaE9045p2BatchValue: electrodeDiaE9045p2BatchValue,
      electrodeDiaE9045p2List: electrodeDiaE9045p2List,
      electrodeDiaE9045p2Value: electrodeDiaE9045p2Value,
      thicknessCheckController: thicknessCheckController,
      pigPassController: pigPassController,
      internalCleaningPipeController: internalCleaningPipeController,
    ));
  }
}
