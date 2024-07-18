part of 'add_thermit_weld_bloc.dart';

@immutable
abstract class AddThermitWeldEvent extends Equatable{}


class AddThermitWeldPageLoadEvent extends  AddThermitWeldEvent {
  final BuildContext context;
  AddThermitWeldPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddThermitWeldSelectDateEvent extends  AddThermitWeldEvent {
  final BuildContext context;
  AddThermitWeldSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddThermitWeldSelectAlignmentEvent extends  AddThermitWeldEvent {
  final AlignmentModel alignmentData;
  AddThermitWeldSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends  AddThermitWeldEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddTestStationBoxTLPTypeEvent extends AddThermitWeldEvent {
  final TlpTypeModel tlpTypeValue;
  AddTestStationBoxTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}

class AddTestStationBoxPinBrazingEvent extends AddThermitWeldEvent {
  final VisualChecksModel pinBrazingValue;
  AddTestStationBoxPinBrazingEvent({required this.pinBrazingValue});

  @override
  List<Object?> get props => [pinBrazingValue];
}

class AddTestStationBoxContinuityCheckEvent extends AddThermitWeldEvent {
  final VisualChecksModel continuityCheckValue;
  AddTestStationBoxContinuityCheckEvent({required this.continuityCheckValue});

  @override
  List<Object?> get props => [continuityCheckValue];
}

class AddTestStationBoxRestorationCheckEvent extends AddThermitWeldEvent {
  final VisualChecksModel restorationCheckValue;
  AddTestStationBoxRestorationCheckEvent({required this.restorationCheckValue});

  @override
  List<Object?> get props => [restorationCheckValue];
}

class  AddThermitWeldAddImageEvent extends  AddThermitWeldEvent {
  final BuildContext context;
  final int mediaType;
  AddThermitWeldAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class  AddThermitWeldSubmitDataEvent extends  AddThermitWeldEvent {
  final BuildContext context;
  AddThermitWeldSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

