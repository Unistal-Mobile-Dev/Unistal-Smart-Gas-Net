part of 'add_pre_hydrotest_bloc.dart';

abstract class AddPreHydrotestState extends Equatable {
  const AddPreHydrotestState();
}

class AddPreHydrotestInitial extends AddPreHydrotestState {
  @override
  List<Object> get props => [];
}

class AddPreHydrotestPageLoadState extends AddPreHydrotestInitial {
  @override
  List<Object> get props => [];
}

class FetchAddPreHydrotestDataState extends AddPreHydrotestInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController lengthController;
  final TextEditingController ndeClearanceController;
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
  final ThicknessModel thicknessData;
  final List<ThicknessModel> thicknessList;
  final TextEditingController pressureGaugeNoController;
  final TextEditingController pressureGaugeCalibrationDateController;
  final TextEditingController testPressureController;
  final TextEditingController rangeController;
  final TextEditingController pipeSizeController;
  final TextEditingController durationController;
  final TextEditingController timeOnController;
  final TextEditingController timeOffController;
  final TextEditingController timeInHoursController;
  final TextEditingController pressureReading1KGController;
  final TextEditingController pressureReading2KGController;
  final TextEditingController tempController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController reportNumberController;

  FetchAddPreHydrotestDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.lengthController,
    required this.ndeClearanceController,
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
    required this.toJointData,
    required this.thicknessData,
    required this.thicknessList,
    required this.durationController,
    required this.pipeSizeController,
    required this.pressureGaugeCalibrationDateController,
    required this.pressureGaugeNoController,
    required this.pressureReading1KGController,
    required this.pressureReading2KGController,
    required this.rangeController,
    required this.tempController,
    required this.testPressureController,
    required this.timeInHoursController,
    required this.timeOffController,
    required this.timeOnController,
    required this.chainageFromController,
    required this.chainageToController,
    required this.reportNumberController,
  });

  @override
  List<Object> get props => [
        isLoader,
        alignmentList,
        dateController,
        activityRemarkController,
        lengthController,
        ndeClearanceController,
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
        toJointData,
        thicknessData,
        thicknessList,
        durationController,
        pipeSizeController,
        pressureGaugeCalibrationDateController,
        pressureGaugeNoController,
        pressureReading1KGController,
        pressureReading2KGController,
        rangeController,
        tempController,
        testPressureController,
        timeInHoursController,
        timeOffController,
        timeOnController,
        chainageFromController,
        chainageToController,
        reportNumberController,
      ];
}
