import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/helper/add_concrete_coating_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/helper/add_joint_coating_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/helper/add_lowering_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/marker/addMarker/domain/model/marker_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/marker/addMarker/helper/add_marker_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_marker_event.dart';
part 'add_marker_state.dart';

class AddMarkerBloc extends Bloc<AddMarkerEvent, AddMarkerState> {

  TextEditingController dateController = TextEditingController();
  TextEditingController onBodyController = TextEditingController();
  TextEditingController onWeldController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController primaryAbatchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController holidayTestNoController = TextEditingController();
  TextEditingController primaryBbatchController = TextEditingController();
  TextEditingController surfacePreparationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController surfaceController = TextEditingController();

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
  ThicknessModel coatingThicknessData =  ThicknessModel();

  List<PipeDiaModel> pipeDiaList = [];
  PipeDiaModel pipeDiaData =  PipeDiaModel();

  List<CoatingTypeModel> coatingTypeList = [];
  CoatingTypeModel coatingTypeData = CoatingTypeModel();

  List<PaddingModel> peelTestList = [];
  PaddingModel peelTestData =  PaddingModel();

  List<PipeMaterialModel> pipeMaterialList = [];
  PipeMaterialModel pipeMaterialData =  PipeMaterialModel();

  List<VisualChecksModel> visualsChecksList = [];
  VisualChecksModel visualChecksData =  VisualChecksModel();

  List<MarkerTypeModel> markerTypeList = [];
  MarkerTypeModel markerTypeData =  MarkerTypeModel();

  AddMarkerBloc() : super(AddMarkerInitial()) {
    on<AddMarkerPageLoadEvent>(_pageLoader);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddMarkerSelectAlignmentEvent>(_selectAlignment);
    on<AddMarkerSelectCoatingTypeDataEvent>(_selectCoatingType);
    on<AddMarkerSelectPipeMaterialDataEvent>(_selectPipeMaterial);
    on<AddMarkerSelectVisualChecksDataEvent>(_selectVisualCheck);
    on<AddMarkerSelectPeelTestDataEvent>(_selectPeelTest);
    on<AddMarkerSelectHolidayDataEvent>(_selectHolidayData);
    on<AddMarkerSelectFromJointDataEvent>(_selectJointFrom);
    on<AddMarkerSelectToJointDataEvent>(_selectJointTo);
    on<AddMarkerSelectJointTypeDataEvent>(_selectJointType);
    on<AddMarkerSelectDateEvent>(_selectDate);
    on<AddMarkerSelectPipeDiaDataEvent>(_selectPipeDia);
    on<AddMarkerSelectThicknessDataEvent>(_selectThickness);
    on<AddMarkerSelectPipeThicknessDataEvent>(_selectPipeThickness);
    on<AddMarkerCalibarationDataEvent>(_selectCabilabrationData);
    on<AddMarkerAddImageEvent>(_selectFile);
    on<AddMarkerSelectMarkerEvent>(_selectMarker);
    on<AddMarkerSubmitDataEvent>(_submitData);
  }

  _pageLoader(AddMarkerPageLoadEvent event, emit) async {
    emit(AddMarkerPageLoadState());
    dateController.text = "";
    onBodyController.text = "";
    onWeldController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    primaryAbatchController.text = "";
    locationController.text = "";
    holidayTestNoController.text = "";
    primaryBbatchController.text = "";
    surfacePreparationController.text = "";
    descriptionController.text = "";
    surfaceController.text = "";
    holidayCheckList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData =  AlignmentModel();
    isLoader =  false;
    holidayChecksData = HolidayChecksModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData =  JointTypeModel();
    isJointNumberLoader = false;
    file =  File("");
    thicknessList = [];
    thicknessData =  ThicknessModel();
    coatingThicknessData =  ThicknessModel();
    pipeDiaData =  PipeDiaModel();
    pipeDiaList = [];
    peelTestData =  PaddingModel();
    peelTestList =  [];
    coatingTypeList = [];
    coatingTypeData =  CoatingTypeModel();
    weatherData =  WeatherModel();
    pipeMaterialList = [];
    pipeMaterialData =  PipeMaterialModel();
    visualsChecksList = [];
    markerTypeList = [];
    markerTypeData =  MarkerTypeModel();
    visualChecksData = VisualChecksModel();
    _userData =  UserInfo.instanceInit()!.userData!;
    weatherList =  await DashboardHelper.fetchWeatherData( userData: userData);

    var res =  await AddRouteSurveyHelper.fetchAlignmentData(userData: userData);
    if(res != null){
      alignmentList =  res;
    }
    var resJointType =  await AddWeldingHelper.fetchJointType( userData: userData);
    if(resJointType != null){
      jointTypeList =  resJointType;
    }

    var thicknessRes =  await AddConcreteCoatingHelper.fetchThicknessData(userData: userData);
    if(thicknessRes != null){
      thicknessList =  thicknessRes;
    }

    var resHoliday =  await AddBendingHelper.fetchHolidayData();
    if(resHoliday != null){
      holidayCheckList =  resHoliday;
    }

    var pipeDiaRes =  await AddLoweringHelper.fetchPipeDiaData( userData: userData);
    if(pipeDiaRes != null){
      pipeDiaList =  pipeDiaRes;
    }

    var coatingRes =  await AddJointCoatingHelper.fetchCoatingTypeData(userData: userData);
    if(coatingRes != null){
      coatingTypeList =  coatingRes;
    }

    var peelTestRes =  await AddHDPEDuctHelper.fetchPaddingData();
    if(peelTestRes != null){
      peelTestList =  peelTestRes;
    }

    var pipeMaterialRes =  await AddJointCoatingHelper.fetchPipeMaterialData(userData: userData);
    if(pipeMaterialRes != null){
      pipeMaterialList =  pipeMaterialRes;
    }

    var visualsChecksRes =  await AddBendingHelper.fetchVisualChecks();
    if(visualsChecksRes != null){
      visualsChecksList =  visualsChecksRes;
    }

    var markerTypeRes =  await AddMarkerHelper.fetchMarkerData();
    if(markerTypeRes != null){
      markerTypeList =  markerTypeRes;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData =  event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddMarkerSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectCoatingType(AddMarkerSelectCoatingTypeDataEvent event, emit) {
    coatingTypeData =  event.coatingTypeData;
    _eventComplete(emit);
  }

  _selectPipeMaterial(AddMarkerSelectPipeMaterialDataEvent event, emit) {
    pipeMaterialData =  event.pipeMaterialData;
    _eventComplete(emit);
  }

  _selectVisualCheck(AddMarkerSelectVisualChecksDataEvent event, emit) {
    visualChecksData =  event.visualChecksData;
    _eventComplete(emit);
  }

  _selectPeelTest(AddMarkerSelectPeelTestDataEvent event, emit) {
    peelTestData =  event.peelTestData;
    _eventComplete(emit);
  }

  _selectHolidayData(AddMarkerSelectHolidayDataEvent event, emit) {
    holidayChecksData = event.holidayChecksData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddMarkerSelectFromJointDataEvent event, emit) {
    fromJointData =  event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddMarkerSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddMarkerSelectJointTypeDataEvent event, emit) async {
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

  _selectDate(AddMarkerSelectDateEvent event, emit) async {

    DateTime? pickedDate = await showDatePicker(context: event.context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text =  formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      log("Date is not selected");
    }
  }

  _selectPipeDia(AddMarkerSelectPipeDiaDataEvent event, emit) {
    pipeDiaData =  event.pipeDiaData;
    _eventComplete(emit);
  }

  _selectThickness(AddMarkerSelectThicknessDataEvent event, emit) {
    coatingThicknessData =  event.coatingThicknessData;
    _eventComplete(emit);
  }

  _selectPipeThickness(AddMarkerSelectPipeThicknessDataEvent event, emit) {
    thicknessData =  event.thicknessData;
    _eventComplete(emit);
  }

  _selectCabilabrationData(AddMarkerCalibarationDataEvent event, emit) async {

    DateTime? pickedDate = await showDatePicker(context: event.context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      onBodyController.text =  formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      log("Date is not selected");
    }
  }

  _selectMarker(AddMarkerSelectMarkerEvent event, emit) {
    markerTypeData =  event.markerTypeData;
    _eventComplete(emit);
  }

  _selectFile(AddMarkerAddImageEvent event, emit) async {
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
    Navigator.pop(event.context.mounted ? event.context : event.context);
    _eventComplete(emit);
  }

  _submitData(AddMarkerSubmitDataEvent event, emit) async {
    isLoader =  true;
    _eventComplete(emit);
    var res =  await AddMarkerHelper.submitData(context: event.context,
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
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      description: descriptionController.text.toString(),
      file: file,
      onBody: onBodyController.text.toString(),
      holidayTestNo: holidayTestNoController.text.toString(),
      locationName: locationController.text.toString(),
      primaryAbatch: primaryAbatchController.text.toString(),
      surfacePreparation: surfacePreparationController.text.toString(),
      surface: surfaceController.text.toString(),
      primaryBbatch: primaryBbatchController.text.toString(),
      pipeDiaData: pipeDiaData,
      thicknessData: thicknessData,
      visualChecksData: visualChecksData,
      coatingThicknessData: coatingThicknessData,
      pipeMaterialData: pipeMaterialData,
      peelTestData: peelTestData,
      markerTypeData: markerTypeData,
    );
    isLoader =  false;
    _eventComplete(emit);
    if(res !=  null){
      dateController.text = "";
      onWeldController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      descriptionController.text = "";
      alignmentData =  AlignmentModel();
      isLoader =  false;
      holidayChecksData = HolidayChecksModel();
      primaryBbatchController.text = "";
      locationController.text = "";
      holidayTestNoController.text = "";
      surfacePreparationController.text = "";
      onBodyController.text = "";
      surfaceController.text = "";
      primaryAbatchController.text = "";
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData =  JointTypeModel();
      isJointNumberLoader = false;
      file =  File("");
      weatherData =  WeatherModel();
      thicknessData =  ThicknessModel();
      coatingThicknessData =  ThicknessModel();
      pipeDiaData =  PipeDiaModel();
      peelTestData =  PaddingModel();
      coatingTypeData =  CoatingTypeModel();
      pipeMaterialData =  PipeMaterialModel();
      visualChecksData =  VisualChecksModel();
      markerTypeData =  MarkerTypeModel();
      _eventComplete(emit);
    }
  }


  _eventComplete(Emitter<AddMarkerState>emit) {
    emit(FetchAddMarkerDataState(isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      onWeldController: onWeldController,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
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
      primaryAbatchController: primaryAbatchController,
      locationController: locationController,
      toJointData: toJointData,
      holidayTestNoController: holidayTestNoController,
      holidayChecksData: holidayChecksData,
      onBodyController: onBodyController,
      holidayCheckList: holidayCheckList,
      surfacePreparationController: surfacePreparationController,
      primaryBbatchController: primaryBbatchController,
      descriptionController: descriptionController,
      surfaceController: surfaceController,
      pipeDiaData: pipeDiaData,
      pipeDialList: pipeDiaList,
      thicknessData: thicknessData,
      coatingThicknessData: coatingThicknessData,
      thicknessList: thicknessList,
      peelTestData: peelTestData,
      peelTestList: peelTestList,
      coatingTypeData: coatingTypeData,
      coatingTypeList: coatingTypeList,
      pipeMaterialData: pipeMaterialData,
      pipeMaterialList: pipeMaterialList,
      visualChecksData: visualChecksData,
      visualsChecksList: visualsChecksList,
      markerTypeData: markerTypeData,
      markerTypeList: markerTypeList
    ));
  }

}
