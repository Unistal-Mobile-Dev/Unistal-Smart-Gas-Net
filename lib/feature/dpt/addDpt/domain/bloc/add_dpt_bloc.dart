import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/model/crossing_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dpt/addDpt/domain/bloc/add_dpt_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dpt/addDpt/domain/bloc/add_dpt_state.dart';
import 'package:flutter_unistal_smart_gas_net/feature/dpt/addDpt/helper/add_dpt_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
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


class AddDptBloc extends Bloc<AddDptEvent, AddDptState> {

  TextEditingController dateController = TextEditingController();
  TextEditingController onBodyController = TextEditingController();
  TextEditingController onWeldController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController sectionLengthController = TextEditingController();
  TextEditingController casingPipeLengthController = TextEditingController();
  TextEditingController concreteCoatingLengthController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController holidayTestNoController = TextEditingController();
  TextEditingController crossingNameController = TextEditingController();
  TextEditingController electrometerNoController = TextEditingController();
  TextEditingController batchNoController = TextEditingController();
  TextEditingController surfaceController = TextEditingController();
  TextEditingController dptTestController = TextEditingController();
  TextEditingController searchPipeController =  TextEditingController();
  
  List<PipeModel> _pipeList = [];
  List<PipeModel> get pipeList => _pipeList;

  List<dynamic> _searchPipeList = [];
  List<dynamic> get searchPipeList => _searchPipeList;

  bool _searchPipeLoader =  false;
  bool get searchPipeLoader => _searchPipeLoader;

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

  List<ThicknessModel> thicknessList = [];
  ThicknessModel thicknessData =  ThicknessModel();

  List<PipeDiaModel> pipeDiaList = [];
  PipeDiaModel pipeDiaData =  PipeDiaModel();

  List<CoatingTypeModel> coatingTypeList = [];
  CoatingTypeModel coatingTypeData = CoatingTypeModel();

  List<PaddingModel> prePaddingList = [];
  PaddingModel prePaddingData =  PaddingModel();

  List<PaddingModel> postPaddingList = [];
  PaddingModel postPaddingData =  PaddingModel();

  List<PipeMaterialModel> pipeMaterialList = [];
  PipeMaterialModel pipeMaterialData =  PipeMaterialModel();

  List<VisualChecksModel> visualsChecksList = [];
  VisualChecksModel visualChecksData =  VisualChecksModel();

  List<CrossingTypeModel> DptTypeList = [];
  CrossingTypeModel DptTypeData =  CrossingTypeModel();

  PipeModel _pipeData =  PipeModel();
  PipeModel get pipeData => _pipeData;


  AddDptBloc() : super(AddDptInitial()) {
    on<AddDptPageLoadEvent>(_pageLoader);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddDptSelectAlignmentEvent>(_selectAlignment);
    on<AddDptSearchPipeDataEvent>(_searchPipeData);
    on<AddDptSelectPipeDataEvent>(_selectPipeData);
    on<AddDptSelectCoatingTypeDataEvent>(_selectCoatingType);
    on<AddDptSelectPipeMaterialDataEvent>(_selectPipeMaterial);
    on<AddDptSelectDptTypeDataEvent>(_selectDptType);
    on<AddDptSelectVisualChecksDataEvent>(_selectVisualCheck);
    on<AddDptSelectPrePaddingDataEvent>(_selectPrePadding);
    on<AddDptSelectPostPaddingDataEvent>(_selectPostPadding);
    on<AddDptSelectHolidayDataEvent>(_selectHolidayData);
    on<AddDptSelectFromJointDataEvent>(_selectJointFrom);
    on<AddDptSelectToJointDataEvent>(_selectJointTo);
    on<AddDptSelectJointTypeDataEvent>(_selectJointType);
    on<AddDptSelectDateEvent>(_selectDate);
    on<AddDptSelectPipeDiaDataEvent>(_selectPipeDia);
    on<AddDptSelectThicknessDataEvent>(_selectThickness);
    on<AddDptCalibarationDataEvent>(_selectCabilabrationData);
    on<AddDptAddImageEvent>(_selectFile);
    on<AddDptSubmitDataEvent>(_submitData);
  }

  _pageLoader(AddDptPageLoadEvent event, emit) async {
    emit(AddDptPageLoadState());
    dateController.text = "";
    onBodyController.text = "";
    onWeldController.text = "";
    activityRemarkController.text = "";
    sectionLengthController.text = "";
    casingPipeLengthController.text = "";
    concreteCoatingLengthController.text = "";
    locationController.text = "";
    holidayTestNoController.text = "";
    crossingNameController.text = "";
    electrometerNoController.text = "";
    batchNoController.text = "";
    surfaceController.text = "";
    dptTestController.text = "";
    holidayCheckList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    _pipeList = [];
    _pipeData =  PipeModel();
    _searchPipeLoader =  false;
    alignmentData =  AlignmentModel();
    DptTypeList = [];
    DptTypeData =  CrossingTypeModel();
    isLoader =  false;
    holidayChecksData = HolidayChecksModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData =  JointTypeModel();
    isJointNumberLoader = false;
    file =  File("");
    thicknessList = [];
    thicknessData =  ThicknessModel();
    pipeDiaData =  PipeDiaModel();
    pipeDiaList = [];
    prePaddingData =  PaddingModel();
    prePaddingList =  [];
    postPaddingList = [];
    postPaddingData =  PaddingModel();
    coatingTypeList = [];
    coatingTypeData =  CoatingTypeModel();
    weatherData =  WeatherModel();
    pipeMaterialList = [];
    pipeMaterialData =  PipeMaterialModel();
    visualsChecksList = [];
    visualChecksData = VisualChecksModel();
    DptTypeList = [];
    DptTypeData =  CrossingTypeModel();
    _userData =  UserInfo.instanceInit()!.userData!;
    weatherList =  await DashboardHelper.fetchWeatherData(context: event.context, userData: userData);

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


    var visualsChecksRes =  await AddBendingHelper.fetchVisualChecks(context: event.context);
    if(visualsChecksRes != null){
      visualsChecksList =  visualsChecksRes;
    }


    var prePaddingRes =  await AddHDPEDuctHelper.fetchPaddingData(context: event.context);
    if(prePaddingRes != null){
      prePaddingList =  prePaddingRes;
      postPaddingList = prePaddingRes;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddDptSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }
  _searchPipeData(AddDptSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader =  true;
    _eventComplete(emit);
    var resPipe =  await AddStringingHelper.fetchPipeData(context: event.context,
        userData: userData, searchKeyword: event.keyword.toString(), type: "Dpt");
    if(resPipe != null){
      _pipeList =  resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader =  false;
    _eventComplete(emit);
  }

  _selectPipeData(AddDptSelectPipeDataEvent event, emit) {
    _searchPipeList = [];
    _pipeData =  event.pipeData;
    searchPipeController.text = "${event.pipeData.pipeNumber.toString()}|${event.pipeData.heatNumber.toString()}|${event.pipeData.pipeLength.toString()}";
    _eventComplete(emit);
  }

  _selectCoatingType(AddDptSelectCoatingTypeDataEvent event, emit) {
    coatingTypeData =  event.coatingTypeData;
    _eventComplete(emit);
  }

  _selectPipeMaterial(AddDptSelectPipeMaterialDataEvent event, emit) {
    pipeMaterialData =  event.pipeMaterialData;
    _eventComplete(emit);
  }

  _selectDptType(AddDptSelectDptTypeDataEvent event, emit) {
    DptTypeData =  event.DptTypeData;
    _eventComplete(emit);
  }

  _selectVisualCheck(AddDptSelectVisualChecksDataEvent event, emit) {
    visualChecksData =  event.visualChecksData;
    _eventComplete(emit);
  }

  _selectPrePadding(AddDptSelectPrePaddingDataEvent event, emit) {
    prePaddingData =  event.prePaddingData;
    _eventComplete(emit);
  }

  _selectPostPadding(AddDptSelectPostPaddingDataEvent event, emit) {
    postPaddingData =  event.postPaddingData;
    _eventComplete(emit);
  }

  _selectHolidayData(AddDptSelectHolidayDataEvent event, emit) {
    holidayChecksData = event.holidayChecksData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddDptSelectFromJointDataEvent event, emit) {
    fromJointData =  event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddDptSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddDptSelectJointTypeDataEvent event, emit) async {
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

  _selectDate(AddDptSelectDateEvent event, emit) async {
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

  _selectPipeDia(AddDptSelectPipeDiaDataEvent event, emit) {
    pipeDiaData =  event.pipeDiaData;
    _eventComplete(emit);
  }

  _selectThickness(AddDptSelectThicknessDataEvent event, emit) {
    thicknessData =  event.thicknessData;
    _eventComplete(emit);
  }

  _selectCabilabrationData(AddDptCalibarationDataEvent event, emit) async {
    DateTime firstDayCurrentMonth = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day+1);
    DateTime? pickedDate = await showDatePicker(context: event.context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      onBodyController.text =  formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      print("Date is not selected");
    }
  }


  _selectFile(AddDptAddImageEvent event, emit) async {
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

  _submitData(AddDptSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddDptHelper.submitData(context: event.context,
      alignmentData: alignmentData,
      onWeld: onWeldController.text.toString(),
      date: dateController.text.toString(),
      holidayChecksData: holidayChecksData,
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      fromJointData: fromJointData,
      toJointData: toJointData,
      jointTypeData: jointTypeData,
      sectionLength: sectionLengthController.text.toString(),
      casingPipeLength: casingPipeLengthController.text.toString(),
      batchNo: batchNoController.text.toString(),
      file: file,
      onBody: onBodyController.text.toString(),
      holidayTestNo: holidayTestNoController.text.toString(),
      locationName: locationController.text.toString(),
      concreteCoatingLength: concreteCoatingLengthController.text.toString(),
      electrometerNo: electrometerNoController.text.toString(),
      surface: surfaceController.text.toString(),
      crossingName: crossingNameController.text.toString(),
      pipeDiaData: pipeDiaData,
      thicknessData: thicknessData,
      visualChecksData: visualChecksData,
      coatingTypeData: coatingTypeData,
      pipeMaterialData: pipeMaterialData,
      prePaddingData: prePaddingData,
      postPaddingData: postPaddingData,
      crossingTypeData: DptTypeData,
      dptTest: dptTestController.text.toString(),
      pipeData: pipeData,
    );
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      onWeldController.text = "";
      activityRemarkController.text = "";
      sectionLengthController.text = "";
      casingPipeLengthController.text = "";
      batchNoController.text = "";
      alignmentData =  AlignmentModel();
      isLoader =  false;
      holidayChecksData = HolidayChecksModel();
      crossingNameController.text = "";
      locationController.text = "";
      holidayTestNoController.text = "";
      electrometerNoController.text = "";
      onBodyController.text = "";
      surfaceController.text = "";
      concreteCoatingLengthController.text = "";
      dptTestController.text = "";
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData =  JointTypeModel();
      isJointNumberLoader = false;
      file =  File("");
      weatherData =  WeatherModel();
      thicknessData =  ThicknessModel();
      pipeDiaData =  PipeDiaModel();
      prePaddingData =  PaddingModel();
      coatingTypeData =  CoatingTypeModel();
      pipeMaterialData =  PipeMaterialModel();
      visualChecksData =  VisualChecksModel();
      DptTypeData =  CrossingTypeModel();
      PaddingModel();
      _eventComplete(emit);
    }
  }


  _eventComplete(Emitter<AddDptState>emit) {
    emit(FetchAddDptDataState(isLoader: isLoader,
        alignmentList: alignmentList,
        dateController: dateController,
        activityRemarkController: activityRemarkController,
        onWeldController: onWeldController,
        sectionLengthController: sectionLengthController,
        casingPipeLengthController: casingPipeLengthController,
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
        concreteCoatingLengthController: concreteCoatingLengthController,
        locationController: locationController,
        toJointData: toJointData,
        holidayTestNoController: holidayTestNoController,
        holidayChecksData: holidayChecksData,
        onBodyController: onBodyController,
        holidayCheckList: holidayCheckList,
        electrometerNoController: electrometerNoController,
        crossingNameController: crossingNameController,
        batchNoController: batchNoController,
        surfaceController: surfaceController,
        pipeDiaData: pipeDiaData,
        pipeDialList: pipeDiaList,
        thicknessData: thicknessData,
        thicknessList: thicknessList,
        prePaddingData: prePaddingData,
        prePaddingList: prePaddingList,
        coatingTypeData: coatingTypeData,
        coatingTypeList: coatingTypeList,
        pipeMaterialData: pipeMaterialData,
        pipeMaterialList: pipeMaterialList,
        visualChecksData: visualChecksData,
        visualsChecksList: visualsChecksList,
        DptTypeData: DptTypeData,
        DptTyeList: DptTypeList,
        postPaddingData: postPaddingData,
        postPaddingList: postPaddingList,
        dptTestController: dptTestController,
        pipeList: pipeList,
        searchPipeController: searchPipeController,
        searchPipeList: searchPipeList,
        searchPipeLoader: searchPipeLoader
    ));
  }

}