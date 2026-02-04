part of 'add_zn_grounding_anode_bloc.dart';

@immutable
abstract class AddZnGroundingAnodeState extends Equatable {}

final class AddZnGroundingAnodeInitial extends AddZnGroundingAnodeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AddZnGroundingAnodePageLoadState extends AddZnGroundingAnodeState {
  @override
  List<Object> get props => [];
}

class FetchAddZnGroundingAnodeState extends AddZnGroundingAnodeState {
  final File file;
  final bool isLoader;
  final List<JointTypeModel> listOfJointType;
  final JointTypeModel jointTypeDataValue;
  final List<JointNumberModel> listOfJoint;
  final JointNumberModel jointValue;
  final bool isJointNumberLoader;
  final List<TlpTypeModel> listOfSacrificialAnode;
  final TlpTypeModel typeNodeValue;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<TlpTypeModel> listOfTLPType;
  final TlpTypeModel tlpTypeValue;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController chainageController;
  final TextEditingController areaController;
  final TextEditingController anodeWeightController;
  final TextEditingController anodeLocationController;
  final TextEditingController depthAugerController;
  final TextEditingController anodeConditionController;
  final TextEditingController distanceController;
  final TextEditingController noAnodesController;
  final TextEditingController a1LengthController;
  final TextEditingController a2LengthController;
  final TextEditingController a3LengthController;
  final TextEditingController earthingController;
  final TextEditingController acPspBeforeController;
  final TextEditingController a1AnodeController;
  final TextEditingController a2AnodeController;
  final TextEditingController a3AnodeController;
  final TextEditingController a4AnodeController;
  final TextEditingController acPspAfterController;
  final TextEditingController dcPspBeforeController;
  final TextEditingController dcPspAfterController;
  final TextEditingController acCurrentAfterController;
  final TextEditingController installationTypeController;
  final TextEditingController checkWaterFillingController;
  final TextEditingController activityRemarkController;


  FetchAddZnGroundingAnodeState({
    required this.isLoader,
    required this.alignmentList,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointValue,
    required this.listOfJoint,
    required this.listOfJointType,
    required this.jointTypeDataValue,
    required this.isJointNumberLoader,
    required this.listOfSacrificialAnode,
    required this.typeNodeValue,
     required this.dateController,
    required this.chainageController,
    required this.areaController,
    required this.listOfTLPType,
    required this.tlpTypeValue,
     required this.reportNumberController,
     required this.anodeWeightController,
     required this.anodeLocationController,
     required this.depthAugerController,
     required this.anodeConditionController,
     required this.distanceController,
     required this.noAnodesController,
     required this.a1LengthController,
     required this.a2LengthController,
     required this.a3LengthController,
     required this.earthingController,
     required this.acPspBeforeController,
     required this.a1AnodeController,
     required this.a2AnodeController,
     required this.a3AnodeController,
     required this.a4AnodeController,
     required this.acPspAfterController,
     required this.dcPspBeforeController,
     required this.dcPspAfterController,
     required this.acCurrentAfterController,
     required this.installationTypeController,
     required this.checkWaterFillingController,
    required this.activityRemarkController,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    alignmentData,
    multipleAlignmentData,
    file,
    weatherList,
    weatherData,
    jointValue,
    listOfJoint,
    listOfJointType,
    jointTypeDataValue,
    isJointNumberLoader,
    listOfSacrificialAnode,
    listOfTLPType,
    tlpTypeValue,
    typeNodeValue,
    dateController,
    chainageController,
    areaController,
    reportNumberController,
    anodeWeightController,
    anodeLocationController,
    depthAugerController,
    anodeConditionController,
    distanceController,
    noAnodesController,
    a1LengthController,
    a2LengthController,
    a3LengthController,
    earthingController,
    acPspBeforeController,
    a1AnodeController,
    a2AnodeController,
    a3AnodeController,
    a4AnodeController,
    acPspAfterController,
    dcPspBeforeController,
    dcPspAfterController,
    acCurrentAfterController,
    installationTypeController,
    checkWaterFillingController,
    activityRemarkController,
  ];
}

