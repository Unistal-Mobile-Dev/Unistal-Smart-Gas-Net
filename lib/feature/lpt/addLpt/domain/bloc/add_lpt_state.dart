part of 'add_lpt_bloc.dart';

abstract class AddLptState extends Equatable {
  const AddLptState();
}

class AddLptInitial extends AddLptState {
  @override
  List<Object> get props => [];
}

class AddLptPageLoadState extends AddLptInitial {
  @override
  List<Object> get props => [];
}

class FetchAddLptDataState extends AddLptInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final JointNumberModel jointData;
  final List<JointNumberModel> jointList;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<LptStatusModel> lptStatusList;
  final LptStatusModel lptStatusData;
  final TextEditingController observationResultsController;
  final TextEditingController searchPipeController;
  final List<PipeModel> pipeList;
  final bool searchPipeLoader;
  final List<TerrainTypeModel> listOfMEIL;
  final List<TerrainTypeModel> listOfCEIL;
  final List<TerrainTypeModel> listOfMECON ;
  final TerrainTypeModel dataMEIL;
  final TerrainTypeModel dataCEIL;
  final TerrainTypeModel dataMECON;
  final TextEditingController penetrantManufacturerController;
  final TextEditingController penetrantBatchNoController;
  final TextEditingController cleanerManufacturerController;
  final TextEditingController cleanerBatchNoController;
  final TextEditingController developerManufacturerController;
  final TextEditingController developerBatchNoController;
  final TextEditingController surfaceTemperatureController;
  final TextEditingController penetrantDwellTimeController;
  final TextEditingController developerTimeController;
  final TextEditingController acceptanceCriteriaController;
  final TextEditingController materialTypeController;
  final TextEditingController applicationMethodController;
  final TextEditingController sketchController;
  final TextEditingController typeController;
  final TextEditingController sizeController;
  final List<ThicknessModel> pipeThicknessList;
  final ThicknessModel pipeThicknessData;

  FetchAddLptDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.observationResultsController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.jointData,
    required this.jointList,
    required this.lptStatusList,
    required this.lptStatusData,
    required this.pipeList,
    required this.listOfMEIL,
    required this.listOfCEIL,
    required this.listOfMECON,
    required this.dataMEIL,
    required this.dataCEIL,
    required this.dataMECON,
    required this.searchPipeLoader,
    required this.searchPipeController,
    required this.penetrantManufacturerController,
    required this.penetrantBatchNoController,
    required this.cleanerManufacturerController,
    required this.cleanerBatchNoController,
    required this.developerManufacturerController,
    required this.developerBatchNoController,
    required this.surfaceTemperatureController,
    required this.penetrantDwellTimeController,
    required this.developerTimeController,
    required this.acceptanceCriteriaController,
    required this.materialTypeController,
    required this.applicationMethodController,
    required this.sketchController,
    required this.typeController,
    required this.sizeController,
    required this.pipeThicknessList,
    required this.pipeThicknessData,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    reportNumberController,
    observationResultsController,
    alignmentData,
    multipleAlignmentData,
    file,
    weatherList,
    weatherData,
    jointTypeData,
    jointTypeList,
    isJointNumberLoader,
    jointData,
    jointList,
    lptStatusList,
    lptStatusData,
    pipeList,
    listOfMEIL,
    listOfCEIL,
    listOfMECON,
    dataMEIL,
    dataCEIL,
    dataMECON,
    searchPipeController,
    searchPipeLoader,
    penetrantManufacturerController,
    penetrantBatchNoController,
    cleanerManufacturerController,
    cleanerBatchNoController,
    developerManufacturerController,
    developerBatchNoController,
    surfaceTemperatureController,
    penetrantDwellTimeController,
    developerTimeController,
    acceptanceCriteriaController,
    materialTypeController,
    applicationMethodController,
    sketchController,
    typeController,
    sizeController,
    pipeThicknessList,
    pipeThicknessData,
  ];
}
