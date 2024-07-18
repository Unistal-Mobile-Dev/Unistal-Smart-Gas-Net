part of 'add_polarisation_coupan_bloc.dart';

@immutable
abstract class AddPolarisationCoupanState extends Equatable {}

final class AddPolarisationCoupanInitial extends AddPolarisationCoupanState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AddPolarisationCoupanPageLoadState extends AddPolarisationCoupanState {
  @override
  List<Object> get props => [];
}

class FetchAddPolarisationCoupanState extends AddPolarisationCoupanState {
  final File file;
  final bool isLoader;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<TlpTypeModel> listOfTLPType;
  final TlpTypeModel tlpTypeValue;
  final VisualChecksModel corrosionValue;
  final List<VisualChecksModel> listOfCorrosion;
  final VisualChecksModel cableTerminationValue;
  final List<VisualChecksModel> listOfCableTermination;
  final TextEditingController dateController;
  final TextEditingController chainageController;
  final TextEditingController areaController;
  final TextEditingController testStationLocationController;
  final TextEditingController distanceController;
  final TextEditingController pspMeasurementController;
  final TextEditingController couponController;
  final TextEditingController digitalController;
  final TextEditingController modelController;
  final TextEditingController makeController;
  final TextEditingController dateCalibrationController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;


  FetchAddPolarisationCoupanState({
    required this.isLoader,
    required this.alignmentList,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.listOfTLPType,
    required this.tlpTypeValue,
    required this.corrosionValue,
    required this.listOfCorrosion,
    required this.cableTerminationValue,
    required this.listOfCableTermination,
    required this.dateController,
    required this.chainageController,
    required this.areaController,
    required this.testStationLocationController,
    required this.distanceController,
    required this.pspMeasurementController,
    required this.couponController,
    required this.digitalController,
    required this.modelController,
    required this.makeController,
    required this.dateCalibrationController,
    required this.reportNumberController,
    required this.activityRemarkController,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    alignmentData,
    file,
    weatherList,
    weatherData,
    listOfTLPType,
    tlpTypeValue,
    corrosionValue,
    listOfCorrosion,
    cableTerminationValue,
    listOfCableTermination,
    dateController,
    chainageController,
    areaController,
    testStationLocationController,
    distanceController,
    pspMeasurementController,
    couponController,
    digitalController,
    modelController,
    makeController,
    dateCalibrationController,
    reportNumberController,
    activityRemarkController,
  ];
}


