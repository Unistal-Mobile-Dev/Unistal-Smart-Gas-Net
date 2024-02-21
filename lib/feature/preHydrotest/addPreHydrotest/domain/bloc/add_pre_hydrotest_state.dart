part of 'add_pre_hydrotest_bloc.dart';

abstract class AddPreHydrotestState extends Equatable {
  const AddPreHydrotestState();
}


class AddPreHydrotestInitial extends AddPreHydrotestState {
  @override
  List<Object> get props => [];
}

class AddPreHydrotestPageLoadState extends AddPreHydrotestInitial {
  @override
  List<Object> get props => [];
}

class FetchAddPreHydrotestDataState extends AddPreHydrotestInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController lengthController;
  final TextEditingController ndeClearanceController;
  final JointNumberModel fromJointData;
  final List<JointNumberModel> jointFromList;
  final List<JointNumberModel> jointToList;
  final JointNumberModel toJointData;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final ThicknessModel thicknessData;
  final List<ThicknessModel> thicknessList;

  FetchAddPreHydrotestDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.lengthController,
    required this.ndeClearanceController,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.fromJointData,
    required this.jointFromList,
    required this.jointToList,
    required this.toJointData,
    required this.thicknessData,
    required this.thicknessList,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    lengthController,
    ndeClearanceController,
    alignmentData,
    file,
    weatherList,
    weatherData,
    jointTypeData,
    jointTypeList,
    isJointNumberLoader,
    fromJointData,
    jointFromList,
    jointToList,
    toJointData,
    thicknessData,
    thicknessList,
  ];
}
