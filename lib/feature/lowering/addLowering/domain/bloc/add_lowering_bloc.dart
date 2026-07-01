import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/helper/clearing_grading_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/helper/add_concrete_coating_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/helper/add_lowering_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_lowering_event.dart';
part 'add_lowering_state.dart';

class AddLoweringBloc extends Bloc<AddLoweringEvent, AddLoweringState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController calibarationDateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController holidayDetectorDetailsController = TextEditingController();
  TextEditingController testVoltageController = TextEditingController();
  TextEditingController repairCoatingController = TextEditingController();
  TextEditingController postPaddingController = TextEditingController();
  TextEditingController postPaddingCtrl = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  List<HolidayChecksModel> holidayCheckList = [];
  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  bool isLoader = false;
  HolidayChecksModel holidayChecksData = HolidayChecksModel();
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<ThicknessModel> thicknessList = [];
  ThicknessModel thicknessData = ThicknessModel();

  List<PipeDiaModel> pipeDiaList = [];
  PipeDiaModel pipeDiaData = PipeDiaModel();

  TerrainTypeModel dewateringValue = TerrainTypeModel();
  TerrainTypeModel paddingValue = TerrainTypeModel();
  TerrainTypeModel paddingMaterialValue = TerrainTypeModel();
  TerrainTypeModel loweringClearanceValue = TerrainTypeModel();
  TerrainTypeModel approvedPipeValue = TerrainTypeModel();
  TerrainTypeModel nightCapValue = TerrainTypeModel();

  List<TerrainTypeModel> listOfDewatering = [];
  List<TerrainTypeModel> listOfPadding = [];
  List<TerrainTypeModel> listOfPaddingMaterial = [];
  List<TerrainTypeModel> listOfLoweringClearance = [];
  List<TerrainTypeModel> listOfApprovedPipe = [];
  List<TerrainTypeModel> listOfNightCap = [];

  AddLoweringBloc() : super(AddLoweringInitial()) {
    on<AddLoweringPageLoadEvent>(_pageLoader);
    on<SelectWeatherEvent>(_selectWeather);
    on<CalculateLengthEvent>(_calculateChainage);
    on<AddLoweringSelectAlignmentEvent>(_selectAlignment);
    on<AddLoweringMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddLoweringSelectHolidayDataEvent>(_selectHolidayData);
    on<AddLoweringSelectFromJointDataEvent>(_selectJointFrom);
    on<AddLoweringSelectToJointDataEvent>(_selectJointTo);
    on<AddLoweringSelectJointTypeDataEvent>(_selectJointType);
    on<AddLoweringSelectDateEvent>(_selectDate);
    on<AddLoweringSelectPipeDiaDataEvent>(_selectPipeDia);
    on<AddLoweringSelectThicknessDataEvent>(_selectThickness);
    on<AddLoweringCalibarationDataEvent>(_selectCabilabrationData);
    on<AddLoweringSelectDewateringEvent>(_selectDewatering);
    on<AddLoweringSelectPaddingEvent>(_selectPadding);
    on<AddLoweringSelectPaddingMaterialEvent>(_selectPaddingMaterial);
    on<AddLoweringSelectLoweringClearanceEvent>(_selectLoweringClearance);
    on<AddLoweringSelectApprovedPipeEvent>(_selectApprovedPipe);
    on<AddLoweringSelectNightCapEvent>(_selectNightCap);
    on<AddLoweringAddImageEvent>(_selectFile);
    on<AddLoweringSubmitDataEvent>(_submitData);
  }

  _pageLoader(AddLoweringPageLoadEvent event, emit) async {
    emit(AddLoweringPageLoadState());
    dateController.text = "";
    calibarationDateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    modelController.text = "";
    locationController.text = "";
    holidayDetectorDetailsController.text = "";
    testVoltageController.text = "";
    repairCoatingController.text = "";
    postPaddingController.text = "";
    postPaddingCtrl.text = "";
    lengthController.text = "";
    holidayCheckList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    isLoader = false;
    holidayChecksData = HolidayChecksModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    thicknessList = [];
    thicknessData = ThicknessModel();
    pipeDiaData = PipeDiaModel();
    pipeDiaList = [];
    weatherData = WeatherModel();
    dewateringValue = TerrainTypeModel();
    paddingValue = TerrainTypeModel();
    paddingMaterialValue = TerrainTypeModel();
    loweringClearanceValue = TerrainTypeModel();
    approvedPipeValue = TerrainTypeModel();
    nightCapValue = TerrainTypeModel();
    listOfDewatering=  [];
    listOfPadding = [];
    listOfPaddingMaterial = [];
     listOfLoweringClearance = [];
    listOfApprovedPipe = [];
    listOfNightCap = [];

    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }


    listOfDewatering        = await AddClearingGradingHelper.fetchConstantData("DEWATERING");
    listOfPadding           = await AddClearingGradingHelper.fetchConstantData("LOWER_PADDING");
    listOfPaddingMaterial   = await AddClearingGradingHelper.fetchConstantData("PADDING_MATERIAL");
    listOfLoweringClearance = await AddClearingGradingHelper.fetchConstantData("LOWERING_CLEARANCE");
    listOfApprovedPipe      = await AddClearingGradingHelper.fetchConstantData("LOWER_PIPEBOOK");
    listOfNightCap          = await AddClearingGradingHelper.fetchConstantData("NIGHTCAP_TEST");


    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
      type:  AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
          ? AppConfig.instanceInit()!.activitySectionData.appJoint!
          :"afterndtrt",);
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }

    var resHoliday = await AddBendingHelper.fetchHolidayData(
        context: !event.context.mounted ? event.context : event.context);
    if (resHoliday != null) {
      holidayCheckList = resHoliday;
    }

    var thicknessRes = await AddConcreteCoatingHelper.fetchThicknessData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (thicknessRes != null) {
      thicknessList = thicknessRes;
    }

    var pipeDiaRes = await AddLoweringHelper.fetchPipeDiaData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (pipeDiaRes != null) {
      pipeDiaList = pipeDiaRes;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _calculateChainage(CalculateLengthEvent event, emit) {
    bool isChainageTo =  event.isChainageTo;
    String value =  event.value;

    if(value.isEmpty) {
      lengthController.text = "";
    } else if(isChainageTo == true && value.isNotEmpty && chainageFromController.text.toString().isNotEmpty){
      double chainageTo =  double.parse(value.toString());
      double chainageFrom =  double.parse(chainageFromController.text.toString());
      lengthController.text =  "${chainageTo - chainageFrom}";

    } else if(isChainageTo == false && value.isNotEmpty && chainageToController.text.toString().isNotEmpty){
      double chainageTo =  double.parse(chainageToController.text.toString());
      double chainageFrom =  double.parse(value);
      lengthController.text =  "${chainageTo - chainageFrom}";
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddLoweringSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddLoweringMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }



  _selectHolidayData(AddLoweringSelectHolidayDataEvent event, emit) {
    holidayChecksData = event.holidayChecksData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddLoweringSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddLoweringSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddLoweringSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointFromList = [];
    jointToList = [];
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);

    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectDate(AddLoweringSelectDateEvent event, emit) async {
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

  _selectPipeDia(AddLoweringSelectPipeDiaDataEvent event, emit) {
    pipeDiaData = event.pipeDiaData;
    _eventComplete(emit);
  }

  _selectThickness(AddLoweringSelectThicknessDataEvent event, emit) {
    thicknessData = event.thicknessData;
    _eventComplete(emit);
  }

   _selectDewatering(AddLoweringSelectDewateringEvent event, emit) {
     dewateringValue = event.dewateringValue;
     _eventComplete(emit);
  }

 _selectPadding(AddLoweringSelectPaddingEvent event, emit) {
   paddingValue = event.paddingValue;
   _eventComplete(emit);
  }

  _selectPaddingMaterial(AddLoweringSelectPaddingMaterialEvent event, emit) {
    paddingMaterialValue = event.paddingMaterialValue;
    _eventComplete(emit);
  }

 _selectLoweringClearance(AddLoweringSelectLoweringClearanceEvent event, emit) {
   loweringClearanceValue = event.loweringClearanceValue;
   _eventComplete(emit);
  }

  _selectApprovedPipe(AddLoweringSelectApprovedPipeEvent event, emit) {
    approvedPipeValue = event.approvedPipeValue;
    _eventComplete(emit);
  }


  _selectNightCap(AddLoweringSelectNightCapEvent event,emit) {
    nightCapValue = event.nightCapValue;
    _eventComplete(emit);
  }

  _selectCabilabrationData(AddLoweringCalibarationDataEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      calibarationDateController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _selectFile(AddLoweringAddImageEvent event, emit) async {
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

  _submitData(AddLoweringSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddLoweringHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
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
      postPadding: postPaddingController.text.toString(),
      file: file,
      calibarationDate: calibarationDateController.text.toString(),
      holidayDetectorDetail: holidayDetectorDetailsController.text.toString(),
      locationName: locationController.text.toString(),
      makeModel: modelController.text.toString(),
      repairOfCoatingDamage: repairCoatingController.text.toString(),
      length: lengthController.text.toString(),
      testVoltage: testVoltageController.text.toString(),
      pipeDiaData: pipeDiaData,
      thicknessData: thicknessData,
      dewatering: dewateringValue.id.toString().isNotEmpty? dewateringValue.id.toString() : "",
      lowerClearance: loweringClearanceValue.id.toString().isNotEmpty? loweringClearanceValue.id.toString() : "",
      lowerPadding: postPaddingCtrl.text.toString(),
      lowerPipebook: approvedPipeValue.id.toString().isNotEmpty? approvedPipeValue.id.toString() : "",
      nightCapTest: nightCapValue.id.toString().isNotEmpty? nightCapValue.id.toString() : "",
      padding: paddingValue.id.toString().isNotEmpty? paddingValue.id.toString() : "",
      paddingMaterial: paddingMaterialValue.id.toString().isNotEmpty? paddingMaterialValue.id.toString() : "",
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      postPaddingController.text = "";
      postPaddingCtrl.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      holidayChecksData = HolidayChecksModel();
      testVoltageController.text = "";
      locationController.text = "";
      holidayDetectorDetailsController.text = "";
      repairCoatingController.text = "";
      calibarationDateController.text = "";
      lengthController.text = "";
      modelController.text = "";
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      thicknessData = ThicknessModel();
      pipeDiaData = PipeDiaModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddLoweringState> emit) {
    emit(FetchAddLoweringDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      reportNumberController: reportNumberController,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      weatherList: weatherList,
      weatherData: weatherData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      fromJointData: fromJointData,
      jointFromList: jointFromList,
      jointToList: jointToList,
      modelController: modelController,
      locationController: locationController,
      toJointData: toJointData,
      holidayDetectorDetailsController: holidayDetectorDetailsController,
      holidayChecksData: holidayChecksData,
      calibarationDateController: calibarationDateController,
      holidayCheckList: holidayCheckList,
      repairCoatingController: repairCoatingController,
      testVoltageController: testVoltageController,
      postPaddingController: postPaddingController,
      postPaddingCtrl: postPaddingCtrl,
      lengthController: lengthController,
      pipeDiaData: pipeDiaData,
      pipeDialList: pipeDiaList,
      thicknessData: thicknessData,
      thicknessList: thicknessList,
      approvedPipeValue: approvedPipeValue,
      listOfDewatering: listOfDewatering,
      listOfApprovedPipe: listOfApprovedPipe,
      listOfLoweringClearance: listOfLoweringClearance,
      listOfPaddingMaterial: listOfPaddingMaterial,
      listOfPadding: listOfPadding,
      loweringClearanceValue: loweringClearanceValue,
      paddingMaterialValue: paddingMaterialValue,
      paddingValue: paddingValue,
      dewateringValue: dewateringValue,
      listOfNightCap: listOfNightCap,
      nightCapValue: nightCapValue,
    ));
  }

}
