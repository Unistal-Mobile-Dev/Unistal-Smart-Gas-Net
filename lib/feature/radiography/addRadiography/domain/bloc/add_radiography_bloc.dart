import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_source_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/domain/model/ndt_status_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ndtMut/addNdtMut/helper/add_ndt_mut_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/domain/model/segment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/radiography/addRadiography/helper/add_radiography_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/welder_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/wps_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_radiography_event.dart';

part 'add_radiography_state.dart';

class AddRadiographyBloc
    extends Bloc<AddRadiographyEvent, AddRadiographyState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController locationDiscoverDefectController =
      TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController filmTypeController = TextEditingController();
  TextEditingController inspectTechniqueController = TextEditingController();
  TextEditingController sensivityController = TextEditingController();
  TextEditingController densityController = TextEditingController();
  TextEditingController equipmentController = TextEditingController();

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

  List<WelderModel> welderList = [];

  List<NdtStatusModel> ndtAgencyList = [];
  List<NdtStatusModel> meconPbgplList = [];
  List<NdtStatusModel> dSPPLAgencyList = [];
  NdtStatusModel ndtAgencyData = NdtStatusModel();
  NdtStatusModel meconPbgplData = NdtStatusModel();
  NdtStatusModel dSPPLAgencyData = NdtStatusModel();

  List<NdtSourceModel> ndtSourceList = [];
  NdtSourceModel ndtSourceData = NdtSourceModel();

  AddRadiographyBloc() : super(AddRadiographyInitial()) {
    on<AddRadiographyPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddRadiographySelectAlignmentEvent>(_selectAlignment);

    on<AddRadiographySelectWelderDataEvent>(_selectRootWelder);
    on<AddRadiographySelectHotPassWelderEvent>(_selectHotPassWelder);
    on<AddRadiographySelectFillerWelderEvent>(_selectFillerWelder);
    on<AddRadiographySelectCappingWelderEvent>(_selectCappingWelder);
    on<AddRadiographySelectNdtAgencyDataEvent>(_selectNdtAgency);
    on<AddRadiographySelectDspplDataEvent>(_selectDsppl);
    on<AddRadiographySelectMeconPbgplDataEvent>(_selectMeconPbgpl);

    on<AddRadiographySelectJointTypeDataEvent>(_selectJointType);
    on<AddRadiographySelectJointNumberDataEvent>(_selectJointNumber);
    on<AddRadiographySelectSegmentDataEvent>(_selectSegment);
    on<AddRadiographySelectDateEvent>(_selectDate);
    on<AddRadiographySelectNdtSourceDataEvent>(_selectNdtSource);
    on<AddRadiographyAddImageEvent>(_selectFile);
    on<AddRadiographySubmitDataEvent>(_submitData);
  }

  _pageLoad(AddRadiographyPageLoadEvent event, emit) async {
    emit(AddRadiographyPageLoadState());
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
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    weatherData = WeatherModel();
    ndtAgencyList = [];
    meconPbgplList = [];
    dSPPLAgencyList = [];
    ndtSourceList = [];
    ndtSourceData = NdtSourceModel();
    ndtAgencyData = NdtStatusModel();
    meconPbgplData = NdtStatusModel();
    dSPPLAgencyData = NdtStatusModel();
    chainageController.text = "";
    filmTypeController.text = "";
    inspectTechniqueController.text = "";
    sensivityController.text = "";
    densityController.text = "";
    equipmentController.text = "";
    locationDiscoverDefectController.text = "";
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

    /*var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData,
        jointTypeData: jointTypeData,
      type: "afterwelding"
    );
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }*/


    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context, userData: userData, type: "afterwelding"
        //  jointTypeData: jointTypeData
        );
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }

    var resWelder = await AddWeldingHelper.fetchWelderData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData,
        wpsData: WPSModel());
    if (resWelder != null) {
      welderList = resWelder;
    }

    var resSegment = await AddRadiographyHelper.fetchSegmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData,
        welderList: welderList);
    if (resSegment != null) {
      segmentList = resSegment;
    }

    var resNdtStatus = await AddNdtMutHelper.fetchNdtStatusData(
        context: !event.context.mounted ? event.context : event.context);
    if (resNdtStatus != null) {
      ndtAgencyList = resNdtStatus;
      dSPPLAgencyList = resNdtStatus;
      meconPbgplList = resNdtStatus;
    }

    var resNdtSource = await AddNdtMutHelper.fetchNdtSourceData(
        context: !event.context.mounted ? event.context : event.context);
    if (resNdtSource != null) {
      ndtSourceList = resNdtSource;
    }

    selectedSegmentList = segmentList;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddRadiographySelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectRootWelder(AddRadiographySelectWelderDataEvent event, emit) {
    isLoader = true;
    _eventComplete(emit);
    segmentList[event.index].segmentWelderList![event.welderIndex].welderData =
        event.welderData;
    isLoader = false;
    _eventComplete(emit);
  }

  _selectHotPassWelder(AddRadiographySelectHotPassWelderEvent event, emit) {
    isLoader = true;
    _eventComplete(emit);
    segmentList[event.index].hootPassWelderData = event.welderData;
    isLoader = false;
    _eventComplete(emit);
  }

  _selectFillerWelder(AddRadiographySelectFillerWelderEvent event, emit) {
    isLoader = true;
    _eventComplete(emit);
    segmentList[event.index].fillerWelderData = event.welderData;
    isLoader = false;
    _eventComplete(emit);
  }

  _selectCappingWelder(AddRadiographySelectCappingWelderEvent event, emit) {
    isLoader = true;
    _eventComplete(emit);
    segmentList[event.index].cappingWelderData = event.welderData;
    isLoader = false;
    _eventComplete(emit);
  }

  _selectJointType(AddRadiographySelectJointTypeDataEvent event, emit) async {
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

  _selectJointNumber(AddRadiographySelectJointNumberDataEvent event, emit) {
    jointNumberData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectNdtAgency(AddRadiographySelectNdtAgencyDataEvent event, emit) {
    ndtAgencyData = event.ndtAgencyData;
    _eventComplete(emit);
  }

  _selectDsppl(AddRadiographySelectDspplDataEvent event, emit) {
    dSPPLAgencyData = event.dspplData;
    _eventComplete(emit);
  }

  _selectMeconPbgpl(AddRadiographySelectMeconPbgplDataEvent event, emit) {
    meconPbgplData = event.meconPbgplData;
    _eventComplete(emit);
  }

  _selectSegment(AddRadiographySelectSegmentDataEvent event, emit) async {
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

  _selectDate(AddRadiographySelectDateEvent event, emit) async {
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

  _selectNdtSource(AddRadiographySelectNdtSourceDataEvent event, emit) {
    ndtSourceData = event.ndtSourceData;
    _eventComplete(emit);
  }

  _selectFile(AddRadiographyAddImageEvent event, emit) async {
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

  _submitData(AddRadiographySubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);

    var res = await AddRadiographyHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        selectedSegmentList: selectedSegmentList,
        jointNumberData: jointNumberData,
        ndtAgencyData: ndtAgencyData,
        dSPPLAgencyData: dSPPLAgencyData,
        meconPbgplData: meconPbgplData,
        locationDefect: locationDiscoverDefectController.text.toString(),
        ndtSourceData: ndtSourceData,
        chainage: chainageController.text.toString(),
        density: densityController.text.toString(),
        equipment: equipmentController.text.toString(),
        filmType: filmTypeController.text.toString(),
        inspectTechnique: inspectTechniqueController.text.toString(),
        sensivity: sensivityController.text.toString(),
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
      selectedSegmentList = segmentList;
      ndtAgencyData = NdtStatusModel();
      meconPbgplData = NdtStatusModel();
      dSPPLAgencyData = NdtStatusModel();
      ndtSourceData = NdtSourceModel();
      locationDiscoverDefectController.text = "";
      chainageController.text = "";
      filmTypeController.text = "";
      inspectTechniqueController.text = "";
      sensivityController.text = "";
      densityController.text = "";
      equipmentController.text = "";
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddRadiographyState> emit) {
    emit(FetchAddRadiographyDataState(
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
      jointNumberList: jointNumberList,
      jointNumberData: jointNumberData,
      ndtAgencyData: ndtAgencyData,
      ndtAgencyList: ndtAgencyList,
      dSPPLAgencyData: dSPPLAgencyData,
      dSPPLAgencyList: dSPPLAgencyList,
      locationDiscoverDefectController: locationDiscoverDefectController,
      meconPbgplData: meconPbgplData,
      meconPbgplList: meconPbgplList,
      ndtSourceData: ndtSourceData,
      ndtSourceList: ndtSourceList,
      chainageController: chainageController,
      densityController: densityController,
      equipmentController: equipmentController,
      filmTypeController: filmTypeController,
      inspectTechniqueController: inspectTechniqueController,
      sensivityController: sensivityController,
    ));
  }
}
