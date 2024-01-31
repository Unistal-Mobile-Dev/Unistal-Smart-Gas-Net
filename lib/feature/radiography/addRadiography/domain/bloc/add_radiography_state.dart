part of 'add_radiography_bloc.dart';

abstract class AddRadiographyState extends Equatable {
  const AddRadiographyState();
}

class AddRadiographyInitial extends AddRadiographyState {
  @override
  List<Object> get props => [];
}

class AddRadiographyPageLoadState extends AddRadiographyInitial {
  @override
  List<Object> get props => [];
}

class FetchAddRadiographyDataState extends AddRadiographyInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<SegmentModel> segmentList;
  final SegmentModel segmentData;

  FetchAddRadiographyDataState({
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
    required this.segmentList,
    required this.segmentData,
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
    segmentList,
    segmentData,
  ];
}
