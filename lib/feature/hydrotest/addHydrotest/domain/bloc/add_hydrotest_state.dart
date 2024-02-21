part of 'add_hydrotest_bloc.dart';

abstract class AddHydrotestState extends Equatable {
  const AddHydrotestState();
}

class AddHydrotestInitial extends AddHydrotestState {
  @override
  List<Object> get props => [];
}

class AddHydrotestPageLoadState extends AddHydrotestInitial {
  @override
  List<Object> get props => [];
}

class FetchAddHydrotestDataState extends AddHydrotestInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController lengthController;
  final JointNumberModel fromJointData;
  final List<JointNumberModel> jointFromList;
  final List<JointNumberModel> jointToList;
  final JointNumberModel toJointData;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final List<FileModel> fileList;
  final WeatherModel weatherData;

  FetchAddHydrotestDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.lengthController,
    required this.alignmentData,
    required this.fileList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.fromJointData,
    required this.jointFromList,
    required this.jointToList,
    required this.toJointData,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    lengthController,
    alignmentData,
    fileList,
    weatherData,
    jointTypeData,
    jointTypeList,
    isJointNumberLoader,
    fromJointData,
    jointFromList,
    jointToList,
    toJointData,
  ];
}
