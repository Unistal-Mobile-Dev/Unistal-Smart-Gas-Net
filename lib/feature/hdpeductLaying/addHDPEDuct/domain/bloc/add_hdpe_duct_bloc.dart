import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/helper/add_welding_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_hdpe_duct_event.dart';
part 'add_hdpe_duct_state.dart';

class AddHdpeDuctBloc extends Bloc<AddHdpeDuctEvent, AddHdpeDuctState> {
  // Controllers are created ONCE here and reused for the bloc's lifetime.
  // They are cleared (not recreated) on load/submit and disposed in close().
  final TextEditingController dateController = TextEditingController();
  final TextEditingController reportNumberController = TextEditingController();
  final TextEditingController activityRemarkController = TextEditingController();
  final TextEditingController chainageFromController = TextEditingController();
  final TextEditingController chainageToController = TextEditingController();
  final TextEditingController jointPitController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController coilNumberController = TextEditingController();
  final TextEditingController ductLengthFromController = TextEditingController();
  final TextEditingController ductLengthToController = TextEditingController();

  List<PaddingModel> warningMeterList = [];
  List<JointNumberModel> jointFromList = [];
  List<JointNumberModel> jointToList = [];
  List<JointTypeModel> jointTypeList = [];
  List<WeatherModel> weatherList = [];
  List<PaddingModel> paddingList = [];

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData = [];

  bool isLoader = false;
  PaddingModel warningMeterData = PaddingModel();
  JointNumberModel fromJointData = JointNumberModel();
  JointNumberModel toJointData = JointNumberModel();
  JointTypeModel jointTypeData = JointTypeModel();
  bool isJointNumberLoader = false;
  File file = File("");
  WeatherModel weatherData = WeatherModel();
  PaddingModel paddingData = PaddingModel();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  AddHdpeDuctBloc() : super(AddHdpeDuctInitial()) {
    on<AddHdpeDuctPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddHdpeDuctSelectAlignmentEvent>(_selectAlignment);
    on<AddHdpeDuctMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddHdpeDuctSelectPaddingDataEvent>(_selectPaddingData);
    on<AddHdpeDuctSelectFromJointDataEvent>(_selectJointFrom);
    on<AddHdpeDuctSelectToJointDataEvent>(_selectJointTo);
    on<AddHdpeDuctSelectJointTypeDataEvent>(_selectJointType);
    on<AddHdpeDuctSelectWarningMeterDataEvent>(_selectWarningData);
    on<AddHdpeDuctSelectDateEvent>(_selectDate);
    on<AddHdpeDuctAddImageEvent>(_selectFile);
    on<AddHdpeDuctSubmitDataEvent>(_submitData);
  }

  /// Resets all form fields and selections back to their default state
  /// WITHOUT recreating controllers (clearing avoids leaks and focus bugs).
  void _resetForm() {
    dateController.clear();
    reportNumberController.clear();
    activityRemarkController.clear();
    chainageFromController.clear();
    chainageToController.clear();
    jointPitController.clear();
    lengthController.clear();
    coilNumberController.clear();
    ductLengthFromController.clear();
    ductLengthToController.clear();

    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    warningMeterData = PaddingModel();
    fromJointData = JointNumberModel();
    toJointData = JointNumberModel();
    jointTypeData = JointTypeModel();
    weatherData = WeatherModel();
    paddingData = PaddingModel();
    file = File("");
    isJointNumberLoader = false;
    isLoader = false;
  }

  Future<void> _pageLoad(AddHdpeDuctPageLoadEvent event, emit) async {
    emit(AddHdpeDuctPageLoadState());

    // Reset everything to a clean state.
    _resetForm();
    warningMeterList = [];
    jointFromList = [];
    jointToList = [];
    jointTypeList = [];
    weatherList = [];
    alignmentList = [];
    paddingList = [];

    _userData = UserInfo.instanceInit()!.userData!;

    final jointType = AppConfig.instanceInit()!
        .activitySectionData
        .appJoint
        ?.trim()
        .isNotEmpty ==
        true
        ? AppConfig.instanceInit()!.activitySectionData.appJoint!
        : "afterwelding";

    // Run all independent network calls in parallel instead of sequentially.
    // Load time drops from (sum of all calls) to (slowest single call).
    final results = await Future.wait([
      DashboardHelper.fetchWeatherData(
          context: event.context, userData: userData),
      AddRouteSurveyHelper.fetchAlignmentData(
          context: event.context, userData: userData),
      AddWeldingHelper.fetchJointNumberData(
          context: event.context, userData: userData, type: jointType),
      AddHDPEDuctHelper.fetchPaddingData(context: event.context),
    ]);

    // Guard against the page being closed while the requests were in flight.
    if (isClosed) return;

    weatherList = (results[0] as List<WeatherModel>?) ?? [];

    final resAlignment = results[1] as List<AlignmentModel>?;
    if (resAlignment != null) {
      alignmentList = resAlignment;
    }

    final resJointNumber = results[2] as List<JointNumberModel>?;
    if (resJointNumber != null) {
      jointFromList = resJointNumber;
      jointToList = jointFromList;
    }

    final resPadding = results[3] as List<PaddingModel>?;
    if (resPadding != null) {
      paddingList = resPadding;
      warningMeterList = paddingList;
    }

    _eventComplete(emit);
  }

  void _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  void _selectAlignment(AddHdpeDuctSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  void _selectMultipleAlignment(
      AddHdpeDuctMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  void _selectPaddingData(AddHdpeDuctSelectPaddingDataEvent event, emit) {
    paddingData = event.paddingData;
    _eventComplete(emit);
  }

  void _selectJointFrom(AddHdpeDuctSelectFromJointDataEvent event, emit) {
    fromJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  void _selectJointTo(AddHdpeDuctSelectToJointDataEvent event, emit) {
    toJointData = event.jointNumberData;
    _eventComplete(emit);
  }

  void _selectWarningData(AddHdpeDuctSelectWarningMeterDataEvent event, emit) {
    warningMeterData = event.warningMeterData;
    _eventComplete(emit);
  }

  Future<void> _selectJointType(
      AddHdpeDuctSelectJointTypeDataEvent event, emit) async {
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

  Future<void> _selectDate(AddHdpeDuctSelectDateEvent event, emit) async {
    final DateTime? pickedDate = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      _eventComplete(emit);
    } else if (kDebugMode) {
      print("Date is not selected");
    }
  }

  Future<void> _selectFile(AddHdpeDuctAddImageEvent event, emit) async {
    if (event.mediaType == 1) {
      final photo =
      await AddRouteSurveyHelper.imagePiker(context: event.context);
      if (photo != null) file = photo;
    } else {
      final photo =
      await AddRouteSurveyHelper.filePiker(context: event.context);
      if (photo != null) file = photo;
    }

    // Real mounted check: bail out if the context is gone after the await.
    if (!event.context.mounted) return;
    Navigator.pop(event.context);
    if (isClosed) return;
    _eventComplete(emit);
  }

  Future<void> _submitData(AddHdpeDuctSubmitDataEvent event, emit) async {
    isLoader = true;
    _eventComplete(emit);

    final res = await AddHDPEDuctHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      warningMeterData: warningMeterData,
      activityRemark: activityRemarkController.text.toString(),
      weatherData: weatherData,
      userData: userData,
      fromJointData: fromJointData,
      toJointData: toJointData,
      jointTypeData: jointTypeData,
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      jointPit: jointPitController.text.toString(),
      paddingData: paddingData,
      length: lengthController.text.toString(),
      coilNumber: coilNumberController.text.toString(),
      ductLengthFrom: ductLengthFromController.text.toString(),
      ductLengthTo: ductLengthToController.text.toString(),
      file: file,
    );

    if (isClosed) return;

    isLoader = false;
    _eventComplete(emit);

    if (res != null) {
      // Clear the form on success (controllers are reused, not recreated).
      _resetForm();
      _eventComplete(emit);
    }
  }

  void _eventComplete(Emitter<AddHdpeDuctState> emit) {
    if (isClosed) return;
    emit(FetchAddHdpeDuctDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      reportNumberController: reportNumberController,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      coilNumberController: coilNumberController,
      ductLengthFromController: ductLengthFromController,
      ductLengthToController: ductLengthToController,
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
      warningMeterData: warningMeterData,
      warningMeterList: warningMeterList,
      jointPitController: jointPitController,
      lengthController: lengthController,
      toJointData: toJointData,
      paddingList: paddingList,
      paddingData: paddingData,
    ));
  }

  @override
  Future<void> close() {
    dateController.dispose();
    reportNumberController.dispose();
    activityRemarkController.dispose();
    chainageFromController.dispose();
    chainageToController.dispose();
    jointPitController.dispose();
    lengthController.dispose();
    coilNumberController.dispose();
    ductLengthFromController.dispose();
    ductLengthToController.dispose();
    return super.close();
  }
}
