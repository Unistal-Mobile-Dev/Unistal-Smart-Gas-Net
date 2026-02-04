part of 'add_levelling_bloc.dart';

abstract class AddLevellingState extends Equatable {
  const AddLevellingState();
}

class AddLevellingInitial extends AddLevellingState {
  @override
  List<Object> get props => [];
}

class AddLevellingPageLoadState extends AddLevellingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddLevellingDataState extends AddLevellingInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController gpsCoordinateNorthController;
  final TextEditingController gpsCoordinateEastController;
  final TextEditingController elevationPipetopController;
  final TextEditingController natureGroundLeveController;
  final TextEditingController northingLatController;
  final TextEditingController northingLongController;
  final TextEditingController eastingLatController;
  final TextEditingController eastingLongController;
  final String accuracy;
  final TextEditingController coverController;
  final JointNumberModel jointData;
  final List<JointNumberModel> jointList;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;

  FetchAddLevellingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.chainageFromController,
    required this.chainageToController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.jointData,
    required this.jointList,
    required this.gpsCoordinateNorthController,
    required this.elevationPipetopController,
    required this.natureGroundLeveController,
    required this.coverController,
    required this.gpsCoordinateEastController,
    required this.eastingLatController,
    required this.eastingLongController,
    required this.northingLatController,
    required this.northingLongController,
    required this.accuracy,
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
        jointData,
        jointList,
        gpsCoordinateNorthController,
        elevationPipetopController,
        natureGroundLeveController,
        coverController,
        gpsCoordinateEastController,
        eastingLatController,
        eastingLongController,
        northingLatController,
        northingLongController,
        accuracy,
      ];
}
