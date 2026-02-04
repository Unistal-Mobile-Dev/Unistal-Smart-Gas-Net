part of 'add_hdpe_duct_testing_bloc.dart';

abstract class AddHdpeDuctTestingState extends Equatable {
  const AddHdpeDuctTestingState();
}

class AddHdpeDuctTestingInitial extends AddHdpeDuctTestingState {
  @override
  List<Object> get props => [];
}

class AddHdpeDuctTestingPageLoadState extends AddHdpeDuctTestingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddHdpeDuctTestingDataState extends AddHdpeDuctTestingInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController lengthController;
  final TextEditingController ductCleaningController;
  final TextEditingController ductIntegrityTestController;
  final TextEditingController airPressureTestController;
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

  FetchAddHdpeDuctTestingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.reportNumberController,
    required this.activityRemarkController,
    required this.lengthController,
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
    required this.toJointData,
    required this.airPressureTestController,
    required this.ductCleaningController,
    required this.ductIntegrityTestController,
  });

  @override
  List<Object> get props => [
        isLoader,
        alignmentList,
        dateController,
        reportNumberController,
        activityRemarkController,
        lengthController,
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
        airPressureTestController,
        ductCleaningController,
        ductIntegrityTestController,
      ];
}
