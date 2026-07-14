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
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController postPaddingController;
  final TextEditingController warningMatController;
  final TextEditingController antiBuoyancyController;
  final TextEditingController lengthController;
  final TextEditingController recordingPipelineCtrl;
  final TextEditingController gratingsCtrl;
  final TextEditingController slopeBreakerCtrl;
  final TextEditingController locationCtrl;
  final TextEditingController minimumCoverCtrl;
  final TextEditingController hdpeDuctCtrl;
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
  final List<ThicknessModel> thicknessList;
  final ThicknessModel thicknessData;
  final List<PipeDiaModel> pipeDialList;
  final PipeDiaModel pipeDiaData;
  final TerrainTypeModel paddingValue;
  final List<TerrainTypeModel> listOfPadding;

  FetchAddBackFillingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.chainageFromController,
    required this.chainageToController,
    required this.recordingPipelineCtrl,
    required this.gratingsCtrl,
    required this.slopeBreakerCtrl,
    required this.locationCtrl,
    required this.minimumCoverCtrl,
    required this.hdpeDuctCtrl,
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
    required this.plasticGratingData,
    required this.plasticGratingList,
    required this.postPaddingController,
    required this.toJointData,
    required this.warningMatController,
    required this.antiBuoyancyController,
    required this.thicknessData,
    required this.thicknessList,
    required this.pipeDiaData,
    required this.lengthController,
    required this.pipeDialList,
    required this.paddingValue,
    required this.listOfPadding,
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
        toJointData,
        plasticGratingData,
        plasticGratingList,
        postPaddingController,
        warningMatController,
        antiBuoyancyController,
        thicknessData,
        thicknessList,
        pipeDiaData,
        pipeDialList,
        lengthController,
        recordingPipelineCtrl,
        gratingsCtrl,
        slopeBreakerCtrl,
        locationCtrl,
        minimumCoverCtrl,
        hdpeDuctCtrl,
        paddingValue,
        listOfPadding,
      ];
}
