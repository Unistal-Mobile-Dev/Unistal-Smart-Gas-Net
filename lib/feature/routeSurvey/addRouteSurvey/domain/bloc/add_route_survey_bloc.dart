import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
part 'add_route_survey_event.dart';

part 'add_route_survey_state.dart';

class AddRouteSurveyBloc extends Bloc<AddRouteSurveyEvent, AddRouteSurveyState> {

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData = [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController tpChainageController = TextEditingController();
  TextEditingController tpChainageNumberController = TextEditingController();
  TextEditingController bearingAngleController = TextEditingController();
  TextEditingController terrainController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();

  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController structureController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  LoginDataModel _userData = LoginDataModel();
  LoginDataModel get userData => _userData;

  File file = File("");


  WeatherModel weatherData = WeatherModel();
  List<WeatherModel> weatherList = [];

  List<GroundTypeModel> groundTypeList = [];
  GroundTypeModel groundTypeData = GroundTypeModel();

  Client get _client => AppConfig.instanceInit()!.client ?? Client.vppl;
  bool get _isURJAGATI => _client == Client.urjagati;


  AddRouteSurveyBloc() : super(AddRouteSurveyInitial()) {
    on<AddRouteSurveyPageLoadEvent>(_pageLoadEvent);
    on<AddRouteSurveySubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<CalculateLengthEvent>(_calculateChainage);
    on<AddRouteSurveySelectAlignmentEvent>(_selectAlignment);
    on<AddRouteSurveyMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddRouteSurveySelectGroundTypeEvent>(_selectGroundType);
    on<AddRouteSurveySelectDateEvent>(_selectDate);
    on<AddRouteSurveyAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddRouteSurveyPageLoadEvent event, emit) async {
    emit(AddRouteSurveyPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    tpChainageController.text = "";
    tpChainageNumberController.text = "";
    bearingAngleController.text = "";
    terrainController.text = "";
    activityRemarkController.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    lengthController.text = "";
    structureController = TextEditingController();
    chainageController = TextEditingController();
    detailController = TextEditingController();
    _isLoader = false;
    alignmentList = [];
    file = File("");
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    weatherData = WeatherModel();
    groundTypeList = [];
    groundTypeData = GroundTypeModel();
    _userData = UserInfo.instanceInit()!.userData!;
    if(_isURJAGATI){
      if (await ConnectivityHelper.checkInterNetConnect()) {
        weatherList = await DashboardHelper.fetchWeatherData();
        alignmentList = await AddRouteSurveyHelper.fetchAlignmentData();
        groundTypeList = await AddRouteSurveyHelper.fetchGroundTypeData();
      } else {
        weatherList = HiveDataBase.weatherBox!.values.toList();
        alignmentList = HiveDataBase.alignmentBox!.values.toList();
        groundTypeList = HiveDataBase.groundTypeBox!.values.toList();
        if (event.context.mounted) {
          showDialog(
            context: event.context,
            barrierDismissible: true,
            builder: (_) => const OfflineConnectivityPopWidget(),
          );
        }
      }
    }else{
      weatherList = await DashboardHelper.fetchWeatherData();
      alignmentList = await AddRouteSurveyHelper.fetchAlignmentData();
      groundTypeList = await AddRouteSurveyHelper.fetchGroundTypeData();
    }

    _eventComplete(emit);
  }

  _selectAlignment(AddRouteSurveySelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(
      AddRouteSurveyMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectGroundType(AddRouteSurveySelectGroundTypeEvent event, emit) {
    groundTypeData = event.groundTypeData;
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _calculateChainage(CalculateLengthEvent event, emit) {
    bool isChainageTo = event.isChainageTo;
    String value = event.value;

    if (value.isEmpty) {
      lengthController.text = "";
    } else if (isChainageTo == true &&
        value.isNotEmpty &&
        chainageFromController.text.toString().isNotEmpty) {
      double chainageTo = double.parse(value.toString());
      double chainageFrom =
          double.parse(chainageFromController.text.toString());
      if (chainageTo < chainageFrom) {
        lengthController.text = "";
        SnackBarErrorWidget(event.context).show(
            message:
                "Chainage TO must be greater than or equal to Chainage FROM");
      } else {
        lengthController.text = "${chainageTo - chainageFrom}";
      }
    } else if (isChainageTo == false &&
        value.isNotEmpty &&
        chainageToController.text.toString().isNotEmpty) {
      double chainageTo = double.parse(chainageToController.text.toString());
      double chainageFrom = double.parse(value);
      if (chainageTo < chainageFrom) {
        lengthController.text = "";
        SnackBarErrorWidget(event.context).show(
            message:
                "Chainage TO must be greater than or equal to Chainage FROM");
      } else {
        lengthController.text = "${chainageTo - chainageFrom}";
      }
    }
    _eventComplete(emit);
  }

  _selectDate(AddRouteSurveySelectDateEvent event, emit) async {
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

  _selectFile(AddRouteSurveyAddImageEvent event, emit) async {
    if (event.mediaType == 1) {
      var photo = await MediaPickerHelper.imagePiker(context: event.context);
      if (photo != null) {
        file = photo;
      }
    } else {
      var photo = await MediaPickerHelper.filePiker(context: event.context);
      if (photo != null) {
        file = photo;
      }
    }
    Navigator.pop(!event.context.mounted ? event.context : event.context);
    _eventComplete(emit);
  }

  _submitData(AddRouteSurveySubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    bool done = await RecordHelper.submitRouteSurvey(
      context: event.context,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      tpIpChainage: tpChainageController.text.toString(),
      tpIpNOS: tpChainageNumberController.text.toString(),
      detail: detailController.text.toString(),
      detailStructure: structureController.text.toString(),
      chainage: chainageController.text.toString(),
      bearing: groundTypeData.id == null ? "" : groundTypeData.id.toString(),
      terrain: terrainController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      userData: userData,
      file: file,
      weatherData: weatherData,
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      totalLength: lengthController.text.toString(),
      groundTypeData: groundTypeData,
    );
    _isLoader = false;
    _eventComplete(emit);
    if (done) {
      dateController.text = "";
      reportNumberController.text = "";
      tpChainageController.text = "";
      tpChainageNumberController.text = "";
      bearingAngleController.text = "";
      terrainController.text = "";
      activityRemarkController.text = "";
      chainageFromController.text = "";
      chainageToController.text = "";
      lengthController.text = "";
      _isLoader = false;
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      file = File("");
      weatherData = WeatherModel();
      groundTypeData = GroundTypeModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddRouteSurveyState> emit) {
    emit(FetchAddRouteSurveyDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      bearingAngleController: bearingAngleController,
      reportNumberController: reportNumberController,
      terrainController: terrainController,
      tpChainageController: tpChainageController,
      tpChainageNumberController: tpChainageNumberController,
      chainageController: chainageController,
      detailController: detailController,
      structureController: structureController,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      groundTypeData: groundTypeData,
      groundTypeList: groundTypeList,
      lengthController: lengthController,
    ));
  }
}
