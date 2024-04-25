part of 'add_right_way_bloc.dart';

abstract class AddRightWayState extends Equatable {
  const AddRightWayState();
}

class AddRightWayInitial extends AddRightWayState {
  @override
  List<Object> get props => [];
}

class AddRightWayPageLoadState extends AddRightWayInitial {
  @override
  List<Object> get props => [];
}

class FetchAddRightWayDataState extends AddRightWayInitial {
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController roadLengthController;
  final TextEditingController otherController;
  final TextEditingController roadNameController;
  final TextEditingController gpsCoordinateNorthController;
  final TextEditingController gpsCoordinateEastController;
  final TextEditingController roadWidthController;
  final TextEditingController locationController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController eastingLatController;
  final TextEditingController eastingLongController;
  final String accuracy;
  final TextEditingController materialTypeController;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<SpreadTypeModel> spreadList;
  final SpreadTypeModel spreadTypeData;
  final List<SectionTypeModel> sectionList;
  final SectionTypeModel sectionTypeData;
  final bool isAlignmentLoader;
  final String rodeSideValue;
  final List<RoadTypeModel> roadTypeList;
  final RoadTypeModel roadTypeData;

  FetchAddRightWayDataState({
    required this.isLoader,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.roadLengthController,
    required this.otherController,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.isJointNumberLoader,
    required this.gpsCoordinateNorthController,
    required this.roadWidthController,
    required this.locationController,
    required this.materialTypeController,
    required this.gpsCoordinateEastController,
    required this.eastingLatController,
    required this.eastingLongController,
    required this.latitudeController,
    required this.longitudeController,
    required this.accuracy,
    required this.sectionTypeData,
    required this.sectionList,
    required this.spreadList,
    required this.spreadTypeData,
    required this.roadNameController,
    required this.isAlignmentLoader,
    required this.rodeSideValue,
    required this.roadTypeData,
    required this.roadTypeList,
  });

  @override
  List<Object> get props => [
    isLoader,
    dateController,
    activityRemarkController,
    reportNumberController,
    roadLengthController,
    otherController,
    file,
    weatherList,
    weatherData,
    isJointNumberLoader,
    gpsCoordinateNorthController,
    roadWidthController,
    locationController,
    materialTypeController,
    gpsCoordinateEastController,
    eastingLatController,
    eastingLongController,
    latitudeController,
    longitudeController,
    accuracy,
    sectionTypeData,
    sectionList,
    spreadList,
    spreadTypeData,
    roadNameController,
    isAlignmentLoader,
    rodeSideValue,
    roadTypeData,
    roadTypeList,
  ];
}