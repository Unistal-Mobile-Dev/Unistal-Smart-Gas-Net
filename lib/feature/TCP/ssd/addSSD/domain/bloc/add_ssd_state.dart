part of 'add_ssd_bloc.dart';

@immutable
abstract class AddSsdState extends Equatable{}

final class AddSsdInitial extends AddSsdState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AddSsdPageLoadState extends AddSsdState {
  @override
  List<Object> get props => [];
}

class FetchAddSsdState extends AddSsdState {
  final File file;
  final bool isLoader;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<TlpTypeModel> listOfTLPType;
  final TlpTypeModel tlpTypeValue;
  final VisualChecksModel installationValue;
  final List<VisualChecksModel> listOfInstallation;
  final VisualChecksModel cableTerminationValue;
  final List<VisualChecksModel> listOfCableTermination;
  final VisualChecksModel checkACVolValue;
  final List<VisualChecksModel> listOfCheckACVol;
  final VisualChecksModel pspValue;
  final List<VisualChecksModel> listOfPSP;
  final VisualChecksModel finalRestorationValue;
  final List<VisualChecksModel> listOfFinalRestoration;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController areaController;
  final TextEditingController chainageController;
  final TextEditingController locationController;
  final TextEditingController voltageController;
  final TextEditingController htTowerController;
  final TextEditingController activityRemarkController;


  FetchAddSsdState({
    required this.isLoader,
    required this.alignmentList,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.listOfTLPType,
    required this.tlpTypeValue,
    required this.installationValue,
    required this.listOfInstallation,
    required this.cableTerminationValue,
    required this.listOfCableTermination,
    required this.checkACVolValue,
    required this.listOfCheckACVol,
    required this.pspValue,
    required this.listOfPSP,
    required this.finalRestorationValue,
    required this.listOfFinalRestoration,
    required this.dateController,
    required this.reportNumberController,
    required this.areaController,
    required this.chainageController,
    required this.locationController,
    required this.voltageController,
    required this.htTowerController,
    required this.activityRemarkController,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    alignmentData,
    file,
    weatherList,
    weatherData,
    listOfTLPType,
    tlpTypeValue,
    installationValue,
    listOfInstallation,
    cableTerminationValue,
    listOfCableTermination,
    checkACVolValue,
    listOfCheckACVol,
    pspValue,
    listOfPSP,
    finalRestorationValue,
    listOfFinalRestoration,
    dateController,
    reportNumberController,
    areaController,
    chainageController,
    locationController,
    voltageController,
    htTowerController,
    activityRemarkController,
  ];
}

