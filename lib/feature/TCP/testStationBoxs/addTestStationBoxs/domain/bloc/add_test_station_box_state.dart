part of 'add_test_station_box_bloc.dart';

@immutable
abstract class AddTestStationBoxState extends Equatable {}

final class AddTestStationBoxInitial extends AddTestStationBoxState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AddTestStationBoxPageLoadState extends AddTestStationBoxState {
  @override
  List<Object> get props => [];
}

class FetchAddTestStationBoxState extends AddTestStationBoxState {
  final File file;
  final bool isLoader;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> alignmentList;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController chainageController;
  final TextEditingController areaController;
  final TextEditingController testStationLocationController;
  final TextEditingController testStationTypeController;
  final TextEditingController activityRemarkController;
  final List<TlpTypeModel> listOfTLPType;
  final TlpTypeModel tlpTypeValue;
  final List<VisualChecksModel> listOfDistance;
  final VisualChecksModel distanceValue;
  final List<VisualChecksModel> listOfFoundationCheck;
  final VisualChecksModel foundationCheckValue;
  final List<VisualChecksModel> listOfTSMounting;
  final VisualChecksModel tsMountingValue;
  final List<VisualChecksModel> listOfTSDoors;
  final VisualChecksModel tsDoorsValue;
  final List<VisualChecksModel> listOfCableEntrySealing;
  final VisualChecksModel cableEntrySealingValue;
  final List<VisualChecksModel> listOfCableTermination;
  final  VisualChecksModel cableTerminationValue;
  final List<VisualChecksModel> listOfNmePlate;
  final VisualChecksModel namePlateValue;
  final List<VisualChecksModel> listOfIndividualResistor;
  final VisualChecksModel individualResistorValue;
  final List<VisualChecksModel> listOfCompaction;
  final VisualChecksModel compactionValue;
  final List<VisualChecksModel> listOfCableSealing;
  final  VisualChecksModel cableSealingValue;

  FetchAddTestStationBoxState({
    required this.isLoader,
    required this.alignmentList,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.dateController,
    required this.reportNumberController,
    required this.chainageController,
    required this.areaController,
    required this.testStationLocationController,
    required this.testStationTypeController,
    required this.activityRemarkController,
    required this.listOfTLPType,
    required this.tlpTypeValue,
    required this.listOfDistance,
    required this.distanceValue,
    required this.listOfFoundationCheck,
    required this.foundationCheckValue,
    required this.listOfTSMounting,
    required this.tsMountingValue,
    required this.listOfTSDoors,
    required this.tsDoorsValue,
    required this.listOfCableEntrySealing,
    required this.cableEntrySealingValue,
    required this.listOfCableTermination,
    required this.cableTerminationValue,
    required this.listOfNmePlate,
    required this.namePlateValue,
    required this.listOfIndividualResistor,
    required this.individualResistorValue,
    required this.listOfCompaction,
    required this.compactionValue,
    required this.listOfCableSealing,
    required this.cableSealingValue,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    alignmentData,
    file,
    weatherList,
    weatherData,
    dateController,
    reportNumberController,
    chainageController,
    areaController,
    testStationLocationController,
    testStationTypeController,
    activityRemarkController,
    listOfTLPType,
    tlpTypeValue,
    listOfDistance,
    distanceValue,
    listOfFoundationCheck,
    foundationCheckValue,
    listOfTSMounting,
    tsMountingValue,
    listOfTSDoors,
    tsDoorsValue,
    listOfCableEntrySealing,
    cableEntrySealingValue,
    listOfCableTermination,
    cableTerminationValue,
    listOfNmePlate,
    namePlateValue,
    listOfIndividualResistor,
    individualResistorValue,
    listOfCompaction,
    compactionValue,
    listOfCableSealing,
    cableSealingValue,
  ];
}

