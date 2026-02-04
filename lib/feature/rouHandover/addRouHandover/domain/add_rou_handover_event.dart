part of 'add_rou_handover_bloc.dart';

abstract class AddRouHandoverEvent extends Equatable {
  const AddRouHandoverEvent();
}

class AddRouHandoverLoadEvent extends AddRouHandoverEvent {
  final BuildContext context;

  const AddRouHandoverLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddRouHandoverSelectDateEvent extends AddRouHandoverEvent {
  final BuildContext context;

  const AddRouHandoverSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddRouHandoverSelectAlignmentEvent extends AddRouHandoverEvent {
 final AlignmentModel alignmentData;

  const AddRouHandoverSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddRouHandoverMultipleSelectAlignmentEvent extends AddRouHandoverEvent {
  final List<AlignmentModel> alignmentData;

  const AddRouHandoverMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddRouHandoverAddImageEvent extends AddRouHandoverEvent {
  final BuildContext context;
  final int mediaType;

  const AddRouHandoverAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddRouHandoverEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddRouHandoverSubmitDataEvent extends AddRouHandoverEvent {
  final BuildContext context;

  const AddRouHandoverSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
