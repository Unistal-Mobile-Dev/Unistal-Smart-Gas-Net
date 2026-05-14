import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/helper/clearing_grading_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/clearingGrading/addClearingGrading/model/terrain_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/hdpeductLaying/addHDPEDuct/helper/add_hdpe_duct_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/helper/add_route_survey_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/concrete_coating_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

part 'add_stringing_event.dart';

part 'add_stringing_state.dart';

class AddStringingBloc extends Bloc<AddStringingEvent, AddStringingState> {
  List<ConcreteCoatingModel> _concreteCoatingList = [];

  List<ConcreteCoatingModel> get concreteCoatingList => _concreteCoatingList;

  ConcreteCoatingModel _concreteCoatingData = ConcreteCoatingModel();

  ConcreteCoatingModel get concreteCoatingData => _concreteCoatingData;

  List<PipeModel> _pipeList = [];

  List<PipeModel> get pipeList => _pipeList;

  List<dynamic> _searchPipeList = [];

  List<dynamic> get searchPipeList => _searchPipeList;

  bool _searchPipeLoader = false;

  bool get searchPipeLoader => _searchPipeLoader;

  PipeModel _pipeData = PipeModel();

  PipeModel get pipeData => _pipeData;

  bool _isLoader = false;

  bool get isLoader => _isLoader;

  List<AlignmentModel> alignmentList = [];
  AlignmentModel alignmentData = AlignmentModel();
  List<AlignmentModel> multipleAlignmentData = [];

  double totalChainage = 0.0;
  List<String> formattedPipeChainageList = [];

  List<PaddingModel> weightCoatingList = [];
  PaddingModel weightCoatingData = PaddingModel();

  List<TerrainTypeModel> manufactureList = [];
  TerrainTypeModel manufactureData = TerrainTypeModel();

  TextEditingController dateController = TextEditingController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController activityRemarkController = TextEditingController();
  TextEditingController pipeLengthController = TextEditingController();
  TextEditingController corrosionCoatingCtrl = TextEditingController();
  TextEditingController chainageFromController = TextEditingController();
  TextEditingController chainageToController = TextEditingController();
  TextEditingController searchPipeController = TextEditingController();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  File file = File("");

  List<WeatherModel> _weatherList = [];

  List<WeatherModel> get weatherList => _weatherList;

  WeatherModel _weatherData = WeatherModel();

  WeatherModel get weatherData => _weatherData;

  List<PipeModel> pipeLengthList = [];
  List<TextEditingController> chainageFromControllers = [];
  List<TextEditingController> chainageToControllers = [];

  AddStringingBloc() : super(AddStringingInitial()) {
    on<AddStringingPageLoadEvent>(_pageLoadEvent);
    on<AddStringingSubmitDataEvent>(_submitData);
    on<SelectWeatherEvent>(_selectWeather);
    on<AddStringingSelectAlignmentEvent>(_selectAlignment);
    on<AddStringingMultipleSelectAlignmentEvent>(_selectMultipleAlignment);
    on<AddStringingSelectDateEvent>(_selectDate);
    on<AddStringingSelectPipeDataEvent>(_selectPipe);
    on<AddStringingAddPipeLengthEvent>(_addPipeLength);
    on<AddStringingChainageFromAddEvent>(_chainageFromAdd);
    on<AddStringingDeletePipeLengthEvent>(_deletePipeLength);
    on<AddStringingSearchPipeDataEvent>(_searchPipeData);
    on<AddStringingSelectConcreteCoatingEvent>(_selectConcreteCoating);
    on<SelectWeightCoatingEvent>(_selectWeightCoating);
    on<SelectNameManufactureEvent>(_selectNameManufacture);
    on<AddStringingAddImageEvent>(_selectFile);
  }

  _pageLoadEvent(AddStringingPageLoadEvent event, emit) async {
    emit(AddStringingPageLoadState());
    dateController = TextEditingController();
    reportNumberController = TextEditingController();
    activityRemarkController = TextEditingController();
    pipeLengthController = TextEditingController();
    corrosionCoatingCtrl = TextEditingController();
    chainageFromController = TextEditingController();
    chainageToController = TextEditingController();
    searchPipeController = TextEditingController();

    _pipeData = PipeModel();
    _pipeList = [];
    _concreteCoatingList = [];
    pipeLengthList = [];
    chainageFromControllers = [];
    chainageToControllers = [];
    _concreteCoatingData = ConcreteCoatingModel();
    _isLoader = false;
    alignmentList = [];
    file = File("");
    alignmentData = AlignmentModel();
    multipleAlignmentData = [];
    _weatherData = WeatherModel();
    _searchPipeLoader = false;
    totalChainage = 0.0;
    formattedPipeChainageList = [];
    weightCoatingList = [];
    weightCoatingData = PaddingModel();
    manufactureList = [];
    manufactureData = TerrainTypeModel();
    _userData = UserInfo.instanceInit()!.userData!;
    _weatherList = await DashboardHelper.fetchWeatherData(
        context: event.context, userData: userData);
    var res = await AddRouteSurveyHelper.fetchAlignmentData(
        context: !event.context.mounted ? event.context : event.context,
        userData: userData);
    if (res != null) {
      alignmentList = res;
    }

    var resConcreteCoating = await AddStringingHelper.fetchConcreteCoatingData(
        context: !event.context.mounted ? event.context : event.context);
    if (resConcreteCoating != null) {
      _concreteCoatingList = resConcreteCoating;
    }

    var peelTestRes = await AddHDPEDuctHelper.fetchPaddingData(
        context: !event.context.mounted ? event.context : event.context);
    if (peelTestRes != null) {
      weightCoatingList = peelTestRes;
    }

    var manufactureRes = await AddClearingGradingHelper.fetchManufactureData();
    if (manufactureRes.isNotEmpty) {
      manufactureList = manufactureRes;
    }

    _eventComplete(emit);
  }

  _selectDate(AddStringingSelectDateEvent event, emit) async {
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

  _selectWeather(SelectWeatherEvent event, emit) {
    _weatherData = event.weatherData;
    _eventComplete(emit);
  }

  _selectAlignment(AddStringingSelectAlignmentEvent event, emit) {
    alignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectMultipleAlignment(
      AddStringingMultipleSelectAlignmentEvent event, emit) {
    multipleAlignmentData = event.alignmentData;
    _eventComplete(emit);
  }

  _selectConcreteCoating(AddStringingSelectConcreteCoatingEvent event, emit) {
    _concreteCoatingData = event.concreteCoatingData;
    _eventComplete(emit);
  }

  _selectWeightCoating(SelectWeightCoatingEvent event, emit) {
    weightCoatingData = event.weightCoatingData;
    _eventComplete(emit);
  }

  _selectNameManufacture(SelectNameManufactureEvent event, emit) {
    manufactureData = event.nameManufactureData;
    _eventComplete(emit);
  }

  _selectPipe(AddStringingSelectPipeDataEvent event, emit) {
    _pipeData = event.pipeData;
    _searchPipeList = [];
    _searchPipeLoader = false;
    searchPipeController.text =
        "${pipeData.pipeNumber.toString()}|${pipeData.heatNumber.toString()}|${pipeData.pipeLength.toString()}";
    _eventComplete(emit);
  }

  _addPipeLength(AddStringingAddPipeLengthEvent event, emit) {
    if (searchPipeController.text.trim().isEmpty) {
      SnackBarErrorWidget(event.context)
          .show(message: "Please enter pipe length");
      return;
    }

    final matchingPipes = _pipeList
        .where((pipe) =>
            "${pipe.pipeNumber.toString().trim()}|${pipe.heatNumber.toString().trim()}|${pipe.pipeLength.toString().trim()}" ==
            searchPipeController.text.trim())
        .toList();

    if (matchingPipes.isEmpty) {
      SnackBarErrorWidget(event.context)
          .show(message: "Pipe number not found, Please check");
      return;
    }
    _isLoader = true;
    _eventComplete(emit);

    double chainageFrom =
        double.tryParse(chainageFromController.text.toString()) ?? 0.0;
    print("chainageFrom--->${chainageFrom}");

    if (chainageToControllers.isNotEmpty) {
      chainageFrom = double.tryParse(chainageToControllers.last.text) ?? 0.0;
    }

    double pipeLength = double.tryParse(pipeData.pipeLength.toString()) ?? 0.0;
    double chainageTo = chainageFrom + pipeLength;

    chainageFromController =
        TextEditingController(text: chainageFrom.toStringAsFixed(2));
    chainageToController =
        TextEditingController(text: chainageTo.toStringAsFixed(2));

    chainageFromControllers.add(chainageFromController);
    chainageToControllers.add(chainageToController);

    formattedPipeChainageList.add(
        "${pipeData.id} : ${chainageFromController.text.toString()} : ${chainageToController.text.toString()}");

    pipeLengthList.add(pipeData);

    searchPipeController.text = "";
    _isLoader = false;
    _searchPipeList = [];
    _eventComplete(emit);
  }

  _chainageFromAdd(AddStringingChainageFromAddEvent event, emit) {
    final index = event.index;
    double? fromValue = double.tryParse(chainageFromControllers[index].text);
    double pipeLength =
        double.tryParse(pipeLengthList[index].pipeLength.toString()) ?? 0;

    if (fromValue != null) {
      double toValue = fromValue + pipeLength;
      chainageToControllers[index].text = toValue.toStringAsFixed(2);
      String formattedFrom = fromValue.toStringAsFixed(2);
      String formattedTo = toValue.toStringAsFixed(2);
      if (formattedPipeChainageList.length > index) {
        formattedPipeChainageList[index] =
            "${pipeLengthList[index].id} : $formattedFrom : $formattedTo";
      } else {
        formattedPipeChainageList
            .add("${pipeLengthList[index].id} : $formattedFrom : $formattedTo");
      }
      for (int i = index + 1; i < pipeLengthList.length; i++) {
        double prevTo = double.tryParse(chainageToControllers[i - 1].text) ?? 0;
        double nextPipeLength =
            double.tryParse(pipeLengthList[i].pipeLength.toString()) ?? 0;
        chainageFromControllers[i].text = prevTo.toStringAsFixed(2);
        chainageToControllers[i].text =
            (prevTo + nextPipeLength).toStringAsFixed(2);
        String formattedFromNext = prevTo.toStringAsFixed(2);
        String formattedToNext = (prevTo + nextPipeLength).toStringAsFixed(2);
        if (formattedPipeChainageList.length > i) {
          formattedPipeChainageList.clear();
          formattedPipeChainageList[i] =
              "${pipeLengthList[i].id} : $formattedFromNext : $formattedToNext";
        } else {
          formattedPipeChainageList.add(
              "${pipeLengthList[i].id} : $formattedFromNext : $formattedToNext");
        }
      }
    }

    print("formattedPipeChainageList --> $formattedPipeChainageList");
    print("chainageToControllers --> ${chainageToControllers[index].text}");
    print("chainageFromControllers --> ${chainageFromControllers[index].text}");
    _eventComplete(emit);
  }

  _deletePipeLength(AddStringingDeletePipeLengthEvent event, emit) {
    _isLoader = true;
    _eventComplete(emit);
    pipeLengthList.removeAt(event.index);
    chainageFromControllers.removeAt(event.index);
    chainageToControllers.removeAt(event.index);
    formattedPipeChainageList.removeAt(event.index);
    _isLoader = false;
    _eventComplete(emit);
  }

  _searchPipeData(AddStringingSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader = true;
    _eventComplete(emit);
    var resPipe = await AddStringingHelper.fetchPipeData(
        context: event.context,
        userData: userData,
        searchKeyword: event.keyword.toString(),
        type: "stringing");
    if (resPipe != null) {
      _pipeList = resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader = false;
    _eventComplete(emit);
  }

  _selectFile(AddStringingAddImageEvent event, emit) async {
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

  _submitData(AddStringingSubmitDataEvent event, emit) async {
/*    var textFiledValidation =  await AddStringingHelper.textFiledValidation(context: event.context,
        alignmentData: alignmentData,
        reportNumber: reportNumberController.text.toString(),
        date: dateController.text.toString(),
        concreteCoatingData: concreteCoatingData,
        pipeData: pipeData,
        activityRemark: activityRemarkController.text.toString());
    if(textFiledValidation == false){
      return;
    }*/
    _isLoader = true;
    _eventComplete(emit);
    var res = await AddStringingHelper.submitData(
      context: event.context,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      reportNumber: reportNumberController.text.toString(),
      date: dateController.text.toString(),
      concreteCoatingData: concreteCoatingData,
      pipeData: pipeData,
      activityRemark: activityRemarkController.text.toString(),
      userData: userData,
      file: file,
      chainageFrom: "0",
      chainageTo: "0",
      weatherData: weatherData,
      concreteCoating: weightCoatingData.id == null ? "" : weightCoatingData.id.toString(),
      nameOfManufacture: manufactureData.id == null ? "" : manufactureData.id.toString(),
      typeOfCorrosionCoating: corrosionCoatingCtrl.text.toString(),
      //  pipeLength: pipeLengthList,
      pipeLength: formattedPipeChainageList,
    );
    _isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      dateController = TextEditingController();
      reportNumberController = TextEditingController();
      activityRemarkController = TextEditingController();
      pipeLengthController = TextEditingController();
      corrosionCoatingCtrl = TextEditingController();
      chainageFromController = TextEditingController();
      chainageToController = TextEditingController();
      searchPipeController = TextEditingController();
      _pipeData = PipeModel();
      _concreteCoatingData = ConcreteCoatingModel();
      _isLoader = false;
      file = File("");
      alignmentData = AlignmentModel();
      multipleAlignmentData = [];
      _weatherData = WeatherModel();
      pipeLengthList = [];
      formattedPipeChainageList = [];
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddStringingState> emit) {
    emit(FetchAddStringingDataState(
      isLoader: isLoader,
      alignmentList: alignmentList,
      dateController: dateController,
      activityRemarkController: activityRemarkController,
      reportNumberController: reportNumberController,
      corrosionCoatingCtrl: corrosionCoatingCtrl,
      alignmentData: alignmentData,
      multipleAlignmentData: multipleAlignmentData,
      file: file,
      concreteCoatingData: concreteCoatingData,
      concreteCoatingList: concreteCoatingList,
      pipeData: pipeData,
      pipeList: pipeList,
      weatherData: weatherData,
      weatherList: weatherList,
      chainageFromController: chainageFromControllers,
      chainageToController: chainageToControllers,
      searchPipeList: searchPipeList,
      searchPipeController: searchPipeController,
      pipeLengthController: pipeLengthController,
      searchPipeLoader: searchPipeLoader,
      pipeLengthList: pipeLengthList,
      manufactureData: manufactureData,
      manufactureList: manufactureList,
      weightCoatingData: weightCoatingData,
      weightCoatingList: weightCoatingList,
    ));
  }
}
