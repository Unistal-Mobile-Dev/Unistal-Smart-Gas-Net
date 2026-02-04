part of 'add_surge_diverter_bloc.dart';

@immutable
abstract class AddSurgeDiverterEvent extends Equatable{}


class AddSurgeDiverterPageLoadEvent extends  AddSurgeDiverterEvent {
  final BuildContext context;
  AddSurgeDiverterPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddSurgeDiverterSelectDateEvent extends  AddSurgeDiverterEvent {
  final BuildContext context;
  AddSurgeDiverterSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddSurgeDiverterSelectAlignmentEvent extends  AddSurgeDiverterEvent {
 final AlignmentModel alignmentData;
  AddSurgeDiverterSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddSurgeDiverterMultipleSelectAlignmentEvent extends  AddSurgeDiverterEvent {
  final List<AlignmentModel> alignmentData;
  AddSurgeDiverterMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends  AddSurgeDiverterEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddSurgeDiverterTLPTypeEvent extends AddSurgeDiverterEvent {
  final TlpTypeModel tlpTypeValue;
  AddSurgeDiverterTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}

class AddSurgeDiverterInstallationEvent extends AddSurgeDiverterEvent {
  final VisualChecksModel installationValue;
  AddSurgeDiverterInstallationEvent({required this.installationValue});

  @override
  List<Object?> get props => [installationValue];
}

class AddSurgeDiverterCableConnectionEvent extends AddSurgeDiverterEvent {
  final VisualChecksModel cableConnectionValue;
  AddSurgeDiverterCableConnectionEvent({required this.cableConnectionValue});

  @override
  List<Object?> get props => [cableConnectionValue];
}

class AddSurgeDiverterCableTerminationEvent extends AddSurgeDiverterEvent {
  final VisualChecksModel cableTerminationValue;
  AddSurgeDiverterCableTerminationEvent({required this.cableTerminationValue});

  @override
  List<Object?> get props => [cableTerminationValue];
}

class AddSurgeDiverterBackfillEvent extends AddSurgeDiverterEvent {
  final VisualChecksModel backfillValue;
  AddSurgeDiverterBackfillEvent({required this.backfillValue});

  @override
  List<Object?> get props => [backfillValue];
}


class  AddSurgeDiverterAddImageEvent extends  AddSurgeDiverterEvent {
  final BuildContext context;
  final int mediaType;
  AddSurgeDiverterAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class  AddSurgeDiverterSubmitDataEvent extends  AddSurgeDiverterEvent {
  final BuildContext context;
  AddSurgeDiverterSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

