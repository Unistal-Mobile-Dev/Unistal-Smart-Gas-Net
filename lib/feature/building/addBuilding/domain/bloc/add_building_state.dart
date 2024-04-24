part of 'add_building_bloc.dart';

abstract class AddBuildingState extends Equatable {
  const AddBuildingState();
}

class AddBuildingInitial extends AddBuildingState {
  @override
  List<Object> get props => [];
}

class AddBuildingPageLoadState extends AddBuildingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddBuildingDataState extends AddBuildingInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController buildingCategoryControlller;
  final TextEditingController buildingNameController;
  final TextEditingController buildingNumberController;
  final TextEditingController gpsCoordinateNorthController;
  final TextEditingController gpsCoordinateEastController;
  final TextEditingController floorNoController;
  final TextEditingController locationController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController eastingLatController;
  final TextEditingController eastingLongController;
  final String accuracy;
  final TextEditingController flatNoController;
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

  FetchAddBuildingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.buildingCategoryControlller,
    required this.buildingNameController,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.isJointNumberLoader,
    required this.gpsCoordinateNorthController,
    required this.floorNoController,
    required this.locationController,
    required this.flatNoController,
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
    required this.buildingNumberController,
    required this.isAlignmentLoader,
    required this.buildingCategoryList,
    required this.buildingCategoryTypeData,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    reportNumberController,
    buildingCategoryControlller,
    buildingNameController,
    alignmentData,
    file,
    weatherList,
    weatherData,
    isJointNumberLoader,
    gpsCoordinateNorthController,
    floorNoController,
    locationController,
    flatNoController,
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
    buildingNumberController,
    isAlignmentLoader,
    buildingCategoryList,
    buildingCategoryTypeData,
  ];
}