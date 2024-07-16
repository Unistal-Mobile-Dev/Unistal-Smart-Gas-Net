part of 'add_pilot_drill_bloc.dart';

@immutable
abstract class AddPilotDrillState extends Equatable {}

class AddPilotDrillInitial extends AddPilotDrillState {
 @override
 // TODO: implement props
 List<Object?> get props => [];
}

class AddPilotDrillPageLoadState extends AddPilotDrillState {
 @override
 List<Object> get props => [];
}

class FetchAddPilotDrillDataState extends AddPilotDrillState {
 final File file;
 final bool isLoader;
 final List<JointTypeModel> listOfJointType;
 final JointTypeModel jointTypeDataValue;
 final bool isJointNumberLoader;
 final AlignmentModel alignmentData;
 final List<AlignmentModel> alignmentList;
 final List<WeatherModel> weatherList;
 final WeatherModel weatherData;
 final List<JointNumberModel> listOfFromJoint;
 final JointNumberModel fromJointValue;
 final List<JointNumberModel> listOfToJoint;
 final JointNumberModel toJointValue;
 final TextEditingController dateController;
 final TextEditingController startDateOfPilotHoleController;
 final TextEditingController endDateOfPilotHoleController;
 final TextEditingController reportNumberController;
 final TextEditingController machineCapacityController;
 final TextEditingController sizeOfPilotBitSizeController;
 final TextEditingController lengthController;
 final TextEditingController rodNoController;
 final TextEditingController totalLengthController;
 final TextEditingController pitchController;
 final TextEditingController degreeController;
 final TextEditingController depthController;
 final TextEditingController activityRemarkController;


 FetchAddPilotDrillDataState({
  required this.isLoader,
  required this.isJointNumberLoader,
  required this.jointTypeDataValue,
  required this.listOfJointType,
  required this.alignmentList,
  required this.alignmentData,
  required this.file,
  required this.weatherList,
  required this.weatherData,
  required this.listOfFromJoint,
  required this.fromJointValue,
  required this.listOfToJoint,
  required this.toJointValue,
  required this.dateController,
  required this.startDateOfPilotHoleController,
  required this.endDateOfPilotHoleController,
  required this.reportNumberController,
  required this.machineCapacityController,
  required this.sizeOfPilotBitSizeController,
  required this.lengthController,
  required this.rodNoController,
  required this.totalLengthController,
  required this.pitchController,
  required this.degreeController,
  required this.depthController,
  required this.activityRemarkController,
 });

 @override
 List<Object> get props => [
  alignmentList,
  isLoader,
  isJointNumberLoader,
  jointTypeDataValue,
  listOfJointType,
  alignmentData,
  file,
  weatherList,
  weatherData,
  listOfFromJoint,
  fromJointValue,
  listOfToJoint,
  toJointValue,
  dateController,
  startDateOfPilotHoleController,
  endDateOfPilotHoleController,
  reportNumberController,
  machineCapacityController,
  sizeOfPilotBitSizeController,
  lengthController,
  rodNoController,
  totalLengthController,
  pitchController,
  degreeController,
  depthController,
  activityRemarkController,
 ];
}

