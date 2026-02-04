import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/restoration/addRestoration/helper/add_restoration_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

import '../../../../routeSurvey/addRouteSurvey/domain/model/weather_model.dart';

part 'add_restoration_event.dart';
part 'add_restoration_state.dart';

class AddRestorationBloc
    extends Bloc<AddRestorationEvent, AddRestorationState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController landTypeController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  List<VisualChecksModel> plasticGratingList = [];
  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  bool isLoader = false;
  VisualChecksModel plasticGratingData = VisualChecksModel();
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<PaddingModel> removalOfSurplusMaterialList = [];
  List<PaddingModel> replacementofTopSoilList = [];
  List<PaddingModel> reinstallationBoundaryStonesList = [];

  PaddingModel removalOfSurplusMaterialData = PaddingModel();
  PaddingModel replacementofTopSoilData = PaddingModel();
  PaddingModel reinstallationBoundaryStonesData = PaddingModel();

  AddRestorationBloc() : super(AddRestorationInitial()) {
    on<AddRestorationPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddRestorationSelectAlignmentEvent>(_selectAlignment);
    on<AddRestorationMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddRestorationSelectRemovalOfSurplusMaterialDataEvent>(
        _selectRemovalOfSurplusMaterialData);
    on<AddRestorationSelectReplacementofTopSoilDataEvent>(
        _selectReplacementofTopSoilData);
    on<AddRestorationSelectReinstallationBoundaryStonesDataEvent>(
        _selectReinstallationBoundaryStonesData);
    on<AddRestorationSelectFromJointDataEvent>(_selectJointFrom);
    on<AddRestorationSelectToJointDataEvent>(_selectJointTo);
    on<AddRestorationSelectJointTypeDataEvent>(_selectJointType);
    on<AddRestorationSelectDateEvent>(_selectDate);
    on<AddRestorationAddImageEvent>(_selectFile);
    on<AddRestorationSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddRestorationPageLoadEvent event, emit) async {
    emit(AddRestorationPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    landTypeController.text = "";
    lengthController.text = "";
    plasticGratingList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    isLoader = false;
    plasticGratingData = VisualChecksModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    weatherData = WeatherModel();
    removalOfSurplusMaterialList = [];
    replacementofTopSoilList = [];
    reinstallationBoundaryStonesList = [];

    removalOfSurplusMaterialData = PaddingModel();
    replacementofTopSoilData = PaddingModel();
    reinstallationBoundaryStonesData = PaddingModel();
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }

  /*  var resJointType = await AddWeldingHelper.fetchJointType(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resJointType != null) {
      jointTypeList = resJointType;
    }*/
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
      context: event.context,
      userData: userData,
    //  jointTypeData: jointTypeData,
      type: "afterndtrt",
    );
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }
    var resPadding = await AddHDPEDuctHelper.fetchPaddingData(
        context: !event.context.mounted ? event.context : event.context);
    if (resPadding != null) {
      replacementofTopSoilList = resPadding;
      removalOfSurplusMaterialList = resPadding;
      reinstallationBoundaryStonesList = resPadding;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddRestorationSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddRestorationMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectRemovalOfSurplusMaterialData(
      AddRestorationSelectRemovalOfSurplusMaterialDataEvent event, emit) {
    removalOfSurplusMaterialData = event.removalOfSurplusMaterialData;
    _eventComplete(emit);
  }

  _selectReplacementofTopSoilData(
      AddRestorationSelectReplacementofTopSoilDataEvent event, emit) {
    replacementofTopSoilData = event.replacementofTopSoilData;
    _eventComplete(emit);
  }

  _selectReinstallationBoundaryStonesData(
      AddRestorationSelectReinstallationBoundaryStonesDataEvent event, emit) {
    reinstallationBoundaryStonesData = event.reinstallationBoundaryStonesData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddRestorationSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddRestorationSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddRestorationSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointFromList = [];
    jointToList = [];
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
   /* var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        jointTypeData: jointTypeData,
      type: "afterndtrt",
    );
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }*/
    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectDate(AddRestorationSelectDateEvent event, emit) async {
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

  _selectFile(AddRestorationAddImageEvent event, emit) async {
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

  _submitData(AddRestorationSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddRestorationHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        landType: landTypeController.text.toString(),
        reinstallationBoundaryStonesData: replacementofTopSoilData,
        removalOfSurplusMaterialData: replacementofTopSoilData,
        replacementofTopSoilData: replacementofTopSoilData,
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        fromJointData: fromJointData,
        toJointData: toJointData,
        jointTypeData: jointTypeData,
        length: lengthController.text.toString(),
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        file: file);
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      landTypeController.text = "";
      lengthController.text = "";
      alignmentData =  AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      plasticGratingData = VisualChecksModel();
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      removalOfSurplusMaterialData = PaddingModel();
      replacementofTopSoilData = PaddingModel();
      reinstallationBoundaryStonesData = PaddingModel();
      weatherData = WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddRestorationState> emit) {
    emit(FetchAddRestorationDataState(
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
      landTypeController: landTypeController,
      toJointData: toJointData,
      reinstallationBoundaryStonesData: reinstallationBoundaryStonesData,
      reinstallationBoundaryStonesList: reinstallationBoundaryStonesList,
      removalOfSurplusMaterialData: removalOfSurplusMaterialData,
      removalOfSurplusMaterialList: removalOfSurplusMaterialList,
      replacementofTopSoilData: replacementofTopSoilData,
      replacementofTopSoilList: replacementofTopSoilList,
      lengthController: lengthController,
    ));
  }
}
