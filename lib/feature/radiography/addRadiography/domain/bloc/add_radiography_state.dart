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
  final TextEditingController locationDiscoverDefectController;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<SegmentModel> segmentList;
  final SegmentModel segmentData;
  final List<JointNumberModel> jointNumberList;
  final JointNumberModel jointNumberData;
  final List<NdtStatusModel> ndtAgencyList;
  final List<NdtStatusModel> meconPbgplList;
  final List<NdtStatusModel> dSPPLAgencyList;
  final NdtStatusModel ndtAgencyData;
  final NdtStatusModel meconPbgplData;
  final NdtStatusModel dSPPLAgencyData;

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
    required this.jointNumberList,
    required this.jointNumberData,
    required this.dSPPLAgencyData,
    required this.dSPPLAgencyList,
    required this.locationDiscoverDefectController,
    required this.meconPbgplData,
    required this.meconPbgplList,
    required this.ndtAgencyData,
    required this.ndtAgencyList
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
    jointNumberList,
    jointNumberData,
    dSPPLAgencyData,
    dSPPLAgencyList,
    locationDiscoverDefectController,
    meconPbgplData,
    meconPbgplList,
    ndtAgencyData,
    ndtAgencyList,
  ];
}
