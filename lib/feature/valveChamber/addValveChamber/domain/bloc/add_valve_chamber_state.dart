part of 'add_valve_chamber_bloc.dart';

abstract class AddValveChamberState extends Equatable {
  const AddValveChamberState();
}


class AddValveChamberInitial extends AddValveChamberState {
  @override
  List<Object> get props => [];
}

class AddValveChamberPageLoadState extends AddValveChamberInitial {
  @override
  List<Object> get props => [];
}

class FetchAddValveChamberDataState extends AddValveChamberInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController fromJointIdController;
  final TextEditingController toJointIdController;
  final TextEditingController descriptionOfStructureMemberController;
  final TextEditingController unitWeight;
  final TextEditingController heightController;
  final TextEditingController activityRemarkController;
  final AlignmentModel  alignmentData;
  final File file;
  final bool isJointNumberLoader;
  final TextEditingController chainageFromController;
  final TextEditingController weightController;
  final TextEditingController lengthController;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;

  FetchAddValveChamberDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.unitWeight,
    required this.fromJointIdController,
    required this.toJointIdController,
    required this.descriptionOfStructureMemberController,
    required this.alignmentData,
    required this.file,
    required this.isJointNumberLoader,
    required this.chainageFromController,
    required this.weightController,
    required this.lengthController,
    required this.weatherData,
    required this.weatherList,
    required this.heightController,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    dateController,
    activityRemarkController,
    reportNumberController,
    unitWeight,
    fromJointIdController,
    toJointIdController,
    descriptionOfStructureMemberController,
    alignmentData,
    file,
    isJointNumberLoader,
    chainageFromController,
    weightController,
    lengthController,
    weatherList,
    weatherData,
    heightController,
  ];
}