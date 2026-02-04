part of 'add_hdd_crossing_bloc.dart';

@immutable
abstract class AddHddCrossingEvent extends Equatable{}

class AddHddCrossingPageLoadEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCrossingSelectDateEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCrossingSelectAlignmentEvent extends AddHddCrossingEvent {
 final AlignmentModel alignmentData;
  AddHddCrossingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHddCrossingMultipleSelectAlignmentEvent extends AddHddCrossingEvent {
  final List<AlignmentModel> alignmentData;
  AddHddCrossingMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHddCrossingAddImageEvent extends AddHddCrossingEvent {
  final BuildContext context;
  final int mediaType;
  AddHddCrossingAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddHddCrossingEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class SelectJointTypeDataEvent extends AddHddCrossingEvent {
  final JointTypeModel jointTypeDataValue;
  final BuildContext context;
  SelectJointTypeDataEvent({required this.jointTypeDataValue, required this.context});

  @override
  List<Object?> get props => [jointTypeDataValue, context];
}

class SelectFromJointEvent extends AddHddCrossingEvent {
  final JointNumberModel fromJointValue;
  SelectFromJointEvent({required this.fromJointValue});
  @override
  List<Object?> get props => [fromJointValue];
}

class SelectToJointEvent extends AddHddCrossingEvent {
  final JointNumberModel toJointValue;
  SelectToJointEvent({required this.toJointValue});
  @override
  List<Object?> get props => [toJointValue];
}

class AddHddCrossingDateCommencementEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingDateCommencementEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCrossingDateCompletionEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingDateCompletionEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCrossingDatePreHydroEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingDatePreHydroEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
class AddHddCrossingPilotBoreCommencementDateEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingPilotBoreCommencementDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
class AddHddCrossingPilotBoreDateCompletionEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingPilotBoreDateCompletionEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCrossingSubmitDataEvent extends AddHddCrossingEvent {
  final BuildContext context;
  AddHddCrossingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

