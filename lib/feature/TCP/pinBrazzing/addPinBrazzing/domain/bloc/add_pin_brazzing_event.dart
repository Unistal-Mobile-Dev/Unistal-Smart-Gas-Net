part of 'add_pin_brazzing_bloc.dart';

@immutable
abstract class AddPinBrazzingEvent extends Equatable{}


class AddPinBrazzingPageLoadEvent extends AddPinBrazzingEvent {
  final BuildContext context;
  AddPinBrazzingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPinBrazzingSelectDateEvent extends AddPinBrazzingEvent {
  final BuildContext context;
  AddPinBrazzingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPinBrazzingSelectAlignmentEvent extends AddPinBrazzingEvent {
  final AlignmentModel alignmentData;
  AddPinBrazzingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends AddPinBrazzingEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddTestStationBoxTLPTypeEvent extends AddPinBrazzingEvent {
  final TlpTypeModel tlpTypeValue;
  AddTestStationBoxTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}

class AddTestStationBoxPinBrazingEvent extends AddPinBrazzingEvent {
  final VisualChecksModel pinBrazingValue;
  AddTestStationBoxPinBrazingEvent({required this.pinBrazingValue});

  @override
  List<Object?> get props => [pinBrazingValue];
}

class AddTestStationBoxContinuityCheckEvent extends AddPinBrazzingEvent {
  final VisualChecksModel continuityCheckValue;
  AddTestStationBoxContinuityCheckEvent({required this.continuityCheckValue});

  @override
  List<Object?> get props => [continuityCheckValue];
}

class AddTestStationBoxRestorationCheckEvent extends AddPinBrazzingEvent {
  final VisualChecksModel restorationCheckValue;
  AddTestStationBoxRestorationCheckEvent({required this.restorationCheckValue});

  @override
  List<Object?> get props => [restorationCheckValue];
}


class AddPinBrazzingAddImageEvent extends AddPinBrazzingEvent {
  final BuildContext context;
  final int mediaType;
  AddPinBrazzingAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class AddPinBrazzingSubmitDataEvent extends AddPinBrazzingEvent {
  final BuildContext context;
  AddPinBrazzingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

