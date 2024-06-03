import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/bending_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/helper/add_bending_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

part 'add_bending_event.dart';
part 'add_bending_state.dart';

class AddBendingBloc extends Bloc<AddBendingEvent, AddBendingState> {
  List<AlignmentModel> _alignmentList = [];

  List<AlignmentModel> get alignmentList => _alignmentList;

  AlignmentModel _alignmentData = AlignmentModel();

  AlignmentModel get alignmentData => _alignmentData;

  bool _isLoader = false;

  bool get isLoader => _isLoader;

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController bendingNumberController = TextEditingController();
  TextEditingController bendAngleTpNumberController = TextEditingController();
  TextEditingController bendAngleDegreeController = TextEditingController();
  TextEditingController bendAngleMinuteController = TextEditingController();
  TextEditingController bendAngleSecondController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageController = TextEditingController();

  List<BendingTypeModel> _bendingTypeList = [];

  List<BendingTypeModel> get bendingTypeList => _bendingTypeList;

  BendingTypeModel _bendingTypeData = BendingTypeModel();

  BendingTypeModel get bendingTypeData => _bendingTypeData;

  List<VisualChecksModel> _visualChecksList = [];

  List<VisualChecksModel> get visualChecksList => _visualChecksList;

  VisualChecksModel _visualChecksData = VisualChecksModel();

  VisualChecksModel get visualChecksData => _visualChecksData;

  List<VisualChecksModel> _gaugingChecksList = [];

  List<VisualChecksModel> get gaugingChecksList => _gaugingChecksList;

  VisualChecksModel _gaugingChecksData = VisualChecksModel();

  VisualChecksModel get gaugingChecksData => _gaugingChecksData;

  List<VisualChecksModel> _disbomdmentChecksList = [];

  List<VisualChecksModel> get disbomdmentChecksList => _disbomdmentChecksList;

  VisualChecksModel _disbomdmentChecksData = VisualChecksModel();

  VisualChecksModel get disbomdmentChecksData => _disbomdmentChecksData;

  List<HolidayChecksModel> _holidayChecksList = [];

  List<HolidayChecksModel> get holidayChecksList => _holidayChecksList;

  HolidayChecksModel _holidayChecksData = HolidayChecksModel();

  HolidayChecksModel get holidayChecksData => _holidayChecksData;

  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController bendNumberController = TextEditingController();

  File file = File("");

  List<PipeModel> _pipeList = [];

  List<PipeModel> get pipeList => _pipeList;

  PipeModel _pipeData = PipeModel();

  PipeModel get pipeData => _pipeData;

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  List<dynamic> _searchPipeList = [];

  List<dynamic> get searchPipeList => _searchPipeList;

  TextEditingController searchPipeController = TextEditingController();

  bool _searchPipeLoader = false;

  bool get searchPipeLoader => _searchPipeLoader;

  AddBendingBloc() : super(AddBendingInitial()) {
    on<AddBendingPageLoadEvent>(_pageLoad);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddBendingSelectAlignmentEvent>(_selectAlignment);
    on<AddBendingSelectDateEvent>(_selectDate);
    on<AddBendingSelectHolidayDataEvent>(_selectHolidayCheck);
    on<AddBendingSelectSelectPipeDataEvent>(_selectPipeData);
    on<AddBendingSelectBendingTypeEvent>(_selectBendingType);
    on<AddBendingSelectGaugingEvent>(_selectGaugingChecks);
    on<AddBendingSelectDisbomdmentEvent>(_selectDisbomdmentChecks);
    on<AddBendingAddSearchPipeDataEvent>(_searchPipeData);
    on<AddBendingSelectVisualDataEvent>(_selectVisualChecks);
    on<AddBendingAddImageEvent>(_selectFile);
    on<AddBendingSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddBendingPageLoadEvent event, emit) async {
    emit(AddBendingPageLoadState());
    _alignmentList = [];
    _alignmentData = AlignmentModel();
    _isLoader = false;
    dateController.text = "";
    reportNumberController.text = "";
    bendingNumberController.text = "";
    bendAngleTpNumberController.text = "";
    bendAngleDegreeController.text = "";
    bendAngleMinuteController.text = "";
    bendAngleSecondController.text = "";
    activityRemarkController.text = "";
    chainageController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    bendNumberController.text = "";
    _bendingTypeList = [];
    _bendingTypeData = BendingTypeModel();
    _visualChecksList = [];
    _visualChecksData = VisualChecksModel();
    _gaugingChecksList = [];
    _gaugingChecksData = VisualChecksModel();
    _disbomdmentChecksList = [];
    _disbomdmentChecksData = VisualChecksModel();
    _holidayChecksList = [];
    _holidayChecksData = HolidayChecksModel();
    file = File("");
    _pipeList = [];
    _pipeData = PipeModel();
    _weatherData = WeatherModel();
    _userData = UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);

    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: event.context, userData: userData);
    if (res != null) {
      _alignmentList = res;
    }

    var resBending = await AddBendingHelper.fetchBendingType(
        context: event.context, userData: userData);
    if (resBending != null) {
      _bendingTypeList = resBending;
    }

    var resHoliday =
        await AddBendingHelper.fetchHolidayData(context: event.context);
    if (resHoliday != null) {
      _holidayChecksList = resHoliday;
    }

    var resVisual =
        await AddBendingHelper.fetchVisualChecks(context: event.context);
    if (resVisual != null) {
      _visualChecksList = resVisual;
    }
    _disbomdmentChecksList = visualChecksList;
    _gaugingChecksList = visualChecksList;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddBendingSelectAlignmentEvent event, emit) {
    _alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddBendingSelectDateEvent event, emit) async {

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

  _selectPipeData(AddBendingSelectSelectPipeDataEvent event, emit) {
    _pipeData = event.pipeData;
    _searchPipeList = [];
    searchPipeController.text = pipeData.pipeNumber.toString();
    _eventComplete(emit);
  }

  _selectHolidayCheck(AddBendingSelectHolidayDataEvent event, emit) {
    _holidayChecksData = event.holidayChecksData;
    _eventComplete(emit);
  }

  _selectVisualChecks(AddBendingSelectVisualDataEvent event, emit) {
    _visualChecksData = event.visualChecksData;
    _eventComplete(emit);
  }

  _selectBendingType(AddBendingSelectBendingTypeEvent event, emit) {
    _bendingTypeData = event.bendingTypeData;
    _eventComplete(emit);
  }

  _selectGaugingChecks(AddBendingSelectGaugingEvent event, emit) {
    _gaugingChecksData = event.gaugingChecksData;
    _eventComplete(emit);
  }

  _selectDisbomdmentChecks(AddBendingSelectDisbomdmentEvent event, emit) {
    _disbomdmentChecksData = event.disbomdmentChecksData;
    _eventComplete(emit);
  }

  _searchPipeData(AddBendingAddSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader = true;
    _eventComplete(emit);
    var resPipe = await AddStringingHelper.fetchPipeData(
        context: event.context,
        userData: userData,
        searchKeyword: event.keyword.toString(),
        type: "bending");
    if (resPipe != null) {
      _pipeList = resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader = false;
    _eventComplete(emit);
  }

  _selectFile(AddBendingAddImageEvent event, emit) async {
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
    Navigator.pop(event.context);
    _eventComplete(emit);
  }

  _submitData(AddBendingSubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddBendingHelper.submitData(
        context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        bendTpNumber: bendAngleTpNumberController.text.toString(),
        bendDegree: bendAngleDegreeController.text.toString(),
        bendMinits: bendAngleMinuteController.text.toString(),
        bendSecond: bendAngleSecondController.text.toString(),
        chainage: chainageController.text.toString(),
        bendingTypeData: bendingTypeData,
        visualChecksData: visualChecksData,
        gaugingCheckData: gaugingChecksData,
        disbomdmentCheckData: disbomdmentChecksData,
        holidayChecksData: holidayChecksData,
        pipeData: pipeData,
        weatherData: weatherData,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        bendNumber: bendNumberController.text.toString(),
        userData: userData,
        file: file);
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      _alignmentData = AlignmentModel();
      _isLoader = false;
      dateController.text = "";
      reportNumberController.text = "";
      bendingNumberController.text = "";
      bendAngleTpNumberController.text = "";
      bendAngleDegreeController.text = "";
      bendAngleMinuteController.text = "";
      bendAngleSecondController.text = "";
      activityRemarkController.text = "";
      chainageController.text = "";
      _bendingTypeData = BendingTypeModel();
      _visualChecksData = VisualChecksModel();
      _gaugingChecksData = VisualChecksModel();
      _disbomdmentChecksData = VisualChecksModel();
      _holidayChecksData = HolidayChecksModel();
      file = File("");
      chainageFromController.text = "";
      chainageToController.text = "";
      bendNumberController.text = "";
      _pipeData = PipeModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddBendingState> emit) {
    emit(FetchAddBendingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      bendAngleMinuteController: bendAngleMinuteController,
      reportNumberController: reportNumberController,
      bendAngleSecondController: bendAngleSecondController,
      bendingNumberController: bendingNumberController,
      bendAngleTpNumberController: bendAngleTpNumberController,
      bendAngleDegreeController: bendAngleDegreeController,
      chainageController: chainageController,
      alignmentData: alignmentData,
      file: file,
      bendingTypeData: bendingTypeData,
      bendingTypeList: bendingTypeList,
      disbomdmentChecksData: disbomdmentChecksData,
      disbomdmentChecksList: disbomdmentChecksList,
      gaugingChecksData: gaugingChecksData,
      gaugingChecksList: gaugingChecksList,
      holidayChecksData: holidayChecksData,
      holidayChecksList: holidayChecksList,
      visualChecksData: visualChecksData,
      visualChecksList: visualChecksList,
      pipeList: pipeList,
      pipeData: pipeData,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      bendNumberController: bendNumberController,
      searchPipeLoader: searchPipeLoader,
      searchPipeList: searchPipeList,
      searchPipeController: searchPipeController,
    ));
  }
}
