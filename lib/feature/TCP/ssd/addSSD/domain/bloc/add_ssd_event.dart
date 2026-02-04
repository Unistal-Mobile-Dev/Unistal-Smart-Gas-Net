part of 'add_ssd_bloc.dart';

@immutable
abstract class AddSsdEvent extends Equatable{}


class  AddSsdPageLoadEvent extends  AddSsdEvent {
  final BuildContext context;
  AddSsdPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddSsdSelectDateEvent extends  AddSsdEvent {
  final BuildContext context;
  AddSsdSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddSsdSelectAlignmentEvent extends  AddSsdEvent {
 final AlignmentModel alignmentData;
  AddSsdSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class  AddSsdMultipleSelectAlignmentEvent extends  AddSsdEvent {
  final List<AlignmentModel> alignmentData;
  AddSsdMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends  AddSsdEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddSsdTLPTypeEvent extends AddSsdEvent {
  final TlpTypeModel tlpTypeValue;
  AddSsdTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}

class AddSsdInstallationEvent extends AddSsdEvent {
  final VisualChecksModel installationValue;
  AddSsdInstallationEvent({required this.installationValue});

  @override
  List<Object?> get props => [installationValue];
}

class AddSsdCableTerminationEvent extends AddSsdEvent {
  final VisualChecksModel cableTerminationValue;
  AddSsdCableTerminationEvent({required this.cableTerminationValue});

  @override
  List<Object?> get props => [cableTerminationValue];
}

class AddSsdCheckACVolEvent extends AddSsdEvent {
  final VisualChecksModel checkACVolValue;
  AddSsdCheckACVolEvent({required this.checkACVolValue});

  @override
  List<Object?> get props => [checkACVolValue];
}

class AddSsdPSPEvent extends AddSsdEvent {
  final VisualChecksModel pspValue;
  AddSsdPSPEvent({required this.pspValue});

  @override
  List<Object?> get props => [pspValue];
}

class AddSsdFinalRestorationEvent extends AddSsdEvent {
  final VisualChecksModel finalRestorationValue;
  AddSsdFinalRestorationEvent({required this.finalRestorationValue});

  @override
  List<Object?> get props => [finalRestorationValue];
}

class  AddSsdAddImageEvent extends  AddSsdEvent {
  final BuildContext context;
  final int mediaType;
  AddSsdAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class  AddSsdSubmitDataEvent extends  AddSsdEvent {
  final BuildContext context;
  AddSsdSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}




