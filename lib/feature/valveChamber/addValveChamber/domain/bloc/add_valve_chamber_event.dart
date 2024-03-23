part of 'add_valve_chamber_bloc.dart';

abstract class AddValveChamberEvent extends Equatable {
  const AddValveChamberEvent();
}

class AddValveChamberPageLoadEvent extends AddValveChamberEvent {
  final BuildContext context;
  const AddValveChamberPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddValveChamberSelectDateEvent extends AddValveChamberEvent {
  final BuildContext context;
  const AddValveChamberSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddValveChamberSelectAlignmentEvent extends AddValveChamberEvent {
  final AlignmentModel  alignmentData;
  const AddValveChamberSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddValveChamberAddImageEvent extends AddValveChamberEvent {
  final BuildContext context;
  final int mediaType;
  const AddValveChamberAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddValveChamberEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddValveChamberSubmitDataEvent extends AddValveChamberEvent {
  final BuildContext context;
  const AddValveChamberSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}