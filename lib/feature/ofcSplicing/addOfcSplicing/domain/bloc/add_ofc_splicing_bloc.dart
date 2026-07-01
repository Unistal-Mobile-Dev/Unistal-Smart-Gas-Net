import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/ofcSplicing/addOfcSplicing/helper/add_ofc_splicing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_ofc_splicing_event.dart';
part 'add_ofc_splicing_state.dart';

class AddOfcSplicingBloc
    extends Bloc<AddOfcSplicingEvent, AddOfcSplicingState> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController jointPitController = TextEditingController();
  TextEditingController srNumberSplicingMachineController =
      TextEditingController();
  TextEditingController makeModelMachineController = TextEditingController();
  TextEditingController ofcDrumNoPlusDirectionController =
      TextEditingController();
  TextEditingController ofcDrumNoMinusDirectionController =
      TextEditingController();
  TextEditingController cableReadingPlusDirectionController =
      TextEditingController();
  TextEditingController cableReadingMinusDirectionController =
      TextEditingController();

  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  bool isLoader = false;
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();

  List<JointNumberModel> jointNumberList = [];
  JointNumberModel jointNumberData = JointNumberModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  AddOfcSplicingBloc() : super(AddOfcSplicingInitial()) {
    on<AddOfcSplicingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddOfcSplicingSelectAlignmentEvent>(_selectAlignment);
    on<AddOfcSplicingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddOfcSplicingSelectJointTypeDataEvent>(_selectJointType);
    on<AddOfcSplicingSelectJointNumberDataEvent>(_selectJointNumber);
    on<AddOfcSplicingSelectDateEvent>(_selectDate);
    on<AddOfcSplicingAddImageEvent>(_selectFile);
    on<AddOfcSplicingSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddOfcSplicingPageLoadEvent event, emit) async {
    emit(AddOfcSplicingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    jointPitController.text = "";
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    isLoader = false;
    jointTypeData = JointTypeModel();
    isJointNumberLoader = false;
    file = File("");
    weatherData = WeatherModel();
    srNumberSplicingMachineController.text = "";
    makeModelMachineController.text = "";
    ofcDrumNoPlusDirectionController.text = "";
    ofcDrumNoMinusDirectionController.text = "";
    cableReadingPlusDirectionController.text = "";
    cableReadingMinusDirectionController.text = "";
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    _userData = UserInfo.instanceInit()!.userData!;
    weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }

    var resJointNumber = await AddWeldingHelper.fetchJointNumberData(
        context: event.context,
        userData: userData,
        type: AppConfig.instanceInit()!.activitySectionData.appJoint?.trim().isNotEmpty == true
            ? AppConfig.instanceInit()!.activitySectionData.appJoint!
            : "afterwelding"
    );
    if (resJointNumber != null) {
      jointNumberList = resJointNumber;
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddOfcSplicingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddOfcSplicingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }



  _selectJointType(AddOfcSplicingSelectJointTypeDataEvent event, emit) async {
    jointTypeData = event.jointTypeData;
    jointNumberList = [];
    jointNumberData = JointNumberModel();
    isJointNumberLoader = true;
    _eventComplete(emit);

    isJointNumberLoader = false;
    _eventComplete(emit);
  }

  _selectJointNumber(
      AddOfcSplicingSelectJointNumberDataEvent event, emit) async {
    jointNumberData = event.jointNumberData;
    _eventComplete(emit);
  }

  _selectDate(AddOfcSplicingSelectDateEvent event, emit) async {
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

  _selectFile(AddOfcSplicingAddImageEvent event, emit) async {
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

  _submitData(AddOfcSplicingSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);
    var res = await AddOfcSplicingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        multipleAlignmentData: multipleAlignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        weatherData: weatherData,
        userData: userData,
        jointTypeData: jointTypeData,
        jointNumberData: jointNumberData,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        jointPit: jointPitController.text.toString(),
        cableReadingMinusDirection:
            cableReadingMinusDirectionController.text.toString(),
        cableReadingPlusDirection:
            cableReadingPlusDirectionController.text.toString(),
        ofcDrumNoMinusDirection:
            ofcDrumNoMinusDirectionController.text.toString(),
        ofcDrumNoPlusDirection:
            ofcDrumNoPlusDirectionController.text.toString(),
        srNumberSplicingMachine:
            srNumberSplicingMachineController.text.toString(),
        makeModelMachine: makeModelMachineController.text.toString(),
        file: file);
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController.text = "";
      reportNumberController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      jointPitController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      isLoader = false;
      jointTypeData = JointTypeModel();
      isJointNumberLoader = false;
      file = File("");
      weatherData = WeatherModel();
      srNumberSplicingMachineController.text = "";
      makeModelMachineController.text = "";
      ofcDrumNoPlusDirectionController.text = "";
      ofcDrumNoMinusDirectionController.text = "";
      cableReadingPlusDirectionController.text = "";
      cableReadingMinusDirectionController.text = "";
      jointNumberData = JointNumberModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddOfcSplicingState> emit) {
    emit(FetchAddOfcSplicingDataState(
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
      jointPitController: jointPitController,
      cableReadingMinusDirectionController:
          cableReadingMinusDirectionController,
      cableReadingPlusDirectionController: cableReadingPlusDirectionController,
      makeModelMachineController: makeModelMachineController,
      ofcDrumNoMinusDirectionController: ofcDrumNoMinusDirectionController,
      ofcDrumNoPlusDirectionController: ofcDrumNoPlusDirectionController,
      srNumberSplicingMachineController: srNumberSplicingMachineController,
      jointNumberData: jointNumberData,
      jointNumberList: jointNumberList,
    ));
  }
}
