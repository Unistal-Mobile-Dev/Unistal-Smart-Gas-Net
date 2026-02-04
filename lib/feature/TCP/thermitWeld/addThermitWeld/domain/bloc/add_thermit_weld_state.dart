part of 'add_thermit_weld_bloc.dart';

@immutable
abstract class AddThermitWeldState extends Equatable{}

final class AddThermitWeldInitial extends AddThermitWeldState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddThermitWeldPageLoadState extends AddThermitWeldState {
  @override
  List<Object> get props => [];
}

class FetchAddThermitWeldState extends AddThermitWeldState {
  final File file;
  final bool isLoader;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<TlpTypeModel> listOfTLPType;
  final TlpTypeModel tlpTypeValue;
  final VisualChecksModel pinBrazingValue;
  final List<VisualChecksModel> listOfPinBrazing;
  final VisualChecksModel continuityCheckValue;
  final List<VisualChecksModel> listOfContinuityCheck;
  final VisualChecksModel restorationCheckValue;
  final List<VisualChecksModel> listOfRestorationCheck;
  final TextEditingController dateController;
  final TextEditingController areaController;
  final TextEditingController chainageController;
  final TextEditingController testStationLocationController;
  final TextEditingController testStationTypeController;
  final TextEditingController spacingController;
  final TextEditingController cableController;
  final TextEditingController epoxyController;
  final TextEditingController cableSizeController;
  final TextEditingController cableLengthController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;


  FetchAddThermitWeldState({
    required this.file,
    required this.isLoader,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.alignmentList,
    required this.weatherList,
    required this.weatherData,
    required this.listOfTLPType,
    required this.tlpTypeValue,
    required this.pinBrazingValue,
    required this.listOfPinBrazing,
    required this.continuityCheckValue,
    required this.listOfContinuityCheck,
    required this.restorationCheckValue,
    required this.listOfRestorationCheck,
    required this.dateController,
    required this.areaController,
    required this.chainageController,
    required this.testStationLocationController,
    required this.testStationTypeController,
    required this.spacingController,
    required this.cableController,
    required this.epoxyController,
    required this.cableSizeController,
    required this.cableLengthController,
    required this.reportNumberController,
    required this.activityRemarkController,
  });

  @override
  List<Object> get props => [
    file,
    isLoader,
    alignmentData,
    multipleAlignmentData,
    alignmentList,
    weatherList,
    weatherData,
    listOfTLPType,
    tlpTypeValue,
    pinBrazingValue,
    listOfPinBrazing,
    continuityCheckValue,
    listOfContinuityCheck,
    restorationCheckValue,
    listOfRestorationCheck,
    dateController,
    areaController,
    chainageController,
    testStationLocationController,
    testStationTypeController,
    spacingController,
    cableController,
    epoxyController,
    cableSizeController,
    cableLengthController,
    reportNumberController,
    activityRemarkController,
  ];
}


