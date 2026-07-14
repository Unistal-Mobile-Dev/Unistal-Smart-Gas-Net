import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/helper/add_concrete_coating_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/domain/model/lpt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lpt/addLpt/helper/add_lpt_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_lpt_event.dart';

part 'add_lpt_state.dart';

class AddLptBloc extends Bloc<AddLptEvent, AddLptState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController observationResultsController = TextEditingController();
  TextEditingController searchPipeController = TextEditingController();
  TextEditingController penetrantManufacturerController = TextEditingController();
  TextEditingController penetrantBatchNoController = TextEditingController();
  TextEditingController cleanerManufacturerController = TextEditingController();
  TextEditingController cleanerBatchNoController = TextEditingController();
  TextEditingController developerManufacturerController = TextEditingController();
  TextEditingController developerBatchNoController = TextEditingController();
  TextEditingController surfaceTemperatureController = TextEditingController();
  TextEditingController penetrantDwellTimeController = TextEditingController();
  TextEditingController developerTimeController = TextEditingController();
  TextEditingController acceptanceCriteriaController = TextEditingController();
  TextEditingController materialTypeController = TextEditingController();
  TextEditingController applicationMethodController = TextEditingController();
  TextEditingController sketchController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController sizeController = TextEditingController();

  List<ThicknessModel> pipeThicknessList = [];
  ThicknessModel pipeThicknessData = ThicknessModel();

  List<JointNumberModel> jointList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData = [];

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

  List<TerrainTypeModel> listOfMEIL = [];
  List<TerrainTypeModel> listOfCEIL = [];
  List<TerrainTypeModel> listOfMECON = [];
  TerrainTypeModel dataMEIL = TerrainTypeModel();
  TerrainTypeModel dataCEIL = TerrainTypeModel();
  TerrainTypeModel dataMECON = TerrainTypeModel();

  AddLptBloc() : super(AddLptInitial()) {
    on<AddLptPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddLptSelectAlignmentEvent>(_selectAlignment);
    on<AddLptMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddLptSelectJointDataEvent>(_selectJointTo);
    on<AddLptSelectJointTypeDataEvent>(_selectJointType);
    on<AddLptSelectLptStatusDataEvent>(_selectLptStatus);
    on<AddLptSelectDateEvent>(_selectDate);
    on<AddLptSearchPipeDataEvent>(_searchPipeNumber);
    on<AddLptSelectPipeDataEvent>(_selectPipe);
    on<AddLptSelectPipeThicknessEvent>(_selectPipeThickness);
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
    penetrantManufacturerController.text = "";
    penetrantBatchNoController.text = "";
    cleanerManufacturerController.text = "";
    cleanerBatchNoController.text = "";
    developerManufacturerController.text = "";
    developerBatchNoController.text = "";
    surfaceTemperatureController.text = "";
    penetrantDwellTimeController.text = "";
    developerTimeController.text = "";
    acceptanceCriteriaController.text = "";
    materialTypeController.text = "";
    applicationMethodController.text = "";
    sketchController.text = "";
    typeController.text = "";
    sizeController.text = "";
    _searchPipeLoader = false;
    jointList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    _pipeList = [];
    _searchPipeList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    isLoader = false;
    jointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    weatherData = WeatherModel();
    lptStatusData = LptStatusModel();
    _pipeData = PipeModel();
    lptStatusList = [];
    listOfMEIL = [];
    listOfCEIL = [];
    listOfMECON = [];
    dataMEIL = TerrainTypeModel();
    dataCEIL = TerrainTypeModel();
    dataMECON = TerrainTypeModel();
    pipeThicknessData = ThicknessModel();
    _userData = UserInfo.instanceInit()!.userData!;
    var thicknessRes = await AddConcreteCoatingHelper.fetchThicknessData();
    if (thicknessRes != null) {
      pipeThicknessList = thicknessRes;
    }
    weatherList = await DashboardHelper.fetchWeatherData();

    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }
    var segmentStatusRes =  await DashboardHelper.fetchConstantData(key: "SegmentStatus");
    if (segmentStatusRes.isNotEmpty) {
      listOfMEIL = segmentStatusRes;
      listOfCEIL = segmentStatusRes;
      listOfMECON = segmentStatusRes;
    }
    var resJointNumber = await DashboardHelper.fetchJointNumberData(
        type: AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
            ? AppConfig.instanceInit()!.activitySectionData.appJoint!
            : "afterndtrt");
    if (resJointNumber != null) {
      jointList = resJointNumber;
    }

    var resLpt = await DashboardHelper.fetchLptData();
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

  _selectMultipleAlignment(AddLptMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
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

    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectLptStatus(AddLptSelectLptStatusDataEvent event, emit) {
    lptStatusData = event.lptStatusData;
    _eventComplete(emit);
  }

  _selectPipeThickness(AddLptSelectPipeThicknessEvent event, emit) {
    pipeThicknessData = event.pipeThicknessData;
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
      multipleAlignmentData: multipleAlignmentData,
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
      file: file,
      penetrantManufacturer: penetrantManufacturerController.text.toString(),
      penetrantBatchNo: penetrantBatchNoController.text.toString(),
      cleanerManufacturer: cleanerManufacturerController.text.toString(),
      cleanerBatchNo: cleanerBatchNoController.text.toString(),
      developerManufacturer: developerManufacturerController.text.toString(),
      developerBatchNo: developerBatchNoController.text.toString(),
      surfaceTemperature: surfaceTemperatureController.text.toString(),
      penetrantDwellTime: penetrantDwellTimeController.text.toString(),
      developerTime: developerTimeController.text.toString(),
      acceptanceCriteria: acceptanceCriteriaController.text.toString(),
      materialType: materialTypeController.text.toString(),
      applicationMethod: applicationMethodController.text.toString(),
      size: sizeController.text.toString(),
      sketch: sketchController.text.toString(),
      type: typeController.text.toString(),
      pipeThicknessData: pipeThicknessData,
      ceil: dataCEIL,
      mecon: dataMECON,
      meil: dataMEIL,
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      observationResultsController.text = "";
      penetrantManufacturerController.text = "";
      penetrantBatchNoController.text = "";
      cleanerManufacturerController.text = "";
      cleanerBatchNoController.text = "";
      developerManufacturerController.text = "";
      developerBatchNoController.text = "";
      surfaceTemperatureController.text = "";
      penetrantDwellTimeController.text = "";
      developerTimeController.text = "";
      acceptanceCriteriaController.text = "";
      materialTypeController.text = "";
      applicationMethodController.text = "";
      sketchController.text = "";
      typeController.text = "";
      sizeController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      jointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      lptStatusData = LptStatusModel();
      pipeThicknessData = ThicknessModel();
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
      multipleAlignmentData: multipleAlignmentData,
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
      penetrantManufacturerController: penetrantManufacturerController,
      penetrantBatchNoController: penetrantBatchNoController,
      cleanerManufacturerController: cleanerManufacturerController,
      cleanerBatchNoController: cleanerBatchNoController,
      developerManufacturerController: developerManufacturerController,
      developerBatchNoController: developerBatchNoController,
      surfaceTemperatureController: surfaceTemperatureController,
      penetrantDwellTimeController: penetrantDwellTimeController,
      developerTimeController: developerTimeController,
      acceptanceCriteriaController: acceptanceCriteriaController,
      materialTypeController: materialTypeController,
      applicationMethodController: applicationMethodController,
      sizeController: sizeController,
      sketchController: sketchController,
      typeController: typeController,
      pipeThicknessList: pipeThicknessList,
      pipeThicknessData: pipeThicknessData,
      dataCEIL: dataCEIL,
      dataMECON: dataMECON,
      dataMEIL: dataMEIL,
      listOfCEIL: listOfCEIL,
      listOfMECON: listOfMECON,
      listOfMEIL: listOfMEIL,
    ));
  }
}
