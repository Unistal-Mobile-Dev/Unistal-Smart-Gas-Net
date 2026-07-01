import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/model/crossing_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/helper/add_crossing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_crossing_event.dart';
part 'add_crossing_state.dart';

class AddCrossingBloc extends Bloc<AddCrossingEvent, AddCrossingState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController onBodyController = TextEditingController();
  TextEditingController onWeldController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController sectionLengthController = TextEditingController();
  TextEditingController casingPipeLengthController = TextEditingController();
  TextEditingController concreteCoatingLengthController =
      TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController holidayTestNoController = TextEditingController();
  TextEditingController crossingNameController = TextEditingController();
  TextEditingController electrometerNoController = TextEditingController();
  TextEditingController batchNoController = TextEditingController();
  TextEditingController surfaceController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();

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
  File fileStageInspection = File("");
  File filePreHydrotest = File("");
  File fileRestoration = File("");
  File filePhotoBefore = File("");
  File filePhotoAfter = File("");
  File fileVideoBefore = File("");
  File fileVideoAfter = File("");

  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();
  LoginDataModel get userData => _userData;

  List<ThicknessModel> thicknessList = [];
  ThicknessModel thicknessData = ThicknessModel();

  List<PipeDiaModel> pipeDiaList = [];
  PipeDiaModel pipeDiaData = PipeDiaModel();

  List<CoatingTypeModel> coatingTypeList = [];
  CoatingTypeModel coatingTypeData = CoatingTypeModel();

  List<PaddingModel> prePaddingList = [];
  PaddingModel prePaddingData = PaddingModel();

  List<PaddingModel> postPaddingList = [];
  PaddingModel postPaddingData = PaddingModel();

  List<PipeMaterialModel> pipeMaterialList = [];
  PipeMaterialModel pipeMaterialData = PipeMaterialModel();

  List<VisualChecksModel> visualsChecksList = [];
  VisualChecksModel visualChecksData = VisualChecksModel();

  List<CrossingTypeModel> crossingTypeList = [];
  CrossingTypeModel crossingTypeData = CrossingTypeModel();

  AddCrossingBloc() : super(AddCrossingInitial()) {
    on<AddCrossingPageLoadEvent>(_pageLoader);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddCrossingSelectAlignmentEvent>(_selectAlignment);
    on<AddCrossingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddCrossingSelectCoatingTypeDataEvent>(_selectCoatingType);
    on<AddCrossingSelectPipeMaterialDataEvent>(_selectPipeMaterial);
    on<AddCrossingSelectCrossingTypeDataEvent>(_selectCrossingType);
    on<AddCrossingSelectVisualChecksDataEvent>(_selectVisualCheck);
    on<AddCrossingSelectPrePaddingDataEvent>(_selectPrePadding);
    on<AddCrossingSelectPostPaddingDataEvent>(_selectPostPadding);
    on<AddCrossingSelectHolidayDataEvent>(_selectHolidayData);
    on<AddCrossingSelectFromJointDataEvent>(_selectJointFrom);
    on<AddCrossingSelectToJointDataEvent>(_selectJointTo);
    on<AddCrossingSelectJointTypeDataEvent>(_selectJointType);
    on<AddCrossingSelectDateEvent>(_selectDate);
    on<AddCrossingSelectPipeDiaDataEvent>(_selectPipeDia);
    on<AddCrossingSelectThicknessDataEvent>(_selectThickness);
    on<AddCrossingCalibarationDataEvent>(_selectCabilabrationData);
    on<AddCrossingAddImageEvent>(_selectFile);
    on<AddCrossingStageInspectionEvent>(_selectStageInspection);
    on<AddCrossingPreHydrotestEvent>(_selectPreHydrotest);
    on<AddCrossingRestorationEvent>(_selectRestoration);
    on<AddCrossingPhotoBeforeEvent>(_selectPhotoBefore);
    on<AddCrossingPhotoAfterEvent>(_selectPhotoAfter);
    on<AddCrossingVideoBeforeEvent>(_selectVideoBefore);
    on<AddCrossingVideoAfterEvent>(_selectVideoAfter);
    on<AddCrossingSubmitDataEvent>(_submitData);
  }

  _pageLoader(AddCrossingPageLoadEvent event, emit) async {
    emit(AddCrossingPageLoadState());
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
    holidayCheckList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    crossingTypeList = [];
    crossingTypeData = CrossingTypeModel();
    isLoader = false;
    holidayChecksData = HolidayChecksModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    fileStageInspection = File("");
    filePreHydrotest = File("");
    fileRestoration = File("");
    filePhotoBefore = File("");
    filePhotoAfter = File("");
    fileVideoBefore = File("");
    fileVideoAfter = File("");
    thicknessList = [];
    thicknessData = ThicknessModel();
    pipeDiaData = PipeDiaModel();
    pipeDiaList = [];
    prePaddingData = PaddingModel();
    prePaddingList = [];
    postPaddingList = [];
    postPaddingData = PaddingModel();
    coatingTypeList = [];
    coatingTypeData = CoatingTypeModel();
    weatherData = WeatherModel();
    pipeMaterialList = [];
    pipeMaterialData = PipeMaterialModel();
    visualsChecksList = [];
    visualChecksData = VisualChecksModel();
    crossingTypeList = [];
    crossingTypeData = CrossingTypeModel();
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
        context: !event.context.mounted ? event.context : event.context,
        userData: userData,
      type:  AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
          ? AppConfig.instanceInit()!.activitySectionData.appJoint!
          : "afterwelding",
    );
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }

    var resHoliday = await AddBendingHelper.fetchHolidayData(
        context: !event.context.mounted ? event.context : event.context);
    if (resHoliday != null) {
      holidayCheckList = resHoliday;
    }

    var visualsChecksRes = await AddBendingHelper.fetchVisualChecks(
        context: !event.context.mounted ? event.context : event.context);
    if (visualsChecksRes != null) {
      visualsChecksList = visualsChecksRes;
    }

    var resCrossingType = await AddCrossingHelper.fetchCrossingData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (resCrossingType != null) {
      crossingTypeList = resCrossingType;
    }

    var prePaddingRes = await AddHDPEDuctHelper.fetchPaddingData(
        context: !event.context.mounted ? event.context : event.context);
    if (prePaddingRes != null) {
      prePaddingList = prePaddingRes;
      postPaddingList = prePaddingRes;
    }

    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddCrossingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddCrossingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }


  _selectCoatingType(AddCrossingSelectCoatingTypeDataEvent event, emit) {
    coatingTypeData = event.coatingTypeData;
    _eventComplete(emit);
  }

  _selectPipeMaterial(AddCrossingSelectPipeMaterialDataEvent event, emit) {
    pipeMaterialData = event.pipeMaterialData;
    _eventComplete(emit);
  }

  _selectCrossingType(AddCrossingSelectCrossingTypeDataEvent event, emit) {
    crossingTypeData = event.crossingTypeData;
    _eventComplete(emit);
  }

  _selectVisualCheck(AddCrossingSelectVisualChecksDataEvent event, emit) {
    visualChecksData = event.visualChecksData;
    _eventComplete(emit);
  }

  _selectPrePadding(AddCrossingSelectPrePaddingDataEvent event, emit) {
    prePaddingData = event.prePaddingData;
    _eventComplete(emit);
  }

  _selectPostPadding(AddCrossingSelectPostPaddingDataEvent event, emit) {
    postPaddingData = event.postPaddingData;
    _eventComplete(emit);
  }

  _selectHolidayData(AddCrossingSelectHolidayDataEvent event, emit) {
    holidayChecksData = event.holidayChecksData;
    _eventComplete(emit);
  }

  _selectJointFrom(AddCrossingSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointTo(AddCrossingSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectJointType(AddCrossingSelectJointTypeDataEvent event, emit) async {
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

  _selectDate(AddCrossingSelectDateEvent event, emit) async {
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

  _selectPipeDia(AddCrossingSelectPipeDiaDataEvent event, emit) {
    pipeDiaData = event.pipeDiaData;
    _eventComplete(emit);
  }

  _selectThickness(AddCrossingSelectThicknessDataEvent event, emit) {
    thicknessData = event.thicknessData;
    _eventComplete(emit);
  }

  _selectCabilabrationData(AddCrossingCalibarationDataEvent event, emit) async {
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

  _selectFile(AddCrossingAddImageEvent event, emit) async {
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

 _selectStageInspection(AddCrossingStageInspectionEvent event, emit) async {
   if (event.mediaType == 1) {
     var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
     if (photo != null) {
       fileStageInspection = photo;
     }
   } else {
     var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
     if (photo != null) {
       fileStageInspection = photo;
     }
   }
   Navigator.pop(!event.context.mounted ? event.context : event.context);
   _eventComplete(emit);
  }

 _selectPreHydrotest(AddCrossingPreHydrotestEvent event, emit) async {
   if (event.mediaType == 1) {
     var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
     if (photo != null) {
       filePreHydrotest = photo;
     }
   } else {
     var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
     if (photo != null) {
       filePreHydrotest = photo;
     }
   }
   Navigator.pop(!event.context.mounted ? event.context : event.context);
   _eventComplete(emit);
  }

 _selectRestoration(AddCrossingRestorationEvent event, emit) async {
   if (event.mediaType == 1) {
     var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
     if (photo != null) {
       fileRestoration = photo;
     }
   } else {
     var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
     if (photo != null) {
       fileRestoration = photo;
     }
   }
   Navigator.pop(!event.context.mounted ? event.context : event.context);
   _eventComplete(emit);
  }

 _selectPhotoBefore(AddCrossingPhotoBeforeEvent event, emit) async {
   if (event.mediaType == 1) {
     var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
     if (photo != null) {
       filePhotoBefore = photo;
     }
   } else {
     var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
     if (photo != null) {
       filePhotoBefore = photo;
     }
   }
   Navigator.pop(!event.context.mounted ? event.context : event.context);
   _eventComplete(emit);
  }

 _selectPhotoAfter(AddCrossingPhotoAfterEvent event, emit) async {
   if (event.mediaType == 1) {
     var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
     if (photo != null) {
       filePhotoAfter = photo;
     }
   } else {
     var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
     if (photo != null) {
       filePhotoAfter = photo;
     }
   }
   Navigator.pop(!event.context.mounted ? event.context : event.context);
   _eventComplete(emit);
  }

 _selectVideoBefore(AddCrossingVideoBeforeEvent event, emit) async {
   if (event.mediaType == 1) {
     var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
     if (photo != null) {
       fileVideoBefore = photo;
     }
   } else {
     var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
     if (photo != null) {
       fileVideoBefore = photo;
     }
   }
   Navigator.pop(!event.context.mounted ? event.context : event.context);
   _eventComplete(emit);
  }

 _selectVideoAfter(AddCrossingVideoAfterEvent event, emit) async {
   if (event.mediaType == 1) {
     var photo = await AddRouteSurveyHelper.imagePiker(context: event.context);
     if (photo != null) {
       fileVideoAfter = photo;
     }
   } else {
     var photo = await AddRouteSurveyHelper.filePiker(context: event.context);
     if (photo != null) {
       fileVideoAfter = photo;
     }
   }
   Navigator.pop(!event.context.mounted ? event.context : event.context);
   _eventComplete(emit);
  }

  _submitData(AddCrossingSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddCrossingHelper.submitData(
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
      sectionLength: sectionLengthController.text.toString(),
      casingPipeLength: casingPipeLengthController.text.toString(),
      batchNo: batchNoController.text.toString(),
      file: file,
      fileVideoBefore: fileVideoBefore,
      fileVideoAfter: fileVideoAfter,
      fileStageInspection: fileStageInspection,
      fileRestoration: fileRestoration,
      filePreHydrotest: filePreHydrotest,
      filePhotoBefore: filePhotoBefore,
      filePhotoAfter: filePhotoAfter,
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
      crossingTypeData: crossingTypeData,
      reportNumber: reportNumberController.text.toString(),
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      onWeldController.text = "";
      activityRemarkController.text = "";
      sectionLengthController.text = "";
      casingPipeLengthController.text = "";
      batchNoController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      holidayChecksData = HolidayChecksModel();
      crossingNameController.text = "";
      locationController.text = "";
      holidayTestNoController.text = "";
      electrometerNoController.text = "";
      onBodyController.text = "";
      surfaceController.text = "";
      concreteCoatingLengthController.text = "";
      reportNumberController.text = "";
      fromJointData = JointNumberModel();
      toJointData = JointNumberModel();
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      fileStageInspection = File("");
      filePreHydrotest = File("");
      fileRestoration = File("");
      filePhotoBefore = File("");
      filePhotoAfter = File("");
      fileVideoBefore = File("");
      fileVideoAfter = File("");
      weatherData = WeatherModel();
      thicknessData = ThicknessModel();
      pipeDiaData = PipeDiaModel();
      prePaddingData = PaddingModel();
      coatingTypeData = CoatingTypeModel();
      pipeMaterialData = PipeMaterialModel();
      visualChecksData = VisualChecksModel();
      crossingTypeData = CrossingTypeModel();
      PaddingModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddCrossingState> emit) {
    emit(FetchAddCrossingDataState(
        isLoader: isLoader,
        alignmentList: alignmentList,
        dateController: dateController,
        activityRemarkController: activityRemarkController,
        onWeldController: onWeldController,
        sectionLengthController: sectionLengthController,
        casingPipeLengthController: casingPipeLengthController,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        file: file,
        filePhotoAfter: filePhotoAfter,
        filePhotoBefore: filePhotoBefore,
        filePreHydrotest: filePreHydrotest,
        fileRestoration: fileRestoration,
        fileStageInspection: fileStageInspection,
        fileVideoAfter: fileVideoAfter,
        fileVideoBefore: fileVideoBefore,
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
        crossingTypeData: crossingTypeData,
        crossingTyeList: crossingTypeList,
        postPaddingData: postPaddingData,
        reportNumberController: reportNumberController,
        postPaddingList: postPaddingList));
  }
}
