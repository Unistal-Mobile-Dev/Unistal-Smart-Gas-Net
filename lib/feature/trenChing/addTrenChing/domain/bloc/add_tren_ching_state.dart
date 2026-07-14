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
  final TextEditingController activityRemarkController;
  final TextEditingController lengthController;
  final TextEditingController detailsStructureCtrl;
  final TextEditingController mimimumCoverCtrl;
  final TextEditingController arableSoilCtrl;
  final TextEditingController trenchProfileCtrl;
  final TextEditingController fromCtrl;
  final TextEditingController toCtrl;
  final TextEditingController ipFromCtrl;
  final TextEditingController ipToCtrl;
  final TextEditingController provisionOfWarningSignsSafetySignsCtrt;
  final TextEditingController seismicZoneAndCoverCtrl;
  final TextEditingController verificationOfMinimumDepthCtrl;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final File file;
  final List<JointNumberModel> jointNumberList;
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
  final TextEditingController bottomWidthController;
  final List<TerrainTypeModel> terrainTypeList;
  final TerrainTypeModel terrainTypeData;

  FetchAddTrenChingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.fromJointIdController,
    required this.toJointIdController,
    required this.trenchingDepthController,
    required this.alignmentData,
    required this.multipleAlignmentData,
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
    required this.bottomWidthController,
    required this.lengthController,
    required this.terrainTypeList,
    required this.terrainTypeData,
    required this.detailsStructureCtrl,
    required this.mimimumCoverCtrl,
    required this.arableSoilCtrl,
    required this.trenchProfileCtrl,
    required this.fromCtrl,
    required this.toCtrl,
    required this.ipFromCtrl,
    required this.ipToCtrl,
    required this.provisionOfWarningSignsSafetySignsCtrt,
    required this.seismicZoneAndCoverCtrl,
    required this.verificationOfMinimumDepthCtrl,
  });

  @override
  List<Object> get props => [
        alignmentList,
        isLoader,
        dateController,
        activityRemarkController,
        reportNumberController,
        fromJointIdController,
        toJointIdController,
        trenchingDepthController,
        alignmentData,
        multipleAlignmentData,
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
        bottomWidthController,
        lengthController,
        terrainTypeList,
        terrainTypeData,
        detailsStructureCtrl,
        mimimumCoverCtrl,
        arableSoilCtrl,
        trenchProfileCtrl,
        fromCtrl,
        toCtrl,
        ipFromCtrl,
        ipToCtrl,
        provisionOfWarningSignsSafetySignsCtrt,
        seismicZoneAndCoverCtrl,
        verificationOfMinimumDepthCtrl,
      ];
}
