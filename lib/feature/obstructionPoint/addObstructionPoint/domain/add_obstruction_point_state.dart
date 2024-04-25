part of 'add_obstruction_point_bloc.dart';

abstract class AddObstructionPointState extends Equatable {
  const AddObstructionPointState();
}

class AddObstructionPointInitial extends AddObstructionPointState {
  @override
  List<Object> get props => [];
}

class AddObstructionPointPageLoadState extends AddObstructionPointInitial {
  @override
  List<Object> get props => [];
}

class FetchAddObstructionPointDataState extends AddObstructionPointInitial {
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController buildingCategoryControlller;
  final TextEditingController typeController;
  final TextEditingController enterOtherController;
  final TextEditingController gpsCoordinateNorthController;
  final TextEditingController gpsCoordinateEastController;
  final TextEditingController floorNoController;
  final TextEditingController locationController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController eastingLatController;
  final TextEditingController eastingLongController;
  final String accuracy;
  final TextEditingController nameController;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<SpreadTypeModel> spreadList;
  final SpreadTypeModel spreadTypeData;
  final List<SectionTypeModel> sectionList;
  final SectionTypeModel sectionTypeData;
  final bool isAlignmentLoader;
  final List<BuildingCategoryTypeModel> buildingCategoryList;
  final BuildingCategoryTypeModel buildingCategoryTypeData;
  final List<ObstructionTypeModel> obstructionTypeList;
  final ObstructionTypeModel obstructionTypeData;

  FetchAddObstructionPointDataState({
    required this.isLoader,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.buildingCategoryControlller,
    required this.typeController,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.isJointNumberLoader,
    required this.gpsCoordinateNorthController,
    required this.floorNoController,
    required this.locationController,
    required this.nameController,
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
    required this.enterOtherController,
    required this.isAlignmentLoader,
    required this.buildingCategoryList,
    required this.buildingCategoryTypeData,
    required this.obstructionTypeData,
    required this.obstructionTypeList,
  });

  @override
  List<Object> get props => [
    isLoader,
    dateController,
    activityRemarkController,
    reportNumberController,
    buildingCategoryControlller,
    typeController,
    file,
    weatherList,
    weatherData,
    isJointNumberLoader,
    gpsCoordinateNorthController,
    floorNoController,
    locationController,
    nameController,
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
    enterOtherController,
    isAlignmentLoader,
    buildingCategoryList,
    buildingCategoryTypeData,
    obstructionTypeData,
    obstructionTypeList,
  ];
}