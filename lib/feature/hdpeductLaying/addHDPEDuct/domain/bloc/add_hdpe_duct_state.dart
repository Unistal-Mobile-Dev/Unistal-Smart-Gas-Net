part of 'add_hdpe_duct_bloc.dart';

abstract class AddHdpeDuctState extends Equatable {
  const AddHdpeDuctState();
}

class AddHdpeDuctInitial extends AddHdpeDuctState {
  @override
  List<Object> get props => [];
}

class AddHdpeDuctPageLoadState extends AddHdpeDuctInitial {
  @override
  List<Object> get props => [];
}

class FetchAddHdpeDuctDataState extends AddHdpeDuctInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController jointPitController;
  final TextEditingController lengthController;
  final PaddingModel warningMeterData;
  final List<PaddingModel> warningMeterList;
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
  final List<PaddingModel> paddingList;
  final PaddingModel paddingData;

  FetchAddHdpeDuctDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.chainageFromController,
    required this.chainageToController,
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
    required this.warningMeterData,
    required this.warningMeterList,
    required this.jointPitController,
    required this.toJointData,
    required this.paddingList,
    required this.paddingData,
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
        warningMeterData,
        warningMeterList,
        jointPitController,
        paddingList,
        paddingData,
      ];
}
