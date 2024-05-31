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
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController calibarationDateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController modelController;
  final TextEditingController locationController;
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

  FetchAddLoweringDataState(
      {required this.isLoader,
      required this.alignmentList,
      required this.dateController,
      required this.activityRemarkController,
      required this.reportNumberController,
      required this.chainageFromController,
      required this.chainageToController,
      required this.postPaddingController,
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
      required this.modelController,
      required this.locationController,
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
      required this.pipeDialList});

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
      ];
}
