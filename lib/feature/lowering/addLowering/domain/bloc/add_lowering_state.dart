part of 'add_lowering_bloc.dart';

abstract class AddLoweringState extends Equatable {
  const AddLoweringState();
}

class AddLoweringInitial extends AddLoweringState {
  @override
  List<Object> get props => [];
}

class AddLoweringPageLoadState extends AddLoweringInitial {
  @override
  List<Object> get props => [];
}

class FetchAddLoweringDataState extends AddLoweringInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController calibarationDateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController modelController;
  final TextEditingController locationController;
  final TextEditingController postPaddingCtrl;
  final TextEditingController holidayDetectorDetailsController;
  final TextEditingController testVoltageController;
  final TextEditingController repairCoatingController;
  final TextEditingController postPaddingController;
  final TextEditingController lengthController;
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
  final List<PipeDiaModel> pipeDialList;
  final PipeDiaModel pipeDiaData;
  final TerrainTypeModel jobNoValue;
  final TerrainTypeModel dewateringValue;
  final TerrainTypeModel paddingValue;
  final TerrainTypeModel paddingMaterialValue;
  final TerrainTypeModel loweringClearanceValue;
  final TerrainTypeModel approvedPipeValue;
  final TerrainTypeModel nightCapValue;
  final List<TerrainTypeModel> listOfJobNo;
  final List<TerrainTypeModel> listOfDewatering;
  final List<TerrainTypeModel> listOfPadding;
  final List<TerrainTypeModel> listOfPaddingMaterial;
  final List<TerrainTypeModel> listOfLoweringClearance;
  final List<TerrainTypeModel> listOfApprovedPipe;
  final List<TerrainTypeModel> listOfNightCap;

  FetchAddLoweringDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.chainageFromController,
    required this.chainageToController,
    required this.postPaddingController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.fromJointData,
    required this.jointFromList,
    required this.jointToList,
    required this.modelController,
    required this.locationController,
    required this.postPaddingCtrl,
    required this.toJointData,
    required this.holidayDetectorDetailsController,
    required this.holidayChecksData,
    required this.calibarationDateController,
    required this.holidayCheckList,
    required this.repairCoatingController,
    required this.testVoltageController,
    required this.lengthController,
    required this.thicknessData,
    required this.thicknessList,
    required this.pipeDiaData,
    required this.pipeDialList,
    required this.paddingValue,
    required this.dewateringValue,
    required this.paddingMaterialValue,
    required this.loweringClearanceValue,
    required this.approvedPipeValue,
    required this.nightCapValue,
    required this.listOfDewatering,
    required this.listOfPadding,
    required this.listOfPaddingMaterial,
    required this.listOfLoweringClearance,
    required this.listOfApprovedPipe,
    required this.listOfNightCap,
    required this.jobNoValue,
    required this.listOfJobNo,
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
        postPaddingController,
        alignmentData,
        multipleAlignmentData,
        file,
        weatherList,
        weatherData,
        jointTypeData,
        jointTypeList,
        isJointNumberLoader,
        fromJointData,
        jointFromList,
        jointToList,
        modelController,
        locationController,
        postPaddingCtrl,
        toJointData,
        holidayDetectorDetailsController,
        holidayChecksData,
        calibarationDateController,
        holidayCheckList,
        repairCoatingController,
        testVoltageController,
        lengthController,
        thicknessData,
        thicknessList,
        pipeDiaData,
        pipeDialList,
        dewateringValue,
        paddingValue,
        paddingMaterialValue,
        loweringClearanceValue,
        approvedPipeValue,
        nightCapValue,
        listOfDewatering,
        listOfPadding,
        listOfPaddingMaterial,
        listOfLoweringClearance,
        listOfApprovedPipe,
        listOfNightCap,
        jobNoValue,
        listOfJobNo,
      ];
}
