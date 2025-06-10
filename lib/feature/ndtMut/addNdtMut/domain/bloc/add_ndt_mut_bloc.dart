import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/helper/add_ndt_mut_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
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

part 'add_ndt_mut_event.dart';
part 'add_ndt_mut_state.dart';

class AddNdtMutBloc extends Bloc<AddNdtMutEvent, AddNdtMutState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController locationDiscoverDefectController =
      TextEditingController();
  TextEditingController typeOfFlawDetectorController = TextEditingController();
  TextEditingController angleOfRayInputController = TextEditingController();
  TextEditingController operatingFrequencyController = TextEditingController();
  TextEditingController leveOfInspectionController = TextEditingController();
  TextEditingController searchPipeController = TextEditingController();

  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  bool isLoader = false;
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<SegmentModel> segmentList = [];
  SegmentModel segmentData = SegmentModel();

  List<SegmentModel> selectedSegmentList = [];

  List<JointNumberModel> jointNumberList = [];
  JointNumberModel jointNumberData = JointNumberModel();

  List<NdtStatusModel> ndtAgencyList = [];
  List<NdtStatusModel> meconPbgplList = [];
  List<NdtStatusModel> dSPPLAgencyList = [];
  NdtStatusModel ndtAgencyData = NdtStatusModel();
  NdtStatusModel meconPbgplData = NdtStatusModel();
  NdtStatusModel dSPPLAgencyData = NdtStatusModel();

  List<PipeModel> _pipeList = [];

  List<PipeModel> get pipeList => _pipeList;

  List<PipeModel> _searchPipeList = [];

  List<PipeModel> get searchPipeList => _searchPipeList;

  bool _searchPipeLoader = false;

  bool get searchPipeLoader => _searchPipeLoader;

  PipeModel _pipeData = PipeModel();

  PipeModel get pipeData => _pipeData;

  AddNdtMutBloc() : super(AddNdtMutInitial()) {
    on<AddNdtMutPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddNdtMutSelectAlignmentEvent>(_selectAlignment);
    on<AddNdtMutSelectJointTypeDataEvent>(_selectJointType);
    on<AddNdtMutSelectJointNumberDataEvent>(_selectJointNumber);
    on<AddNdtMutSelectNdtAgencyDataEvent>(_selectNdtAgency);
    on<AddNdtMutSelectDspplDataEvent>(_selectDsppl);
    on<AddNdtMutSelectMeconPbgplDataEvent>(_selectMeconPbgpl);
    on<AddNdtMutSelectSegmentDataEvent>(_selectSegment);
    on<AddNdtMutSelectDateEvent>(_selectDate);
    on<AddNdtMutAddImageEvent>(_selectFile);
    on<AddNdtMutSearchPipeDataEvent>(_searchPipeNumber);
    on<AddNdtMutSelectPipeDataEvent>(_selectPipe);
    on<AddNdtMutSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddNdtMutPageLoadEvent event, emit) async {
    emit(AddNdtMutPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData = AlignmentModel();
    isLoader = false;
    segmentData = SegmentModel();
    segmentList = [];
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    weatherData = WeatherModel();
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    ndtAgencyList = [];
    meconPbgplList = [];
    dSPPLAgencyList = [];
    _pipeList = [];
    _searchPipeList = [];
    _searchPipeLoader = false;
    ndtAgencyData = NdtStatusModel();
    meconPbgplData = NdtStatusModel();
    dSPPLAgencyData = NdtStatusModel();
    typeOfFlawDetectorController.text = "";
    angleOfRayInputController.text = "";
    operatingFrequencyController.text = "";
    leveOfInspectionController.text = "";
    locationDiscoverDefectController.text = "";
    searchPipeController.text = "";
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context: event.context, userData: userData);
    if (res != null) {
      alignmentList = res;
    }

/*    var resJointType = await AddWeldingHelper.fetchJointType(
        context: event.context, userData: userData);
    if (resJointType != null) {
      jointTypeList = resJointType;
    }*/
    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData,
      type: "afterwelding",
    );
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }


    var resSegment = await AddNdtMutHelper.fetchSegmentData(
        context: !event.context.mounted ? event.context: event.context, userData: userData);
    if (resSegment != null) {
      segmentList = resSegment;
    }

    var resNdtStatus =
        await AddNdtMutHelper.fetchNdtStatusData(context: !event.context.mounted ? event.context: event.context);
    if (resNdtStatus != null) {
      ndtAgencyList = resNdtStatus;
      dSPPLAgencyList = resNdtStatus;
      meconPbgplList = resNdtStatus;
    }

    selectedSegmentList = segmentList;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddNdtMutSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectJointType(AddNdtMutSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);
   /* var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        jointTypeData: jointTypeData);
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }*/
    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectJointNumber(AddNdtMutSelectJointNumberDataEvent event, emit) {
    jointNumberData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectNdtAgency(AddNdtMutSelectNdtAgencyDataEvent event, emit) {
    ndtAgencyData = event.ndtAgencyData;
    _eventComplete(emit);
  }

  _searchPipeNumber(AddNdtMutSearchPipeDataEvent event, emit) async {
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

  _selectPipe(AddNdtMutSelectPipeDataEvent event, emit) {
    _pipeData = event.pipeData;
    _pipeList = [];
    searchPipeController.text =
        "${pipeData.pipeNumber.toString()}|${pipeData.heatNumber.toString()}|${pipeData.pipeLength.toString()}";
    _eventComplete(emit);
  }

  _selectDsppl(AddNdtMutSelectDspplDataEvent event, emit) {
    dSPPLAgencyData = event.dspplData;
    _eventComplete(emit);
  }

  _selectMeconPbgpl(AddNdtMutSelectMeconPbgplDataEvent event, emit) {
    meconPbgplData = event.meconPbgplData;
    _eventComplete(emit);
  }

  _selectSegment(AddNdtMutSelectSegmentDataEvent event, emit) async {
    segmentData = segmentList[event.segmentIndex];
    isLoader = true;
    _eventComplete(emit);

    for (int i = 0;
        i < segmentList[event.segmentIndex].segmentStatusList!.length;
        i++) {
      if (kDebugMode) {
        print("Id ${segmentData.segmentStatusList![i].selectedValue}");
      }
      if (i == event.index) {
        segmentList[event.segmentIndex]
                .segmentStatusList![event.index]
                .selectedValue =
            segmentList[event.segmentIndex]
                .segmentStatusList![event.index]
                .groupType
                .toString();
      } else {
        segmentList[event.segmentIndex].segmentStatusList![i].selectedValue =
            "";
      }
    }

    isLoader = false;
    _eventComplete(emit);
  }

  _selectDate(AddNdtMutSelectDateEvent event, emit) async {
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
      //print("Date is not selected");
    }
  }

  _selectFile(AddNdtMutAddImageEvent event, emit) async {
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
    Navigator.pop(!event.context.mounted ? event.context: event.context);
    _eventComplete(emit);
  }

  _submitData(AddNdtMutSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);

    List<dynamic> segmentDataList = [];
    List<dynamic> segmentStatusDataList = [];
    List<dynamic> segmentObservationDataList = [];
    List<dynamic> segmentRemarkDataList = [];

    for (var segmentDataValue in selectedSegmentList) {
      segmentDataList.add(segmentDataValue.id.toString());
      if (segmentDataValue.observationController!.text.toString().isNotEmpty) {
        segmentObservationDataList
            .add(segmentDataValue.observationController!.text.toString());
        segmentRemarkDataList
            .add(segmentDataValue.remarkController!.text.toString());
        for (var status in segmentDataValue.segmentStatusList!) {
          if (status.selectedValue.toString().isNotEmpty) {
            segmentStatusDataList.add(status.id.toString());
          }
        }
      } else {
        segmentRemarkDataList.add("0");
        segmentObservationDataList.add("0");
        segmentStatusDataList.add("0");
      }
    }

    var res = await AddNdtMutHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        segmentData: segmentDataList,
        segmentObservationData: segmentObservationDataList,
        segmentStatusData: segmentStatusDataList,
        segmentRemarkData: segmentRemarkDataList,
        jointNumberData: jointNumberData,
        dSPPLAgencyData: dSPPLAgencyData,
        ndtAgencyData: ndtAgencyData,
        meconPbgplData: meconPbgplData,
        locationDefect: locationDiscoverDefectController.text.toString(),
        angleOfRayInput: angleOfRayInputController.text.toString(),
        leveOfInspection: leveOfInspectionController.text.toString(),
        operatingFrequency: operatingFrequencyController.text.toString(),
        typeOfFlawDetector: typeOfFlawDetectorController.text.toString(),
        pipeData: pipeData,
        file: file);
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      alignmentData = AlignmentModel();
      isLoader = false;
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      jointNumberData = JointNumberModel();
      selectedSegmentList = segmentList;
      ndtAgencyData = NdtStatusModel();
      meconPbgplData = NdtStatusModel();
      dSPPLAgencyData = NdtStatusModel();
      locationDiscoverDefectController.text = "";
      typeOfFlawDetectorController.text = "";
      angleOfRayInputController.text = "";
      operatingFrequencyController.text = "";
      leveOfInspectionController.text = "";
      _pipeData = PipeModel();
      searchPipeController.text = "";
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddNdtMutState> emit) {
    emit(FetchAddNdtMutDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      reportNumberController: reportNumberController,
      alignmentData: alignmentData,
      file: file,
      weatherList: weatherList,
      weatherData: weatherData,
      jointTypeData: jointTypeData,
      jointTypeList: jointTypeList,
      segmentData: segmentData,
      segmentList: segmentList,
      jointNumberData: jointNumberData,
      jointNumberList: jointNumberList,
      ndtAgencyData: ndtAgencyData,
      ndtAgencyList: ndtAgencyList,
      dSPPLAgencyData: dSPPLAgencyData,
      dSPPLAgencyList: dSPPLAgencyList,
      locationDiscoverDefectController: locationDiscoverDefectController,
      meconPbgplData: meconPbgplData,
      meconPbgplList: meconPbgplList,
      angleOfRayInputController: angleOfRayInputController,
      leveOfInspectionController: leveOfInspectionController,
      operatingFrequencyController: operatingFrequencyController,
      typeOfFlawDetectorController: typeOfFlawDetectorController,
      pipeList: pipeList,
      searchPipeLoader: searchPipeLoader,
      searchPipeController: searchPipeController,
    ));
  }
}
