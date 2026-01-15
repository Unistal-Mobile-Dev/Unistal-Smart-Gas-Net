part of 'add_cable_installation_bloc.dart';

@immutable
abstract class AddCableInstallationState extends Equatable{}

final class AddCableInstallationInitial extends AddCableInstallationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddCableInstallationPageLoadState extends AddCableInstallationState {
@override
List<Object> get props => [];
}

class FetchAddCableInstallationState extends AddCableInstallationState {
  final File file;
  final bool isLoader;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<TlpTypeModel> listOfTLPType;
  final TlpTypeModel tlpTypeValue;
  final VisualChecksModel cableTrenchValue;
  final List<VisualChecksModel> listOfCableTrench;
  final VisualChecksModel sandValue;
  final List<VisualChecksModel> listOfSand;
  final VisualChecksModel warningValue;
  final List<VisualChecksModel> listOfWarning;
  final VisualChecksModel backfillingValue;
  final List<VisualChecksModel> listOfBackfilling;
  final VisualChecksModel taggingValue;
  final List<VisualChecksModel> listOfTagging;
  final VisualChecksModel routeMarkingValue;
  final List<VisualChecksModel> listOfRouteMarking;
  final VisualChecksModel irValue;
  final List<VisualChecksModel> listOfIR;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController areaController;
  final TextEditingController chainageController;
  final TextEditingController cableSizeController;
  final TextEditingController depthController;
  final TextEditingController activityRemarkController;


  FetchAddCableInstallationState({
    required this.file,
    required this.isLoader,
    required this.alignmentData,
    required this.alignmentList,
    required this.weatherList,
    required this.weatherData,
    required this.listOfTLPType,
    required this.tlpTypeValue,
    required this.cableTrenchValue,
    required this.listOfCableTrench,
    required this.sandValue,
    required this.listOfSand,
    required this.warningValue,
    required this.listOfWarning,
    required this.backfillingValue,
    required this.listOfBackfilling,
    required this.taggingValue,
    required this.listOfTagging,
    required this.routeMarkingValue,
    required this.listOfRouteMarking,
    required this.irValue,
    required this.listOfIR,
    required this.dateController,
    required this.reportNumberController,
    required this.areaController,
    required this.chainageController,
    required this.cableSizeController,
    required this.depthController,
    required this.activityRemarkController,
  });

  @override
  List<Object> get props => [
    file,
    isLoader,
    alignmentData,
    alignmentList,
    weatherList,
    weatherData,
    listOfTLPType,
    tlpTypeValue,
    cableTrenchValue,
    listOfCableTrench,
    sandValue,
    listOfSand,
    warningValue,
    listOfWarning,
    backfillingValue,
    listOfBackfilling,
    taggingValue,
    listOfTagging,
    routeMarkingValue,
    listOfRouteMarking,
    irValue,
    listOfIR,
    dateController,
    reportNumberController,
    areaController,
    chainageController,
    cableSizeController,
    depthController,
    activityRemarkController,
  ];
}

