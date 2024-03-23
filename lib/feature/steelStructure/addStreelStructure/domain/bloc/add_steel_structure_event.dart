part of 'add_steel_structure_bloc.dart';

abstract class AddSteelStructureEvent extends Equatable {
  const AddSteelStructureEvent();
}

class AddSteelStructurePageLoadEvent extends AddSteelStructureEvent {
  final BuildContext context;
  const AddSteelStructurePageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddSteelStructureSelectDateEvent extends AddSteelStructureEvent {
  final BuildContext context;
  const AddSteelStructureSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddSteelStructureSelectAlignmentEvent extends AddSteelStructureEvent {
  final AlignmentModel  alignmentData;
  const AddSteelStructureSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddSteelStructureAddImageEvent extends AddSteelStructureEvent {
  final BuildContext context;
  final int mediaType;
  const AddSteelStructureAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddSteelStructureEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddSteelStructureSubmitDataEvent extends AddSteelStructureEvent {
  final BuildContext context;
  const AddSteelStructureSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}