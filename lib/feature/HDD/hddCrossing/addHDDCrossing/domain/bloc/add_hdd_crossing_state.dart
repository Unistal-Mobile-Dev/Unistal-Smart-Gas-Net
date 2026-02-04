part of 'add_hdd_crossing_bloc.dart';

@immutable
abstract class AddHddCrossingState extends Equatable{}

 class AddHddCrossingInitial extends AddHddCrossingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddHddCrossingPageLoadState extends AddHddCrossingState {
 @override
 List<Object> get props => [];
}

class FetchAddHddCrossingDataState extends AddHddCrossingState {
 final File file;
 final bool isLoader;
 final List<JointTypeModel> listOfJointType;
 final JointTypeModel jointTypeDataValue;
 final bool isJointNumberLoader;
 final AlignmentModel alignmentData;
 final List<AlignmentModel> multipleAlignmentData;
 final List<AlignmentModel> alignmentList;
 final List<WeatherModel> weatherList;
 final WeatherModel weatherData;
 final List<JointNumberModel> listOfFromJoint;
 final JointNumberModel fromJointValue;
 final List<JointNumberModel> listOfToJoint;
 final JointNumberModel toJointValue;
 final TextEditingController dateController;
 final TextEditingController dateCommencementController;
 final TextEditingController dateCompletionController;
 final TextEditingController datePreHydroController;
 final TextEditingController reportNumberController;
 final TextEditingController hddLocationController;
 final TextEditingController equipmentUsedController;
 final TextEditingController equipmentCapacityController;
 final TextEditingController activityRemarkController;
 final TextEditingController pipeSpecificationController;
 final TextEditingController pipeODThicknessController;
 final TextEditingController lengthCrossingController;
 final TextEditingController pilotBoreDateCommencementController;
 final TextEditingController pilotBoreStartTimeController;
 final TextEditingController pilotBoreDateCompletionController;
 final TextEditingController pilotBoreCompletedTimeController;
 final TextEditingController pilotBoreDiameterController;
 final TextEditingController pilotBoreDurationController;
 final TextEditingController reamerSizeUsedController;
 final TextEditingController startController;
 final TextEditingController endController;
 final TextEditingController roDurationController;
 final TextEditingController loadObservedPSIController;


 FetchAddHddCrossingDataState({
  required this.isLoader,
  required this.alignmentList,
  required this.alignmentData,
  required this.multipleAlignmentData,
  required this.file,
  required this.weatherList,
  required this.weatherData,
  required this.isJointNumberLoader,
  required this.jointTypeDataValue,
  required this.listOfJointType,
  required this.listOfFromJoint,
  required this.fromJointValue,
  required this.listOfToJoint,
  required this.toJointValue,
  required this.dateController,
  required this.dateCommencementController,
  required this.dateCompletionController,
  required this.datePreHydroController,
  required this.reportNumberController,
  required this.hddLocationController,
  required this.equipmentUsedController,
  required this.equipmentCapacityController,
  required this.activityRemarkController,
  required this.pipeSpecificationController,
  required this.pipeODThicknessController,
  required this.lengthCrossingController,
  required this.pilotBoreDateCommencementController,
  required this.pilotBoreStartTimeController,
  required this.pilotBoreDateCompletionController,
  required this.pilotBoreCompletedTimeController,
  required this.pilotBoreDiameterController,
  required this.pilotBoreDurationController,
  required this.reamerSizeUsedController,
  required this.startController,
  required this.endController,
  required this.roDurationController,
  required this.loadObservedPSIController,
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
  isJointNumberLoader,
  jointTypeDataValue,
  listOfJointType,
  listOfFromJoint,
  fromJointValue,
  listOfToJoint,
  toJointValue,
  dateController,
  dateCommencementController,
  dateCompletionController,
  datePreHydroController,
  reportNumberController,
  hddLocationController,
  equipmentUsedController,
  equipmentCapacityController,
  activityRemarkController,
  pipeSpecificationController,
  pipeODThicknessController,
  lengthCrossingController,
  pilotBoreDateCommencementController,
  pilotBoreStartTimeController,
  pilotBoreDateCompletionController,
  pilotBoreCompletedTimeController,
  pilotBoreDiameterController,
  pilotBoreDurationController,
  reamerSizeUsedController,
  startController,
  endController,
  roDurationController,
  loadObservedPSIController,
 ];
}



