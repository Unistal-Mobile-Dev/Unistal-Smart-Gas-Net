part of 'add_back_filling_bloc.dart';

abstract class AddBackFillingState extends Equatable {
  const AddBackFillingState();
}

class AddBackFillingInitial extends AddBackFillingState {
  @override
  List<Object> get props => [];
}

class AddBackFillingPageLoadState extends AddBackFillingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddBackFillingDataState extends AddBackFillingInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController postPaddingController;
  final TextEditingController slopeBreakerController;
  final TextEditingController warningMatController;
  final TextEditingController antiBuoyancyController;
  final VisualChecksModel plasticGratingData;
  final List<VisualChecksModel> plasticGratingList;
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

  FetchAddBackFillingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.chainageFromController,
    required this.chainageToController,
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
    required this.plasticGratingData,
    required this.plasticGratingList,
    required this.postPaddingController,
    required this.slopeBreakerController,
    required this.toJointData,
    required this.warningMatController,
    required this.antiBuoyancyController,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    reportNumberController,
    chainageFromController,
    chainageToController,
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
    plasticGratingData,
    plasticGratingList,
    postPaddingController,
    slopeBreakerController,
    warningMatController,
    antiBuoyancyController,
  ];
}
