part of 'add_marker_bloc.dart';

abstract class AddMarkerState extends Equatable {
  const AddMarkerState();
}

class AddMarkerInitial extends AddMarkerState {
  @override
  List<Object> get props => [];
}

class AddMarkerPageLoadState extends AddMarkerInitial {
  @override
  List<Object> get props => [];
}

class FetchAddMarkerDataState extends AddMarkerInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController primaryAbatchController;
  final TextEditingController primaryBbatchController;
  final TextEditingController locationController;
  final TextEditingController holidayTestNoController;
  final TextEditingController surfacePreparationController;
  final TextEditingController descriptionController;
  final TextEditingController surfaceController;
  final TextEditingController onBodyController;
  final TextEditingController onWeldController;
  final HolidayChecksModel holidayChecksData;
  final List<HolidayChecksModel> holidayCheckList;
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
  final List<ThicknessModel> thicknessList;
  final ThicknessModel thicknessData;
  final ThicknessModel coatingThicknessData;
  final List<PipeDiaModel> pipeDialList;
  final PipeDiaModel pipeDiaData;
  final List<CoatingTypeModel> coatingTypeList;
  final CoatingTypeModel coatingTypeData;
  final List<PaddingModel > peelTestList;
  final PaddingModel peelTestData;
  final List<PipeMaterialModel> pipeMaterialList;
  final PipeMaterialModel pipeMaterialData;
  final List<VisualChecksModel> visualsChecksList;
  final VisualChecksModel visualChecksData;
  final List<MarkerTypeModel> markerTypeList;
  final MarkerTypeModel markerTypeData;
  final List<SpreadTypeModel> spreadList;
  final SpreadTypeModel spreadTypeData;
  final List<SectionTypeModel> sectionList;
  final SectionTypeModel sectionTypeData;

  FetchAddMarkerDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.onWeldController,
    required this.chainageFromController,
    required this.chainageToController,
    required this.descriptionController,
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
    required this.primaryAbatchController,
    required this.locationController,
    required this.toJointData,
    required this.holidayTestNoController,
    required this.holidayChecksData,
    required this.onBodyController,
    required this.holidayCheckList,
    required this.surfacePreparationController,
    required this.primaryBbatchController,
    required this.surfaceController,
    required this.thicknessData,
    required this.thicknessList,
    required this.pipeDiaData,
    required this.pipeDialList,
    required this.coatingTypeData,
    required this.coatingTypeList,
    required this.peelTestData,
    required this.peelTestList,
    required this.pipeMaterialData,
    required this.pipeMaterialList,
    required this.visualChecksData,
    required this.visualsChecksList,
    required this.coatingThicknessData,
    required this.markerTypeData,
    required this.markerTypeList,
    required this.sectionTypeData,
    required this.sectionList,
    required this.spreadList,
    required this.spreadTypeData,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    onWeldController,
    chainageFromController,
    chainageToController,
    descriptionController,
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
    primaryAbatchController,
    locationController,
    toJointData,
    holidayTestNoController,
    holidayChecksData,
    onBodyController,
    holidayCheckList,
    surfacePreparationController,
    primaryBbatchController,
    surfaceController,
    thicknessData,
    thicknessList,
    pipeDiaData,
    pipeDialList,
    coatingTypeData,
    coatingTypeList,
    peelTestData,
    peelTestList,
    pipeMaterialList,
    pipeMaterialData,
    visualChecksData,
    visualsChecksList,
    coatingThicknessData,
    markerTypeData,
    markerTypeList,
    sectionTypeData,
    sectionList,
    spreadList,
    spreadTypeData,
  ];
}
