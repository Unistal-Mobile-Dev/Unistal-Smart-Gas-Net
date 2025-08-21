part of 'add_surge_diverter_bloc.dart';

@immutable
abstract class AddSurgeDiverterState extends Equatable{}

final class AddSurgeDiverterInitial extends AddSurgeDiverterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AddSurgeDiverterPageLoadState extends AddSurgeDiverterState {
  @override
  List<Object> get props => [];
}

class FetchAddSurgeDiverterState extends AddSurgeDiverterState {
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
  final VisualChecksModel cableConnectionValue;
  final List<VisualChecksModel> listOfCableConnection;
  final VisualChecksModel cableTerminationValue;
  final List<VisualChecksModel> listOfCableTermination;
  final VisualChecksModel backfillValue;
  final List<VisualChecksModel> listOfBackfill ;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController areaController;
  final TextEditingController chainageController;
  final TextEditingController locationController;
  final TextEditingController surgeDiverterController;
  final TextEditingController pspReadingProtectionController;
  final TextEditingController pspReadingOtherController;
  final TextEditingController polarityCheckController;
  final TextEditingController activityRemarkController;


  FetchAddSurgeDiverterState({
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
    required this.cableConnectionValue,
    required this.listOfCableConnection,
    required this.cableTerminationValue,
    required this.listOfCableTermination,
    required this.backfillValue,
    required this.listOfBackfill ,
    required this.dateController,
    required this.reportNumberController,
    required this.areaController,
    required this.chainageController,
    required this.locationController,
    required this.surgeDiverterController,
    required this.pspReadingProtectionController,
    required this.pspReadingOtherController,
    required this.polarityCheckController,
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
   installationValue,
   listOfInstallation,
   cableConnectionValue,
   listOfCableConnection,
   cableTerminationValue,
   listOfCableTermination,
   backfillValue,
   listOfBackfill ,
   dateController,
   reportNumberController,
   areaController,
   chainageController,
   locationController,
   surgeDiverterController,
   pspReadingProtectionController,
   pspReadingOtherController,
   polarityCheckController,
   activityRemarkController,
  ];
}

