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
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
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
  final List<NdtSourceModel> ndtSourceList;
  final NdtSourceModel ndtSourceData;
  final TextEditingController chainageController;
  final TextEditingController filmTypeController;
  final TextEditingController inspectTechniqueController;
  final TextEditingController sensivityController;
  final TextEditingController densityController;
  final TextEditingController equipmentController;
  final WPSModel wpsTypeData;
  final List<WPSModel> wpsTypeList;
  final List<TerrainTypeModel> inspectionTechniqueList;
  final TerrainTypeModel inspectionVal;

  FetchAddRadiographyDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.alignmentData,
    required this.multipleAlignmentData,
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
    required this.ndtAgencyList,
    required this.ndtSourceData,
    required this.ndtSourceList,
    required this.chainageController,
    required this.densityController,
    required this.equipmentController,
    required this.filmTypeController,
    required this.inspectTechniqueController,
    required this.sensivityController,
    required this.wpsTypeData,
    required this.wpsTypeList,
    required this.inspectionTechniqueList,
    required this.inspectionVal,
  });

  @override
  List<Object> get props => [
        isLoader,
        alignmentList,
        dateController,
        activityRemarkController,
        reportNumberController,
        alignmentData,
        multipleAlignmentData,
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
        ndtSourceList,
        ndtSourceData,
        chainageController,
        densityController,
        equipmentController,
        filmTypeController,
        inspectTechniqueController,
        sensivityController,
        wpsTypeData,
        wpsTypeList,
        inspectionTechniqueList,
        inspectionVal,

      ];
}
