import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/hepler/add_tren_ching_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_tren_ching_event.dart';
part 'add_tren_ching_state.dart';

class AddTrenChingBloc extends Bloc<AddTrenChingEvent, AddTrenChingState> {
  bool _isLoader = false;

  bool get isLoader => _isLoader;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  List<TerrainTypeModel> terrainTypeList = [];
  TerrainTypeModel terrainTypeData = TerrainTypeModel();

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController toJointIdController = TextEditingController();
  TextEditingController trenchingDepthController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController fromJointIdController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController toWidthController = TextEditingController();
  TextEditingController bottomWidthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController detailsStructureCtrl= TextEditingController();
  TextEditingController mimimumCoverCtrl= TextEditingController();
  TextEditingController arableSoilCtrl= TextEditingController();
  TextEditingController trenchProfileCtrl= TextEditingController();
  TextEditingController fromCtrl= TextEditingController();
  TextEditingController toCtrl= TextEditingController();
  TextEditingController ipFromCtrl= TextEditingController();
  TextEditingController ipToCtrl= TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController provisionOfWarningSignsSafetySignsCtrl = TextEditingController();
  TextEditingController seismicZoneAndCoverCtrl = TextEditingController();
  TextEditingController verificationOfMinimumDepthCtrl = TextEditingController();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<JointNumberModel> _jointNumberList = [];

  List<JointNumberModel> get jointNumberList => _jointNumberList;

  JointNumberModel _jointNumberData = JointNumberModel();

  JointNumberModel get jointNumberData => _jointNumberData;

  File file = File("");

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];

  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;



  AddTrenChingBloc() : super(AddTrenChingInitial()) {
    on<AddTrenChingPageLoadEvent>(_pageLoadEvent);
    on<AddTrenChingSelectAlignmentEvent>(_selectAlignment);
    on<AddTrenChingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<SelectWeatherEvent>(_selectWeather);
    on<CalculateLengthEvent>(_calculateChainage);
    on<AddTrenChingSelectDateEvent>(_selectDate);
    on<AddTrenChingAddImageEvent>(_selectFile);
    on<AddTrenChingSelectFromJointDataEvent>(_selectJointFrom);
    on<AddTrenChingSelectToJointDataEvent>(_selectJointTo);
    on<AddTrenChingSelectJointTypeDataEvent>(_selectJointType);
    on<AddClearingGradingSelectTerrainEvent>(_selectTerrain);
    on<AddTrenChingSubmitDataEvent>(_submitData);
  }

  _pageLoadEvent(AddTrenChingPageLoadEvent event, emit) async {
    emit(AddTrenChingPageLoadState());
    dateController = TextEditingController();
    reportNumberController = TextEditingController();
    toJointIdController = TextEditingController();
    trenchingDepthController = TextEditingController();
    tpRemarkNumberController = TextEditingController();
    fromJointIdController = TextEditingController();
    activityRemarkController = TextEditingController();
    toWidthController = TextEditingController();
    bottomWidthController = TextEditingController();
    lengthController = TextEditingController();
    detailsStructureCtrl= TextEditingController();
    mimimumCoverCtrl= TextEditingController();
    arableSoilCtrl= TextEditingController();
    trenchProfileCtrl= TextEditingController();
    fromCtrl= TextEditingController();
    toCtrl= TextEditingController();
    ipFromCtrl= TextEditingController();
    ipToCtrl= TextEditingController();
    chainageFromController = TextEditingController();
    chainageToController = TextEditingController();
    provisionOfWarningSignsSafetySignsCtrl = TextEditingController();
    seismicZoneAndCoverCtrl = TextEditingController();
    verificationOfMinimumDepthCtrl = TextEditingController();
    _isLoader = false;
    alignmentList = [];
    file = File("");
    _weatherData = WeatherModel();
    _userData = UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData();
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    _jointNumberData = JointNumberModel();
    _jointNumberList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
   terrainTypeList = [];
   terrainTypeData = TerrainTypeModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }
    var resTerrain = await DashboardHelper.fetchTerrainData();
    if (resTerrain != null) {
      terrainTypeList = resTerrain;
    }
    var resJointNumber = await DashboardHelper.fetchJointNumberData(
        type:  AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
            ? AppConfig.instanceInit()!.activitySectionData.appJoint!
            : "afterndtrt"

    );
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
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

  _selectAlignment(AddTrenChingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddTrenChingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectDate(AddTrenChingSelectDateEvent event, emit) async {
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
     // print("Date is not selected");
    }
  }

  _selectJointFrom(AddTrenChingSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddTrenChingSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddTrenChingSelectJointTypeDataEvent event, emit) async {
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

  _selectTerrain(AddClearingGradingSelectTerrainEvent event, emit) {
    terrainTypeData = event.terrainTypeData;
    _eventComplete(emit);
  }


  _selectFile(AddTrenChingAddImageEvent event, emit) async {
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

  _submitData(AddTrenChingSubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddTrenChingHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      jointNumberFromModel: fromJointData,
      jointNumberToModel: toJointData,
      trenchingDepth: trenchingDepthController.text.toString(),
      terrainType: terrainTypeData.id == null ? "" : terrainTypeData.id.toString(),
      activityRemark: activityRemarkController.text.toString(),
      userData: userData,
      file: file,
      weatherData: weatherData,
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      toWidth: toWidthController.text.toString(),
      bottomWidth: bottomWidthController.text.toString(),
      availabilityOfMimimumCover: mimimumCoverCtrl.text.toString(),
      chainageFromSingle: chainageFromController.text.toString(),
      chainageToSingle: chainageToController.text.toString(),
      detailsOfStructure: detailsStructureCtrl.text.toString(),
      ipFrom: ipFromCtrl.text.toString(),
      ipTo: ipToCtrl.text.toString(),
      separationOfArableSoil: arableSoilCtrl.text.toString(),
      suitabilityOfTrenchProfileForBends: trenchProfileCtrl.text.toString(),
      provisionOfWarningSignsSafetySigns: provisionOfWarningSignsSafetySignsCtrl.text.toString(),
      seismicZoneAndCover: seismicZoneAndCoverCtrl.text.toString(),
      verificationOfMinimumDepth: verificationOfMinimumDepthCtrl.text.toString(),


    );
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController = TextEditingController();
      reportNumberController = TextEditingController();
      toJointIdController = TextEditingController();
      trenchingDepthController = TextEditingController();
      tpRemarkNumberController = TextEditingController();
      fromJointIdController = TextEditingController();
      activityRemarkController = TextEditingController();
      toWidthController = TextEditingController();
      bottomWidthController = TextEditingController();
      lengthController = TextEditingController();
      detailsStructureCtrl= TextEditingController();
      mimimumCoverCtrl= TextEditingController();
      arableSoilCtrl= TextEditingController();
      trenchProfileCtrl= TextEditingController();
      fromCtrl= TextEditingController();
      toCtrl= TextEditingController();
      ipFromCtrl= TextEditingController();
      ipToCtrl= TextEditingController();
      chainageFromController = TextEditingController();
      chainageToController = TextEditingController();
      provisionOfWarningSignsSafetySignsCtrl = TextEditingController();
      seismicZoneAndCoverCtrl = TextEditingController();
      verificationOfMinimumDepthCtrl = TextEditingController();
      _isLoader = false;
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      file = File("");
      _weatherData = WeatherModel();
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      terrainTypeData = TerrainTypeModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddTrenChingState> emit) {
    emit(FetchAddTrenChingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      fromJointIdController: fromJointIdController,
      reportNumberController: reportNumberController,
      terrainTypeData: terrainTypeData,
      terrainTypeList: terrainTypeList,
      toJointIdController: toJointIdController,
      trenchingDepthController: trenchingDepthController,
      arableSoilCtrl: arableSoilCtrl,
      detailsStructureCtrl: detailsStructureCtrl,
      fromCtrl: fromCtrl,
      ipFromCtrl: ipFromCtrl,
      ipToCtrl: ipToCtrl,
      mimimumCoverCtrl: mimimumCoverCtrl,
      toCtrl: toCtrl,
      trenchProfileCtrl: trenchProfileCtrl,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      jointNumberList: jointNumberList,
      jointNumberData: jointNumberData,
      weatherData: weatherData,
      weatherList: weatherList,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      isJointNumberLoader: isJointNumberLoader,
      fromJointData: fromJointData,
      jointFromList: jointFromList,
      jointToList: jointToList,
      toJointData: toJointData,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      toWidthController: toWidthController,
      bottomWidthController: bottomWidthController,
      lengthController: lengthController,
      provisionOfWarningSignsSafetySignsCtrt: provisionOfWarningSignsSafetySignsCtrl,
      seismicZoneAndCoverCtrl: seismicZoneAndCoverCtrl,
      verificationOfMinimumDepthCtrl: verificationOfMinimumDepthCtrl,
    ));
  }
}
