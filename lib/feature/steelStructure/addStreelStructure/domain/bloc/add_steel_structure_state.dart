part of 'add_steel_structure_bloc.dart';

abstract class AddSteelStructureState extends Equatable {
  const AddSteelStructureState();
}


class AddSteelStructureInitial extends AddSteelStructureState {
  @override
  List<Object> get props => [];
}

class AddSteelStructurePageLoadState extends AddSteelStructureInitial {
  @override
  List<Object> get props => [];
}

class FetchAddSteelStructureDataState extends AddSteelStructureInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController fromJointIdController;
  final TextEditingController toJointIdController;
  final TextEditingController descriptionOfStructureMemberController;
  final TextEditingController unitWeight;
  final TextEditingController activityRemarkController;
  final AlignmentModel  alignmentData;
  final File file;
  final bool isJointNumberLoader;
  final TextEditingController chainageFromController;
  final TextEditingController weightController;
  final TextEditingController lengthController;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;

  FetchAddSteelStructureDataState({
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
  ];
}