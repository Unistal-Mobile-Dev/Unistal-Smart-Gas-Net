part of 'add_cable_installation_bloc.dart';

@immutable
abstract class AddCableInstallationEvent extends Equatable {}

class AddCableInstallationPageLoadEvent extends AddCableInstallationEvent {
  final BuildContext context;
  AddCableInstallationPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddCableInstallationSelectDateEvent extends AddCableInstallationEvent {
  final BuildContext context;
  AddCableInstallationSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddCableInstallationSelectAlignmentEvent extends AddCableInstallationEvent {
   final AlignmentModel alignmentData;
  AddCableInstallationSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddCableInstallationMultipleSelectAlignmentEvent extends AddCableInstallationEvent {
  final List<AlignmentModel> alignmentData;
  AddCableInstallationMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends AddCableInstallationEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddTestStationBoxTLPTypeEvent extends AddCableInstallationEvent {
  final TlpTypeModel tlpTypeValue;
  AddTestStationBoxTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}


class AddTestStationBoxCableTrenchEvent extends AddCableInstallationEvent {
  final VisualChecksModel cableTrenchValue;
  AddTestStationBoxCableTrenchEvent({required this.cableTrenchValue});

  @override
  List<Object?> get props => [cableTrenchValue];
}

class AddTestStationBoxSandEvent extends AddCableInstallationEvent {
  final VisualChecksModel sandValue;
  AddTestStationBoxSandEvent({required this.sandValue});

  @override
  List<Object?> get props => [sandValue];
}

class AddTestStationBoxWarningEvent extends AddCableInstallationEvent {
  final VisualChecksModel warningValue;
  AddTestStationBoxWarningEvent({required this.warningValue});

  @override
  List<Object?> get props => [warningValue];
}

class AddTestStationBoxBackfillingEvent extends AddCableInstallationEvent {
  final VisualChecksModel backfillingValue;
  AddTestStationBoxBackfillingEvent({required this.backfillingValue});

  @override
  List<Object?> get props => [backfillingValue];
}

class AddTestStationBoxTaggingEvent extends AddCableInstallationEvent {
  final VisualChecksModel taggingValue;
  AddTestStationBoxTaggingEvent({required this.taggingValue});

  @override
  List<Object?> get props => [taggingValue];
}

class AddTestStationBoxRouteMarkingEvent extends AddCableInstallationEvent {
  final VisualChecksModel routeMarkingValue;
  AddTestStationBoxRouteMarkingEvent({required this.routeMarkingValue});

  @override
  List<Object?> get props => [routeMarkingValue];
}

class AddTestStationBoxIREvent extends AddCableInstallationEvent {
  final VisualChecksModel irValue;
  AddTestStationBoxIREvent({required this.irValue});

  @override
  List<Object?> get props => [irValue];
}

class AddCableInstallationAddImageEvent extends AddCableInstallationEvent {
  final BuildContext context;
  final int mediaType;
  AddCableInstallationAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class AddCableInstallationSubmitDataEvent extends AddCableInstallationEvent {
  final BuildContext context;
  AddCableInstallationSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
