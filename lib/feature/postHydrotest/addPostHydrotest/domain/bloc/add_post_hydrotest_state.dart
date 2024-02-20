part of 'add_post_hydrotest_bloc.dart';

abstract class AddPostHydrotestState extends Equatable {
  const AddPostHydrotestState();
}

class AddPostHydrotestInitial extends AddPostHydrotestState {
  @override
  List<Object> get props => [];
}

class AddPostHydrotestPageLoadState extends AddPostHydrotestInitial {
  @override
  List<Object> get props => [];
}

class FetchAddPostHydrotestDataState extends AddPostHydrotestInitial {
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
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;

  FetchAddPostHydrotestDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.lengthController,
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
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    lengthController,
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
  ];
}
