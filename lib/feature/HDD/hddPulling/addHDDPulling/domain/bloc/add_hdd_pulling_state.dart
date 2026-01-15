part of 'add_hdd_pulling_bloc.dart';

@immutable
abstract class AddHddPullingState extends Equatable{}

 class AddHddPullingInitial extends AddHddPullingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AddHddPullingPageLoadState extends AddHddPullingState {
 @override
 List<Object> get props => [];
}

class FetchAddHddPullingDataState extends AddHddPullingState {
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
 final TextEditingController startDatePullingController;
 final TextEditingController endDateOfPullingController;
 final TextEditingController reportNumberController;
 final TextEditingController machineCapacityController;
 final TextEditingController reamerSizeController;
 final TextEditingController sizePullingController;
 final TextEditingController sizeOfPilotBitSizeController;
 final TextEditingController lengthController;
 final TextEditingController rodNoController;
 final TextEditingController totalLengthController;
 final TextEditingController pitchController;
 final TextEditingController degreeController;
 final TextEditingController pullBackPressureController;
 final TextEditingController rotaryPressureController;
 final TextEditingController pumpRateController;
 final TextEditingController activityRemarkController;


 FetchAddHddPullingDataState({
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
  required this.startDatePullingController,
  required this.endDateOfPullingController,
  required this.reportNumberController,
  required this.machineCapacityController,
  required this.reamerSizeController,
  required this.sizePullingController,
  required this.sizeOfPilotBitSizeController,
  required this.lengthController,
  required this.rodNoController,
  required this.totalLengthController,
  required this.pitchController,
  required this.degreeController,
  required this.pumpRateController,
  required this.pullBackPressureController,
  required this.rotaryPressureController,
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
  startDatePullingController,
  endDateOfPullingController,
  reportNumberController,
  reamerSizeController,
  machineCapacityController,
  sizePullingController,
  sizeOfPilotBitSizeController,
  lengthController,
  rodNoController,
  totalLengthController,
  pitchController,
  degreeController,
  pumpRateController,
  pullBackPressureController,
  rotaryPressureController,
  activityRemarkController,
 ];
}



