part of 'add_ofc_blowing_bloc.dart';

abstract class AddOFCBlowingState extends Equatable {
  const AddOFCBlowingState();
}

class AddOFCBlowingInitial extends AddOFCBlowingState {
  @override
  List<Object> get props => [];
}

class AddOFCBlowingPageLoadState extends AddOFCBlowingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddOFCBlowingDataState extends AddOFCBlowingInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController lengthController;
  final TextEditingController ofcDrumNoController;
  final TextEditingController ofcDrumLengthController;
  final TextEditingController smmController;
  final TextEditingController pitCableLengthController;
  final TextEditingController loopPitController;
  final TextEditingController locationBPController;
  final TextEditingController activityRemarkController;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<JointNumberModel> listOfFromJoint;
  final List<JointNumberModel> listOfToJoint;
  final JointNumberModel fromJointValue;
  final JointNumberModel toJointValue;



  FetchAddOFCBlowingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.reportNumberController,
    required this.chainageFromController,
    required this.chainageToController,
    required this.lengthController,
    required this.ofcDrumNoController,
    required this.ofcDrumLengthController,
    required this.smmController,
    required this.pitCableLengthController,
    required this.loopPitController,
    required this.locationBPController,
    required this.activityRemarkController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.listOfFromJoint,
    required this.listOfToJoint,
    required this.fromJointValue,
    required this.toJointValue,
  });

  @override
  List<Object> get props => [
        alignmentList,
        isLoader,
        dateController,
        reportNumberController,
    chainageFromController,
    chainageToController,
        lengthController,
        ofcDrumNoController,
        ofcDrumLengthController,
        smmController,
        pitCableLengthController,
        loopPitController,
        locationBPController,
        activityRemarkController,
        alignmentData,
        multipleAlignmentData,
        file,
        weatherList,
        weatherData,
    listOfFromJoint,
    listOfToJoint,
    fromJointValue,
    toJointValue,
  ];
}
