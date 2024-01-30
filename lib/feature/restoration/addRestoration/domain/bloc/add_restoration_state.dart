part of 'add_restoration_bloc.dart';

abstract class AddRestorationState extends Equatable {
  const AddRestorationState();
}


class AddRestorationInitial extends AddRestorationState {
  @override
  List<Object> get props => [];
}

class AddRestorationPageLoadState extends AddRestorationInitial {
  @override
  List<Object> get props => [];
}

class FetchAddRestorationDataState extends AddRestorationInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController landTypeController;
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
  final VisualChecksModel removalOfSurplusMaterialData;
  final VisualChecksModel replacementofTopSoilData;
  final VisualChecksModel reinstallationBoundaryStonesData;
  final List<VisualChecksModel > removalOfSurplusMaterialList;
  final List<VisualChecksModel > replacementofTopSoilList;
  final List<VisualChecksModel > reinstallationBoundaryStonesList;

  FetchAddRestorationDataState({
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
    required this.landTypeController,
    required this.toJointData,
    required this.reinstallationBoundaryStonesData,
    required this.reinstallationBoundaryStonesList,
    required this.removalOfSurplusMaterialData,
    required this.removalOfSurplusMaterialList,
    required this.replacementofTopSoilData,
    required this.replacementofTopSoilList,
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
    landTypeController,
    toJointData,
    reinstallationBoundaryStonesData,
    reinstallationBoundaryStonesList,
    removalOfSurplusMaterialData,
    removalOfSurplusMaterialList,
    replacementofTopSoilData,
    replacementofTopSoilList,
  ];
}