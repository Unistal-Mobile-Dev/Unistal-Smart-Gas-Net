part of 'add_tren_ching_bloc.dart';

abstract class AddTrenChingState extends Equatable {
  const AddTrenChingState();
}

class AddTrenChingInitial extends AddTrenChingState {
  @override
  List<Object> get props => [];
}

class AddTrenChingPageLoadState extends AddTrenChingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddTrenChingDataState extends AddTrenChingInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController fromJointIdController;
  final TextEditingController toJointIdController;
  final TextEditingController trenchingDepthController;
  final TextEditingController terrainController;
  final TextEditingController activityRemarkController;
  final AlignmentModel  alignmentData;
  final File file;
  final List<JointNumberModel>  jointNumberList;
  final JointNumberModel jointNumberData;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final JointNumberModel fromJointData;
  final List<JointNumberModel> jointFromList;
  final List<JointNumberModel> jointToList;
  final JointNumberModel toJointData;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController toWidthController;
  final List<SoilTypeModel> soilTypeList;
  final SoilTypeModel soilTypeData;

  FetchAddTrenChingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.terrainController,
    required this.fromJointIdController,
    required this.toJointIdController,
    required this.trenchingDepthController,
    required this.alignmentData,
    required this.file,
    required this.jointNumberData,
    required this.jointNumberList,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.fromJointData,
    required this.jointFromList,
    required this.jointToList,
    required this.toJointData,
    required this.chainageFromController,
    required this.chainageToController,
    required this.toWidthController,
    required this.soilTypeData,
    required this.soilTypeList,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    dateController,
    activityRemarkController,
    reportNumberController,
    terrainController,
    fromJointIdController,
    toJointIdController,
    trenchingDepthController,
    alignmentData,
    file,
    jointNumberData,
    jointNumberList,
    weatherList,
    weatherData,
    jointTypeData,
    jointTypeList,
    isJointNumberLoader,
    fromJointData,
    jointFromList,
    jointToList,
    toJointData,
    chainageFromController,
    chainageToController,
    toWidthController,
    soilTypeList,
    soilTypeData,
  ];
}