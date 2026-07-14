import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/cableInstallation/addCableInstallation/helper/add_cable_installation_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/domain/model/tlp_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/TCP/testStationBoxs/addTestStationBoxs/helper/add_test_station_box_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_cable_installation_event.dart';
part 'add_cable_installation_state.dart';

class AddCableInstallationBloc extends Bloc<AddCableInstallationEvent, AddCableInstallationState> {
  AddCableInstallationBloc() : super(AddCableInstallationInitial()) {
    on<AddCableInstallationPageLoadEvent>(_pageLoadEvent);
    on<AddCableInstallationSelectDateEvent>(_selectDate);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddTestStationBoxTLPTypeEvent>(_selectTLPType);
    on<AddTestStationBoxCableTrenchEvent>(_selectCableTrench);
    on<AddTestStationBoxSandEvent>(_selectSand);
    on<AddTestStationBoxWarningEvent>(_selectWarning);
    on<AddTestStationBoxBackfillingEvent>(_selectBackfilling);
    on<AddTestStationBoxTaggingEvent>(_selectTagging);
    on<AddTestStationBoxRouteMarkingEvent>(_selectMarking);
    on<AddTestStationBoxIREvent>(_selectIR);
    on<AddCableInstallationSelectAlignmentEvent>(_selectAlignment);
    on<AddCableInstallationMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddCableInstallationAddImageEvent>(_selectFile);
    on<AddCableInstallationSubmitDataEvent>(_submitData);
  }

  bool isLoader = false;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController= TextEditingController();
  TextEditingController reportNumberController= TextEditingController();
  TextEditingController areaController= TextEditingController();
  TextEditingController chainageController= TextEditingController();
  TextEditingController cableSizeController= TextEditingController();
  TextEditingController depthController= TextEditingController();
  TextEditingController activityRemarkController= TextEditingController();

  LoginDataModel userData = LoginDataModel();
  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<TlpTypeModel> listOfTLPType = [];
  TlpTypeModel tlpTypeValue = TlpTypeModel();

  VisualChecksModel cableTrenchValue = VisualChecksModel();
  List<VisualChecksModel> listOfCableTrench = [];

  VisualChecksModel sandValue = VisualChecksModel();
  List<VisualChecksModel> listOfSand = [];

  VisualChecksModel warningValue = VisualChecksModel();
  List<VisualChecksModel> listOfWarning = [];

  VisualChecksModel backfillingValue = VisualChecksModel();
  List<VisualChecksModel> listOfBackfilling = [];

  VisualChecksModel taggingValue = VisualChecksModel();
  List<VisualChecksModel> listOfTagging = [];

  VisualChecksModel routeMarkingValue = VisualChecksModel();
  List<VisualChecksModel> listOfRouteMarking = [];

  VisualChecksModel irValue = VisualChecksModel();
  List<VisualChecksModel> listOfIR = [];

  _pageLoadEvent(AddCableInstallationPageLoadEvent event, emit) async {
    emit(AddCableInstallationPageLoadState());
    file = File("");
    isLoader = false;
    alignmentList = [];
    weatherList = [];
    listOfTLPType = [];
    listOfCableTrench = [];
    listOfSand = [];
    listOfWarning = [];
    listOfBackfilling = [];
    listOfTagging = [];
    listOfRouteMarking = [];
    listOfIR = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    weatherData = WeatherModel();
    tlpTypeValue = TlpTypeModel();
    cableTrenchValue = VisualChecksModel();
    sandValue = VisualChecksModel();
    warningValue = VisualChecksModel();
    backfillingValue = VisualChecksModel();
    taggingValue = VisualChecksModel();
    routeMarkingValue = VisualChecksModel();
    irValue = VisualChecksModel();
    dateController.text = "";
    areaController.text = "";
    chainageController.text = "";
    cableSizeController.text = "";
    depthController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData();
    userData = UserInfo.instanceInit()!.userData!;
    var res = await AddRouteSurveyHelper.fetchAlignmentData();
    if (res != null) {
      alignmentList = res;
    }
    var resTLPType = await AddTestStationBoxHelper.fetchTLPType();
    if (resTLPType != null) {
      listOfTLPType = resTLPType;
    }
    var resVisual = await AddBendingHelper.fetchVisualChecks();
    if (resVisual != null) {
      listOfSand = resVisual;
    }
    listOfCableTrench = listOfSand;
    listOfWarning = listOfSand;
    listOfBackfilling = listOfSand;
    listOfTagging = listOfSand;
    listOfRouteMarking = listOfSand;
    listOfIR = listOfSand;
    _eventComplete(emit);
  }

  _selectAlignment(AddCableInstallationSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddCableInstallationMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }


  _selectTLPType(AddTestStationBoxTLPTypeEvent event, emit) {
    tlpTypeValue = event.tlpTypeValue;
    _eventComplete(emit);
  }

  _selectCableTrench(AddTestStationBoxCableTrenchEvent event, emit) {
    cableTrenchValue = event.cableTrenchValue;
    _eventComplete(emit);
  }

  _selectSand(AddTestStationBoxSandEvent event, emit) {
    sandValue = event.sandValue;
    _eventComplete(emit);
  }

  _selectWarning(AddTestStationBoxWarningEvent event, emit) {
    warningValue = event.warningValue;
    _eventComplete(emit);
  }

  _selectBackfilling(AddTestStationBoxBackfillingEvent event, emit) {
    backfillingValue = event.backfillingValue;
    _eventComplete(emit);
  }

  _selectTagging(AddTestStationBoxTaggingEvent event, emit) {
    taggingValue = event.taggingValue;
    _eventComplete(emit);
  }

  _selectMarking(AddTestStationBoxRouteMarkingEvent event, emit) {
    routeMarkingValue = event.routeMarkingValue;
    _eventComplete(emit);
  }

  _selectIR(AddTestStationBoxIREvent event, emit) {
    irValue = event.irValue;
    _eventComplete(emit);
  }

  _selectDate(AddCableInstallationSelectDateEvent event, emit) async {
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

  _selectFile(AddCableInstallationAddImageEvent event, emit) async {
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

  _submitData(AddCableInstallationSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddCableInstallationHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      file: file,
      area: areaController.text.trim().toString(),
      backfillingRestoration: backfillingValue,
      cableLengthA2: "",
      cableLengthA3: "",
      cableSize: cableSizeController.text.trim().toString(),
      cableTrench: cableTrenchValue,
      cableValue: "",
      chainage: chainageController.text.trim().toString(),
      depthLaying: depthController.text.trim().toString(),
      earthingResistance: irValue,
      routeMarking: routeMarkingValue,
      sandBrickSpreading: sandValue,
      taggingFerruling: taggingValue,
      tlpTypeId: tlpTypeValue,
      warningMatPlacement: warningValue,

    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      dateController.text = "";
      areaController.text = "";
      chainageController.text = "";
      cableSizeController.text = "";
      depthController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      weatherData = WeatherModel();
      tlpTypeValue = TlpTypeModel();
      cableTrenchValue = VisualChecksModel();
      sandValue = VisualChecksModel();
      warningValue = VisualChecksModel();
      backfillingValue = VisualChecksModel();
      taggingValue = VisualChecksModel();
      routeMarkingValue = VisualChecksModel();
      irValue = VisualChecksModel();
      file = File("");
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddCableInstallationState> emit) {
    emit(FetchAddCableInstallationState(
      file : file,
      isLoader : isLoader,
      alignmentData : alignmentData,
      alignmentList : alignmentList,
      multipleAlignmentData : multipleAlignmentData,
      weatherList : weatherList,
      weatherData : weatherData,
      listOfTLPType : listOfTLPType,
      tlpTypeValue : tlpTypeValue,
      cableTrenchValue : cableTrenchValue,
      listOfCableTrench : listOfCableTrench,
      sandValue : sandValue,
      listOfSand : listOfSand,
      warningValue : warningValue,
      listOfWarning : listOfWarning,
      backfillingValue : backfillingValue,
      listOfBackfilling : listOfBackfilling,
      taggingValue : taggingValue,
      listOfTagging : listOfTagging,
      routeMarkingValue : routeMarkingValue,
      listOfRouteMarking : listOfRouteMarking,
      irValue : irValue,
      listOfIR : listOfIR,
      dateController : dateController,
      reportNumberController : reportNumberController,
      areaController : areaController,
      chainageController : chainageController,
      cableSizeController : cableSizeController,
      depthController : depthController,
      activityRemarkController : activityRemarkController,
    ));
  }
}


