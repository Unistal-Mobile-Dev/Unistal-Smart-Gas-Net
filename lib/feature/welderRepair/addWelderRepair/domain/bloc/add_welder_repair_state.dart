part of 'add_welder_repair_bloc.dart';

abstract class AddWelderRepairState extends Equatable {
  const AddWelderRepairState();
}

class AddWelderRepairInitial extends AddWelderRepairState {
  @override
  List<Object> get props => [];
}

class AddWelderRepairPageLoadState extends AddWelderRepairInitial {
  @override
  List<Object> get props => [];
}

class FetchAddWelderRepairDataState extends AddWelderRepairInitial {
  final List<WelderModel> welderList;
  final WelderModel welderData;
  final List<WPSModel> wpsTypeList;
  final WPSModel wpsTypeData;
  final List<SegmentModel> segmentStatusList;
  final List<SegmentModel> selectedSegmentStatusList;
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController preHeatingTemperatureController;
  final TextEditingController e6010Controller;
  final TextEditingController e8010P1Controller;
  final TextEditingController e9045P2Controller;
  final TextEditingController er70s6Controller;
  final TextEditingController e81TM21ABController;
  final File file;
  final bool isLoader;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final List<JointNumberModel> jointNumberList;
  final JointNumberModel jointNumberData;
  final List<VisualChecksModel> weldVisualList;
  final VisualChecksModel weldVisualData;
  final bool isJointNumberLoader;
  final bool isWelderLoader;

  FetchAddWelderRepairDataState({
    required this.welderData,
    required this.welderList,
    required this.wpsTypeData,
    required this.wpsTypeList,
    required this.segmentStatusList,
    required this.selectedSegmentStatusList,
    required this.dateController,
    required this.file,
    required this.activityRemarkController,
    required this.alignmentData,
    required this.alignmentList,
    required this.e81TM21ABController,
    required this.e6010Controller,
    required this.e8010P1Controller,
    required this.e9045P2Controller,
    required this.er70s6Controller,
    required this.isLoader,
    required this.weatherData,
    required this.weatherList,
    required this.jointNumberList,
    required this.jointNumberData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.weldVisualList,
    required this.weldVisualData,
    required this.isJointNumberLoader,
    required this.isWelderLoader,
    required this.preHeatingTemperatureController,
  });

  @override
  List<Object> get props => [
        welderData,
        welderList,
        wpsTypeData,
        wpsTypeList,
        segmentStatusList,
        selectedSegmentStatusList,
        dateController,
        file,
        activityRemarkController,
        alignmentData,
        alignmentList,
        e81TM21ABController,
        e6010Controller,
        e8010P1Controller,
        e9045P2Controller,
        er70s6Controller,
        isLoader,
        weatherData,
        weatherList,
        jointNumberList,
        jointNumberData,
        jointTypeData,
        jointTypeList,
    weldVisualList,
    weldVisualData,
        isJointNumberLoader,
        isWelderLoader,
        preHeatingTemperatureController,
      ];
}
