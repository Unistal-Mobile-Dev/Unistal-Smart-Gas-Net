part of 'add_lpt_bloc.dart';

abstract class AddLptState extends Equatable {
  const AddLptState();
}

class AddLptInitial extends AddLptState {
  @override
  List<Object> get props => [];
}

class AddLptPageLoadState extends AddLptInitial {
  @override
  List<Object> get props => [];
}

class FetchAddLptDataState extends AddLptInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final JointNumberModel jointData;
  final List<JointNumberModel> jointList;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<LptStatusModel> lptStatusList;
  final LptStatusModel lptStatusData;

  FetchAddLptDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.jointData,
    required this.jointList,
    required this.lptStatusList,
    required this.lptStatusData,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    reportNumberController,
    alignmentData,
    file,
    weatherList,
    weatherData,
    jointTypeData,
    jointTypeList,
    isJointNumberLoader,
    jointData,
    jointList,
    lptStatusList,
    lptStatusData,
  ];
}
