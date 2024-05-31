part of 'add_clearing_grading_bloc.dart';

abstract class AddClearingGradingState extends Equatable {
  const AddClearingGradingState();
}

class AddClearingGradingInitial extends AddClearingGradingState {
  @override
  List<Object> get props => [];
}

class AddClearingGradingPageLoadState extends AddClearingGradingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddClearingGradingDataState extends AddClearingGradingInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController tpChainageController;
  final TextEditingController tpChainageNumberController;
  final TextEditingController tpRemarkNumberController;
  final TextEditingController groundTypeController;
  final TextEditingController structureNameController;
  final TextEditingController chainageController;
  final TextEditingController activityRemarkController;
  final TextEditingController boundaryLocationController;
  final TextEditingController ipNumberController;
  final TextEditingController ipNumberFromController;
  final TextEditingController gapLengthController;
  final TextEditingController gapDescriptionController;
  final AlignmentModel  alignmentData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final List<TerrainTypeModel> terrainTypeList;
  final TerrainTypeModel terrainTypeData;

  FetchAddClearingGradingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.groundTypeController,
    required this.reportNumberController,
    required this.structureNameController,
    required this.chainageController,
    required this.tpChainageController,
    required this.tpChainageNumberController,
    required this.tpRemarkNumberController,
    required this.boundaryLocationController,
    required this.ipNumberController,
    required this.ipNumberFromController,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.chainageFromController,
    required this.chainageToController,
    required this.terrainTypeData,
    required this.terrainTypeList,
    required this.gapDescriptionController,
    required this.gapLengthController,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    dateController,
    activityRemarkController,
    groundTypeController,
    reportNumberController,
    structureNameController,
    chainageController,
    tpChainageController,
    tpChainageNumberController,
    tpRemarkNumberController,
    boundaryLocationController,
    alignmentData,
    file,
    ipNumberFromController,
    ipNumberController,
    weatherList,
    weatherData,
    chainageFromController,
    chainageToController,
    terrainTypeData,
    terrainTypeList,
    gapDescriptionController,
    gapLengthController,
  ];
}