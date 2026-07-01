part of 'add_crossing_bloc.dart';

abstract class AddCrossingState extends Equatable {
  const AddCrossingState();
}

class AddCrossingInitial extends AddCrossingState {
  @override
  List<Object> get props => [];
}

class AddCrossingPageLoadState extends AddCrossingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddCrossingDataState extends AddCrossingInitial {
  final File file;
  final File fileStageInspection;
  final File filePreHydrotest;
  final File fileRestoration;
  final File filePhotoBefore;
  final File filePhotoAfter;
  final File fileVideoBefore;
  final File fileVideoAfter;
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController sectionLengthController;
  final TextEditingController casingPipeLengthController;
  final TextEditingController concreteCoatingLengthController;
  final TextEditingController crossingNameController;
  final TextEditingController locationController;
  final TextEditingController holidayTestNoController;
  final TextEditingController electrometerNoController;
  final TextEditingController batchNoController;
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
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<ThicknessModel> thicknessList;
  final ThicknessModel thicknessData;
  final List<PipeDiaModel> pipeDialList;
  final PipeDiaModel pipeDiaData;
  final List<CoatingTypeModel> coatingTypeList;
  final CoatingTypeModel coatingTypeData;
  final List<PaddingModel> prePaddingList;
  final PaddingModel prePaddingData;
  final List<PaddingModel> postPaddingList;
  final PaddingModel postPaddingData;
  final List<PipeMaterialModel> pipeMaterialList;
  final PipeMaterialModel pipeMaterialData;
  final List<VisualChecksModel> visualsChecksList;
  final VisualChecksModel visualChecksData;
  final List<CrossingTypeModel> crossingTyeList;
  final CrossingTypeModel crossingTypeData;
  final TextEditingController reportNumberController;

  FetchAddCrossingDataState({
    required this.file,
    required this.fileStageInspection,
    required this.filePreHydrotest,
    required this.fileRestoration,
    required this.filePhotoBefore,
    required this.filePhotoAfter,
    required this.fileVideoBefore,
    required this.fileVideoAfter,
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.onWeldController,
    required this.sectionLengthController,
    required this.casingPipeLengthController,
    required this.batchNoController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.fromJointData,
    required this.jointFromList,
    required this.jointToList,
    required this.concreteCoatingLengthController,
    required this.locationController,
    required this.toJointData,
    required this.holidayTestNoController,
    required this.holidayChecksData,
    required this.onBodyController,
    required this.holidayCheckList,
    required this.electrometerNoController,
    required this.crossingNameController,
    required this.surfaceController,
    required this.thicknessData,
    required this.thicknessList,
    required this.pipeDiaData,
    required this.pipeDialList,
    required this.coatingTypeData,
    required this.coatingTypeList,
    required this.prePaddingData,
    required this.prePaddingList,
    required this.pipeMaterialData,
    required this.pipeMaterialList,
    required this.visualChecksData,
    required this.visualsChecksList,
    required this.crossingTypeData,
    required this.crossingTyeList,
    required this.postPaddingData,
    required this.postPaddingList,
    required this.reportNumberController,
  });

  @override
  List<Object> get props => [
        file,
        fileStageInspection,
        filePreHydrotest,
        fileRestoration,
        filePhotoBefore,
        filePhotoAfter,
        fileVideoBefore,
        fileVideoAfter,
        isLoader,
        alignmentList,
        dateController,
        activityRemarkController,
        onWeldController,
        sectionLengthController,
        casingPipeLengthController,
        batchNoController,
        alignmentData,
        multipleAlignmentData,
        weatherList,
        weatherData,
        jointTypeData,
        jointTypeList,
        isJointNumberLoader,
        fromJointData,
        jointFromList,
        jointToList,
        concreteCoatingLengthController,
        locationController,
        toJointData,
        holidayTestNoController,
        holidayChecksData,
        onBodyController,
        holidayCheckList,
        electrometerNoController,
        crossingNameController,
        surfaceController,
        thicknessData,
        thicknessList,
        pipeDiaData,
        pipeDialList,
        coatingTypeData,
        coatingTypeList,
        prePaddingData,
        prePaddingList,
        pipeMaterialList,
        pipeMaterialData,
        visualChecksData,
        visualsChecksList,
        crossingTyeList,
        crossingTypeData,
        postPaddingData,
        postPaddingList,
        reportNumberController,
      ];
}
