part of 'add_ofc_splicing_bloc.dart';

abstract class AddOfcSplicingState extends Equatable {
  const AddOfcSplicingState();
}

class AddOfcSplicingInitial extends AddOfcSplicingState {
  @override
  List<Object> get props => [];
}

class AddOfcSplicingPageLoadState extends AddOfcSplicingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddOfcSplicingDataState extends AddOfcSplicingInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController jointPitController;
  final TextEditingController srNumberSplicingMachineController;
  final TextEditingController makeModelMachineController;
  final TextEditingController ofcDrumNoPlusDirectionController;
  final TextEditingController ofcDrumNoMinusDirectionController;
  final TextEditingController cableReadingPlusDirectionController;
  final TextEditingController cableReadingMinusDirectionController;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;

  FetchAddOfcSplicingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.chainageFromController,
    required this.chainageToController,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.jointPitController,
    required this.cableReadingMinusDirectionController,
    required this.cableReadingPlusDirectionController,
    required this.makeModelMachineController,
    required this.ofcDrumNoMinusDirectionController,
    required this.ofcDrumNoPlusDirectionController,
    required this.srNumberSplicingMachineController,
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
    file,
    weatherList,
    weatherData,
    jointTypeData,
    jointTypeList,
    isJointNumberLoader,
    jointPitController,
    cableReadingMinusDirectionController,
    cableReadingPlusDirectionController,
    makeModelMachineController,
    ofcDrumNoMinusDirectionController,
    ofcDrumNoPlusDirectionController,
    srNumberSplicingMachineController,
  ];
}