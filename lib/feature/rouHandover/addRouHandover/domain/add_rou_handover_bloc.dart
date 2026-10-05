import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
part 'add_rou_handover_event.dart';
part 'add_rou_handover_state.dart';

class AddRouHandoverBloc
    extends Bloc<AddRouHandoverEvent, AddRouHandoverState> {
  bool _isLoader = false;

  bool get isLoader => _isLoader;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData =  [];

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController tenderNoController = TextEditingController();
  TextEditingController typeofGroundController = TextEditingController();
  TextEditingController tpChainageNumberController = TextEditingController();
  TextEditingController tpRemarkController = TextEditingController();
  TextEditingController bearingAngleController = TextEditingController();
  TextEditingController terrainController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  List<WeatherModel> weatherList = [];
  WeatherModel weatherData = WeatherModel();

  File file = File("");

  Client get _client => AppConfig.instanceInit()!.client ?? Client.vppl;
  bool get _isURJAGATI => _client == Client.urjagati;

  AddRouHandoverBloc() : super(AddRouHandoverInitial()) {
    on<AddRouHandoverLoadEvent>(_pageLoadEvent);
    on<AddRouHandoverSubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddRouHandoverSelectAlignmentEvent>(_selectAlignment);
    on<AddRouHandoverMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddRouHandoverSelectDateEvent>(_selectDate);
    on<CalculateLengthEvent>(_calculateChainage);
    on<AddRouHandoverAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddRouHandoverLoadEvent event, emit) async {
    emit(AddRouHandoverLoadState());
    dateController.text = "";
    reportNumberController.text = "";
    tenderNoController.text = "";
    typeofGroundController.text = "";
    tpChainageNumberController.text = "";
    tpRemarkController.text = "";
    bearingAngleController.text = "";
    terrainController.text = "";
    activityRemarkController.text = "";
    _isLoader = false;
    file = File("");
    weatherData = WeatherModel();
    chainageFromController.text = "";
    chainageToController.text = "";
    lengthController.text = "";
    alignmentList = [];
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    _userData = UserInfo.instanceInit()!.userData!;
    if(_isURJAGATI){
      if (await ConnectivityHelper.checkInterNetConnect()) {
        weatherList = await DashboardHelper.fetchWeatherData();
        alignmentList = await AddRouteSurveyHelper.fetchAlignmentData();
      } else {
        weatherList = HiveDataBase.weatherBox!.values.toList();
        alignmentList = HiveDataBase.alignmentBox!.values.toList();
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
    }
    _eventComplete(emit);
  }

  _selectWeather(SelectWeatherEvent event, emit) {
    weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddRouHandoverSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(AddRouHandoverMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectDate(AddRouHandoverSelectDateEvent event, emit) async {
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
      // print("Date is not selected");
    }
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
        lengthController.text =  "${chainageTo - chainageFrom}";
      }
    }
    _eventComplete(emit);
  }


  _selectFile(AddRouHandoverAddImageEvent event, emit) async {
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

  _submitData(AddRouHandoverSubmitDataEvent event, emit) async {
/*    var textFiledValidation =  await AddRouHandover.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        typeofGround: typeofGroundController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark:tpRemarkController.text.toString(),
        bearing: bearingAngleController.text.toString(),
        terrain: terrainController.text.toString(),
        activityRemark: activityRemarkController.text.toString());
    if(textFiledValidation == false){
      return;
    }*/
    _isLoader = true;
    _eventComplete(emit);
    bool done = await RecordHelper.submitRouHandover(
        context: event.context,
        multipleAlignmentData: multipleAlignmentData,
        reportNumber: reportNumberController.text.toString(),
        tenderNo: tenderNoController.text.toString(),
        date: dateController.text.toString(),
        typeofGround: typeofGroundController.text.toString(),
        tpIpNOS: tpChainageNumberController.text.toString(),
        tpIpRemark: tpRemarkController.text.toString(),
        activityRemark: activityRemarkController.text.toString(),
        userData: userData,
        file: file,
        chainageFrom: chainageFromController.text.toString(),
        chainageTo: chainageToController.text.toString(),
        totalLength: lengthController.text.toString(),
        weatherData: weatherData);
    _isLoader = false;
    _eventComplete(emit);
    if (done) {
      dateController.text = "";
      reportNumberController.text = "";
      tenderNoController.text = "";
      typeofGroundController.text = "";
      tpChainageNumberController.text = "";
      tpRemarkController.text = "";
      bearingAngleController.text = "";
      terrainController.text = "";
      activityRemarkController.text = "";
      _isLoader = false;
      alignmentList = [];
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      chainageFromController.text = "";
      chainageToController.text = "";
      lengthController.text = "";
      file = File("");
      weatherData = WeatherModel();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddRouHandoverState> emit) {
    emit(FetchAddRouHandoverDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      bearingAngleController: bearingAngleController,
      reportNumberController: reportNumberController,
      tenderNoController: tenderNoController,
      terrainController: terrainController,
      typeofGroundController: typeofGroundController,
      tpChainageNumberController: tpChainageNumberController,
      tpRemarkController: tpRemarkController,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromController,
      chainageToController: chainageToController,
      lengthController: lengthController,
    ));
  }
}
