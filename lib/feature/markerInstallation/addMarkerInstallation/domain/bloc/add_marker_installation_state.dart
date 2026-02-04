part of 'add_marker_installation_bloc.dart';

@immutable
abstract class AddMarkerInstallationState extends Equatable{}

class AddMarkerInstallationInitial extends AddMarkerInstallationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddMarkerInstallationPageLoadState extends AddMarkerInstallationState {
  @override
  List<Object> get props => [];
}

class FetchAddMarkerInstallationDataState extends AddMarkerInstallationState {
  final File file;
  final bool isLoader;
  final List<JointTypeModel> listOfJointType;
  final JointTypeModel jointTypeDataValue;
  final List<MarkerTypeModel> listOfMarkerType;
  final MarkerTypeModel markerTypeDataValue;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<JointNumberModel> listOfJoint;
  final JointNumberModel jointValue;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController chainageController;
  final TextEditingController descriptionController;
  final TextEditingController activityRemarkController;


  FetchAddMarkerInstallationDataState({
    required this.isLoader,
    required this.jointTypeDataValue,
    required this.listOfJointType,
    required this.alignmentList,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.listOfJoint,
    required this.jointValue,
    required this.dateController,
    required this.reportNumberController,
    required this.chainageController,
    required this.activityRemarkController,
    required this.descriptionController,
    required this.listOfMarkerType,
    required this.markerTypeDataValue,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    jointTypeDataValue,
    listOfJointType,
    alignmentData,
    multipleAlignmentData,
    file,
    weatherList,
    weatherData,
    listOfJoint,
    jointValue,
    dateController,
    reportNumberController,
    chainageController,
    activityRemarkController,
    descriptionController,
   listOfMarkerType,
    markerTypeDataValue,
  ];
}



