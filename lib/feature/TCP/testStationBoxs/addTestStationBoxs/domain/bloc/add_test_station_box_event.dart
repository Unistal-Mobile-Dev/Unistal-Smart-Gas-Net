part of 'add_test_station_box_bloc.dart';

@immutable
abstract class AddTestStationBoxEvent extends Equatable{}


class AddTestStationBoxPageLoadEvent extends  AddTestStationBoxEvent {
  final BuildContext context;
  AddTestStationBoxPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddTestStationBoxSelectDateEvent extends  AddTestStationBoxEvent {
  final BuildContext context;
  AddTestStationBoxSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddTestStationBoxSelectAlignmentEvent extends  AddTestStationBoxEvent {
 final AlignmentModel alignmentData;
  AddTestStationBoxSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class  AddTestStationBoxMultipleSelectAlignmentEvent extends  AddTestStationBoxEvent {
  final List<AlignmentModel> alignmentData;
  AddTestStationBoxMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends  AddTestStationBoxEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddTestStationBoxTLPTypeEvent extends AddTestStationBoxEvent {
  final TlpTypeModel tlpTypeValue;
  AddTestStationBoxTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}


class AddTestStationBoxDistanceEvent extends AddTestStationBoxEvent {
  final VisualChecksModel distanceValue;
  AddTestStationBoxDistanceEvent({required this.distanceValue});

  @override
  List<Object?> get props => [distanceValue];
}

class AddTestStationBoxFoundationCheckEvent extends AddTestStationBoxEvent {
  final VisualChecksModel foundationCheckValue;
  AddTestStationBoxFoundationCheckEvent({required this.foundationCheckValue});

  @override
  List<Object?> get props => [foundationCheckValue];
}

class AddTestStationBoxTestStationMountingEvent extends AddTestStationBoxEvent {
  final VisualChecksModel tsMountingValue;
  AddTestStationBoxTestStationMountingEvent({required this.tsMountingValue});

  @override
  List<Object?> get props => [tsMountingValue];
}

class AddTestStationBoxTestStationDoorsEvent extends AddTestStationBoxEvent {
  final VisualChecksModel tsDoorsValue;
  AddTestStationBoxTestStationDoorsEvent({required this.tsDoorsValue});

  @override
  List<Object?> get props => [tsDoorsValue];
}

class AddTestStationBoxCableEntrySealingEvent extends AddTestStationBoxEvent {
  final VisualChecksModel cableEntrySealingValue;
  AddTestStationBoxCableEntrySealingEvent({required this.cableEntrySealingValue});

  @override
  List<Object?> get props => [cableEntrySealingValue];
}

class AddTestStationBoxCableTerminationEvent extends AddTestStationBoxEvent {
  final VisualChecksModel cableTerminationValue;
  AddTestStationBoxCableTerminationEvent({required this.cableTerminationValue});

  @override
  List<Object?> get props => [cableTerminationValue];
}

class AddTestStationBoxNamePlateEvent extends AddTestStationBoxEvent {
  final VisualChecksModel namePlateValue;
  AddTestStationBoxNamePlateEvent({required this.namePlateValue});

  @override
  List<Object?> get props => [namePlateValue];
}

class AddTestStationBoxIndividualResistorEvent extends AddTestStationBoxEvent {
  final VisualChecksModel individualResistorValue;
  AddTestStationBoxIndividualResistorEvent({required this.individualResistorValue});

  @override
  List<Object?> get props => [individualResistorValue];
}


class AddTestStationBoxCompactionEvent extends AddTestStationBoxEvent {
  final VisualChecksModel compactionValue;
  AddTestStationBoxCompactionEvent({required this.compactionValue});

  @override
  List<Object?> get props => [compactionValue];
}
class AddTestStationBoxCableSealingEvent extends AddTestStationBoxEvent {
  final VisualChecksModel cableSealingValue;
  AddTestStationBoxCableSealingEvent({required this.cableSealingValue});

  @override
  List<Object?> get props => [cableSealingValue];
}


class  AddTestStationBoxAddImageEvent extends  AddTestStationBoxEvent {
  final BuildContext context;
  final int mediaType;
  AddTestStationBoxAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class  AddTestStationBoxSubmitDataEvent extends  AddTestStationBoxEvent {
  final BuildContext context;
  AddTestStationBoxSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
