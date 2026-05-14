import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_joint_coating_event.dart';

part 'add_joint_coating_state.dart';

class AddJointCoatingBloc
    extends Bloc<AddJointCoatingEvent, AddJointCoatingState> {
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
  TextEditingController electrometerNoController = TextEditingController();
  TextEditingController batchNoController = TextEditingController();
  TextEditingController surfaceController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController humidityMeterDetailsController =
      TextEditingController();
  TextEditingController digitalPyrometerDetailsController =
      TextEditingController();
  TextEditingController profileGaugeDetailsController = TextEditingController();
  TextEditingController chainageCtrl = TextEditingController();

  List<HolidayChecksModel> holidayCheckList = [];
  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData = [];

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

  List<CoatingTypeModel> coatingTypeList = [];
  CoatingTypeModel coatingTypeData = CoatingTypeModel();

  List<PaddingModel> peelTestList = [];
  PaddingModel peelTestData = PaddingModel();

  List<PaddingModel> surfacePreprationList = [];
  PaddingModel surfacePreprationData = PaddingModel();

  List<PipeMaterialModel> pipeMaterialList = [];
  PipeMaterialModel pipeMaterialData = PipeMaterialModel();

  List<VisualChecksModel> visualsChecksList = [];
  VisualChecksModel visualChecksData = VisualChecksModel();

  AddJointCoatingBloc() : super(AddJointCoatingInitial()) {
    on<AddJointCoatingPageLoadEvent>(_pageLoader);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddJointCoatingSelectAlignmentEvent>(_selectAlignment);
    on<AddJointCoatingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddJointCoatingSelectCoatingTypeDataEvent>(_selectCoatingType);
    on<AddJointCoatingSelectPipeMaterialDataEvent>(_selectPipeMaterial);
    on<AddJointCoatingSelectVisualChecksDataEvent>(_selectVisualCheck);
    on<AddJointCoatingSelectPeelTestDataEvent>(_selectPeelTest);
    on<SelectSurfacePreparationEvent>(_selectSurfacePreparation);
    on<AddJointCoatingSelectHolidayDataEvent>(_selectHolidayData);
    on<AddJointCoatingSelectFromJointDataEvent>(_selectJointFrom);
    on<AddJointCoatingSelectToJointDataEvent>(_selectJointTo);
    on<AddJointCoatingSelectJointTypeDataEvent>(_selectJointType);
    on<AddJointCoatingSelectDateEvent>(_selectDate);
    on<AddJointCoatingSelectPipeDiaDataEvent>(_selectPipeDia);
    on<AddJointCoatingSelectThicknessDataEvent>(_selectThickness);
    on<AddJointCoatingCalibarationDataEvent>(_selectCabilabrationData);
    on<AddJointCoatingAddImageEvent>(_selectFile);
    on<AddJointCoatingSubmitDataEvent>(_submitData);
  }

  _pageLoader(AddJointCoatingPageLoadEvent event, emit) async {
    emit(AddJointCoatingPageLoadState());
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
    electrometerNoController.text = "";
    batchNoController.text = "";
    surfaceController.text = "";
    reportNumberController.text = "";
    profileGaugeDetailsController.text = "";
    digitalPyrometerDetailsController.text = "";
    humidityMeterDetailsController.text = "";
    chainageCtrl.text = "";
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
    peelTestData = PaddingModel();
    peelTestList = [];
    surfacePreprationList = [];
    surfacePreprationData = PaddingModel();
    coatingTypeList = [];
    coatingTypeData = CoatingTypeModel();
    weatherData = WeatherModel();
    pipeMaterialList = [];
    pipeMaterialData = PipeMaterialModel();
    visualsChecksList = [];
    visualChecksData = VisualChecksModel();
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }
/*    var resJointType = await AddWeldingHelper.fetchJointType(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resJointType != null) {
      jointTypeList = resJointType;
    }*/

    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context, userData: userData, type: "welding");
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }

    var thicknessRes = await AddConcreteCoatingHelper.fetchThicknessData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (thicknessRes != null) {
      thicknessList = thicknessRes;
    }

    var resHoliday = await AddBendingHelper.fetchHolidayData(
        context: !event.context.mounted ? event.context : event.context);
    if (resHoliday != null) {
      holidayCheckList = resHoliday;
    }

    var pipeDiaRes = await AddLoweringHelper.fetchPipeDiaData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (pipeDiaRes != null) {
      pipeDiaList = pipeDiaRes;
    }

    var coatingRes = await AddJointCoatingHelper.fetchCoatingTypeData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (coatingRes != null) {
      coatingTypeList = coatingRes;
    }

    var peelTestRes = await AddHDPEDuctHelper.fetchPaddingData(
        context: !event.context.mounted ? event.context : event.context);
    if (peelTestRes != null) {
      peelTestList = peelTestRes;
      surfacePreprationList = peelTestRes;
    }

    var pipeMaterialRes = await AddJointCoatingHelper.fetchPipeMaterialData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (pipeMaterialRes != null) {
      pipeMaterialList = pipeMaterialRes;
    }

    var visualsChecksRes = await AddBendingHelper.fetchVisualChecks(
        context: !event.context.mounted ? event.context : event.context);
    if (visualsChecksRes != null) {
      visualsChecksList = visualsChecksRes;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddJointCoatingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(
      AddJointCoatingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectCoatingType(AddJointCoatingSelectCoatingTypeDataEvent event, emit) {
    coatingTypeData = event.coatingTypeData;
    _eventComplete(emit);
  }

  _selectPipeMaterial(AddJointCoatingSelectPipeMaterialDataEvent event, emit) {
    pipeMaterialData = event.pipeMaterialData;
    _eventComplete(emit);
  }

  _selectVisualCheck(AddJointCoatingSelectVisualChecksDataEvent event, emit) {
    visualChecksData = event.visualChecksData;
    _eventComplete(emit);
  }

  _selectPeelTest(AddJointCoatingSelectPeelTestDataEvent event, emit) {
    peelTestData = event.peelTestData;
    _eventComplete(emit);
  }

  _selectSurfacePreparation(SelectSurfacePreparationEvent event, emit) {
    surfacePreprationData = event.surfacePreparationData;
    _eventComplete(emit);
  }

  _selectHolidayData(AddJointCoatingSelectHolidayDataEvent event, emit) {
    holidayChecksData = event.holidayChecksData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddJointCoatingSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddJointCoatingSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddJointCoatingSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointFromList = [];
    jointToList = [];
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
    /*var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        jointTypeData: jointTypeData);
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }*/
    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectDate(AddJointCoatingSelectDateEvent event, emit) async {
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

  _selectPipeDia(AddJointCoatingSelectPipeDiaDataEvent event, emit) {
    pipeDiaData = event.pipeDiaData;
    _eventComplete(emit);
  }

  _selectThickness(AddJointCoatingSelectThicknessDataEvent event, emit) {
    thicknessData = event.thicknessData;
    _eventComplete(emit);
  }

  _selectCabilabrationData(
      AddJointCoatingCalibarationDataEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      onBodyController.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  _selectFile(AddJointCoatingAddImageEvent event, emit) async {
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

  _submitData(AddJointCoatingSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddJointCoatingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
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
        batchNo: batchNoController.text.toString(),
        file: file,
        onBody: onBodyController.text.toString(),
        holidayTestNo: holidayTestNoController.text.toString(),
        locationName: locationController.text.toString(),
        primaryAbatch: primaryAbatchController.text.toString(),
        electrometerNo: electrometerNoController.text.toString(),
        surface: surfaceController.text.toString(),
        primaryBbatch: primaryBbatchController.text.toString(),
        pipeDiaData: pipeDiaData,
        thicknessData: thicknessData,
        visualChecksData: visualChecksData,
        coatingTypeData: coatingTypeData,
        pipeMaterialData: pipeMaterialData,
        peelTestData: peelTestData,
        reportNumber: reportNumberController.text.toString(),
        digitalPyrometer: digitalPyrometerDetailsController.text.toString(),
        humidityMeter: humidityMeterDetailsController.text.toString(),
        profileGauge: profileGaugeDetailsController.text.toString());
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      onWeldController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      batchNoController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      holidayChecksData = HolidayChecksModel();
      primaryBbatchController.text = "";
      locationController.text = "";
      holidayTestNoController.text = "";
      electrometerNoController.text = "";
      onBodyController.text = "";
      surfaceController.text = "";
      primaryAbatchController.text = "";
      reportNumberController.text = "";
      profileGaugeDetailsController.text = "";
      digitalPyrometerDetailsController.text = "";
      humidityMeterDetailsController.text = "";
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      thicknessData = ThicknessModel();
      pipeDiaData = PipeDiaModel();
      peelTestData = PaddingModel();
      coatingTypeData = CoatingTypeModel();
      pipeMaterialData = PipeMaterialModel();
      visualChecksData = VisualChecksModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddJointCoatingState> emit) {
    emit(FetchAddJointCoatingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      onWeldController: onWeldController,
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
      primaryAbatchController: primaryAbatchController,
      locationController: locationController,
      toJointData: toJointData,
      holidayTestNoController: holidayTestNoController,
      holidayChecksData: holidayChecksData,
      onBodyController: onBodyController,
      holidayCheckList: holidayCheckList,
      electrometerNoController: electrometerNoController,
      primaryBbatchController: primaryBbatchController,
      batchNoController: batchNoController,
      surfaceController: surfaceController,
      pipeDiaData: pipeDiaData,
      pipeDialList: pipeDiaList,
      thicknessData: thicknessData,
      thicknessList: thicknessList,
      peelTestData: peelTestData,
      peelTestList: peelTestList,
      coatingTypeData: coatingTypeData,
      coatingTypeList: coatingTypeList,
      pipeMaterialData: pipeMaterialData,
      pipeMaterialList: pipeMaterialList,
      visualChecksData: visualChecksData,
      visualsChecksList: visualsChecksList,
      reportNumberController: reportNumberController,
      profileGaugeDetailsController: profileGaugeDetailsController,
      digitalPyrometerDetailsController: digitalPyrometerDetailsController,
      humidityMeterDetailsController: humidityMeterDetailsController,
      chainageCtrl: chainageCtrl,
      surfacePreprationData: surfacePreprationData,
      surfacePreprationList: surfacePreprationList,
    ));
  }
}
