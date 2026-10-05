import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

part 'add_clearing_grading_event.dart';
part 'add_clearing_grading_state.dart';

class AddClearingGradingBloc
    extends Bloc<AddClearingGradingEvent, AddClearingGradingState> {
  bool _isLoader = false;

  bool get isLoader => _isLoader;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController tpChainageController = TextEditingController();
  TextEditingController tpChainageNumberController = TextEditingController();
  TextEditingController tpRemarkNumberController = TextEditingController();
  TextEditingController structureNameController = TextEditingController();
  TextEditingController boundaryLocation = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController groundTypeController = TextEditingController();
  TextEditingController boundaryLocationController = TextEditingController();
  TextEditingController ipNumberController = TextEditingController();
  TextEditingController ipNumberFromController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController chainageController = TextEditingController();
  TextEditingController gapLengthController = TextEditingController();
  TextEditingController gapDescriptionController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController machineyController = TextEditingController();
  TextEditingController manpowerController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  File file = File("");

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  List<GroundTypeModel> groundTypeList = [];
  GroundTypeModel groundTypeData = GroundTypeModel();

  List<TerrainTypeModel> terrainTypeList = [];
  TerrainTypeModel terrainTypeData = TerrainTypeModel();

  Client get _client => AppConfig.instanceInit()!.client ?? Client.vppl;
  bool get _isURJAGATI => _client == Client.urjagati;

  AddClearingGradingBloc() : super(AddClearingGradingInitial()) {
    on<AddClearingGradingPageLoadEvent>(_pageLoadEvent);
    on<AddClearingGradingSubmitDataEvent>(_submitData);
    on<AddClearingGradingSelectAlignmentEvent>(_selectAlignment);
    on<AddClearingGradingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddClearingGradingSelectGroundTypeEvent>(_selectGroundType);
    on<AddClearingGradingSelectTerrainEvent>(_selectTerrain);
    on<AddClearingGradingSelectDateEvent>(_selectDate);
    on<AddClearingGradingAddImageEvent>(_selectFile);
    on<SelectWeatherEvent>(_selectWeather);
    on<CalculateLengthEvent>(_calculateChainage);
  }

  _pageLoadEvent(AddClearingGradingPageLoadEvent event, emit) async {
    emit(AddClearingGradingPageLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    tpChainageController.text = "";
    tpChainageNumberController.text = "";
    tpRemarkNumberController.text = "";
    structureNameController.text = "";
    boundaryLocation.text = "";
    activityRemarkController.text = "";
    groundTypeController.text = "";
    gapLengthController.text = "";
    gapDescriptionController.text = "";
    _isLoader = false;
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    ipNumberController.text = "";
    ipNumberFromController.text = "";
    boundaryLocationController.text = "";
    boundaryLocation.text = "";
    chainageFromController.text = "";
    chainageToController.text = "";
    chainageController.text = "";
    lengthController.text = "";
    machineyController.text = "";
    manpowerController.text = "";
    detailsController.text = "";
    terrainTypeList = [];
    terrainTypeData = TerrainTypeModel();
    file = File("");
    weatherData = WeatherModel();
     groundTypeList = [];
     groundTypeData = GroundTypeModel();
    _userData = UserInfo.instanceInit()!.userData!;

    if(_isURJAGATI){
      if (await ConnectivityHelper.checkInterNetConnect()) {
        weatherList = await DashboardHelper.fetchWeatherData();
        alignmentList = await AddRouteSurveyHelper.fetchAlignmentData();
        groundTypeList = await AddRouteSurveyHelper.fetchGroundTypeData();
        terrainTypeList = await DashboardHelper.fetchTerrainData();
      } else {
        weatherList = HiveDataBase.weatherBox!.values.toList();
        alignmentList = HiveDataBase.alignmentBox!.values.toList();
        groundTypeList = HiveDataBase.groundTypeBox!.values.toList();
        terrainTypeList = HiveDataBase.terrainTypeBox!.values.toList();
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
      terrainTypeList = await DashboardHelper.fetchTerrainData();
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _calculateChainage(CalculateLengthEvent event, emit) {
    bool isChainageTo =  event.isChainageTo;
    String value =  event.value;

    if(value.isEmpty) {
      lengthController.text = "";
    } else if(isChainageTo == true && value.isNotEmpty && chainageFromController.text.toString().isNotEmpty){
      double chainageTo =  double.parse(value.toString());
      double chainageFrom =  double.parse(chainageFromController.text.toString());
      if(chainageTo < chainageFrom){
        lengthController.text = "";
        SnackBarErrorWidget(event.context).show(message: "Chainage TO must be greater than or equal to Chainage FROM");
      }else {
        lengthController.text = "${chainageTo - chainageFrom}";
      }
    } else if(isChainageTo == false && value.isNotEmpty && chainageToController.text.toString().isNotEmpty){
      double chainageTo =  double.parse(chainageToController.text.toString());
      double chainageFrom =  double.parse(value);
      if(chainageTo < chainageFrom){
        lengthController.text = "";
        SnackBarErrorWidget(event.context).show(message: "Chainage TO must be greater than or equal to Chainage FROM");
      }else {
        lengthController.text = "${chainageTo - chainageFrom}";
      }
    }
    _eventComplete(emit);
  }

  _selectAlignment(AddClearingGradingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddClearingGradingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectGroundType(AddClearingGradingSelectGroundTypeEvent event, emit) {
    groundTypeData = event.groundTypeData;
    _eventComplete(emit);
  }

  _selectTerrain(AddClearingGradingSelectTerrainEvent event, emit) {
    terrainTypeData = event.terrainTypeData;
    _eventComplete(emit);
  }

  _selectDate(AddClearingGradingSelectDateEvent event, emit) async {
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

  _selectFile(AddClearingGradingAddImageEvent event, emit) async {
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

  _submitData(AddClearingGradingSubmitDataEvent event, emit) async {
    _isLoader = true;
    _eventComplete(emit);
    bool done = await RecordHelper.submitClearGrade(
      context: event.context,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      tpIpChainage: tpChainageController.text.toString(),
      tpIpNOS: tpChainageNumberController.text.toString(),
 //     tpIpRemark: tpRemarkNumberController.text.toString(),
      structureDetail: structureNameController.text.toString(),
      boundaryLocation: boundaryLocationController.text.toString(),
      activityRemark: activityRemarkController.text.toString(),
      groundType: AppConfig.instanceInit()!.client == Client.vppl
          || AppConfig.instanceInit()!.client == Client.urjagati
          || AppConfig.instanceInit()!.client == Client.vrpl
          || AppConfig.instanceInit()!.client == Client.bjpl
          || AppConfig.instanceInit()!.client == Client.jdpl
          || AppConfig.instanceInit()!.client == Client.gjpl
          || AppConfig.instanceInit()!.client == Client.bcpl
          ? terrainTypeData.id.toString() :groundTypeController.text.toString(),
      userData: userData,
      file: file,
      ipNumber: ipNumberController.text.toString(),
      ipNumberFrom: ipNumberFromController.text.toString(),
      weatherData: weatherData,
      chainageFrom: chainageFromController.text.toString(),
      chainageTo: chainageToController.text.toString(),
      chainage: chainageController.text.toString(),
      terrainTypeData: terrainTypeData,
      gapDescription: gapDescriptionController.text.toString(),
      gapLength: gapLengthController.text.toString(),
      details: detailsController.text.toString(),
      machiney: machineyController.text.toString(),
      manpower: manpowerController.text.toString()
    );
    _isLoader = false;
    _eventComplete(emit);
    if (done) {
      dateController.text = "";
      reportNumberController.text = "";
      tpChainageController.text = "";
      tpChainageNumberController.text = "";
      tpRemarkNumberController.text = "";
      structureNameController.text = "";
      boundaryLocation.text = "";
      activityRemarkController.text = "";
      groundTypeController.text = "";
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      ipNumberController.text = "";
      ipNumberFromController.text = "";
      boundaryLocationController.text = "";
      boundaryLocation.text = "";
      _isLoader = false;
      file = File("");
      chainageFromController.text = "";
      chainageToController.text = "";
      chainageController.text = "";
      gapLengthController.text = "";
      gapDescriptionController.text = "";
      lengthController.text = "";
      machineyController.text = "";
      manpowerController.text = "";
      detailsController.text = "";
      weatherData = WeatherModel();
      terrainTypeData = TerrainTypeModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddClearingGradingState> emit) {
    emit(FetchAddClearingGradingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      structureNameController: structureNameController,
      reportNumberController: reportNumberController,
      chainageController: chainageController,
      tpChainageController: tpChainageController,
      tpChainageNumberController: tpChainageNumberController,
      tpRemarkNumberController: tpRemarkNumberController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      groundTypeController: groundTypeController,
      boundaryLocationController: boundaryLocationController,
      ipNumberController: ipNumberController,
      ipNumberFromController: ipNumberFromController,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      terrainTypeData: terrainTypeData,
      terrainTypeList: terrainTypeList,
      gapDescriptionController: gapDescriptionController,
      gapLengthController: gapLengthController,
      lengthController: lengthController,
      groundTypeData: groundTypeData,
      groundTypeList: groundTypeList,
      detailsController: detailsController,
      machineyController: machineyController,
      manpowerController: manpowerController,
    ));
  }
}
