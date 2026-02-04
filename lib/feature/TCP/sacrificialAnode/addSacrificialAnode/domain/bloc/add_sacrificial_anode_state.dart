part of 'add_sacrificial_anode_bloc.dart';

@immutable
abstract class AddSacrificialAnodeState extends Equatable {}

final class AddSacrificialAnodeInitial extends AddSacrificialAnodeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AddSacrificialAnodePageLoadState extends AddSacrificialAnodeState {
  @override
  List<Object> get props => [];
}

class FetchAddSacrificialAnodeState extends AddSacrificialAnodeState {
  final File file;
  final bool isLoader;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<TlpTypeModel> listOfTLPType;
  final TlpTypeModel tlpTypeValue;
  final List<TlpTypeModel> listOfSacrificialAnode;
  final TlpTypeModel sacrificialAnodeValue;
  final List<VisualChecksModel> listOfAnodeCondition;
  final VisualChecksModel anodeConditionValue;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController chainageController;
  final TextEditingController areaController;
  final TextEditingController testStationLocationController;
  final TextEditingController testStationTypeController;
  final TextEditingController testStationController;
  final TextEditingController distanceController;
  final TextEditingController noAnodesController;
  final TextEditingController spacingAnodesController;
  final TextEditingController outputAnodesController;
  final TextEditingController a1Controller;
  final TextEditingController a2Controller;
  final TextEditingController a3Controller;
  final TextEditingController anodeCircuitController;
  final TextEditingController beforeAnodeController;
  final TextEditingController afterAnodeController;
  final TextEditingController activityRemarkController;


  FetchAddSacrificialAnodeState({
    required this.isLoader,
    required this.alignmentList,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.listOfTLPType,
    required this.tlpTypeValue,
    required this.anodeConditionValue,
    required this.listOfAnodeCondition,
    required this.listOfSacrificialAnode,
    required this.sacrificialAnodeValue,
    required this.dateController,
    required this.reportNumberController,
    required this.chainageController,
    required this.areaController,
    required this.testStationLocationController,
    required this.testStationTypeController,
    required this.testStationController,
    required this.distanceController,
    required this.noAnodesController,
    required this.spacingAnodesController,
    required this.outputAnodesController,
    required this.a1Controller,
    required this.a2Controller,
    required this.a3Controller,
    required this.anodeCircuitController,
    required this.beforeAnodeController,
    required this.afterAnodeController,
    required this.activityRemarkController,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    alignmentData,
    multipleAlignmentData,
    file,
    weatherList,
    weatherData,
    listOfTLPType,
    tlpTypeValue,
    anodeConditionValue,
    listOfAnodeCondition,
    listOfSacrificialAnode,
    sacrificialAnodeValue,
    dateController,
    reportNumberController,
    chainageController,
    areaController,
    testStationLocationController,
    testStationTypeController,
    testStationController,
    distanceController,
    noAnodesController,
    spacingAnodesController,
    outputAnodesController,
    a1Controller,
    a2Controller,
    a3Controller,
    anodeCircuitController,
    beforeAnodeController,
    afterAnodeController,
    activityRemarkController,
  ];
}

