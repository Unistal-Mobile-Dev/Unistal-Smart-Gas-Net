part of 'add_hdd_reaming_bloc.dart';

@immutable
abstract class AddHddReamingEvent extends Equatable{}

class AddHddReamingPageLoadEvent extends AddHddReamingEvent {
  final BuildContext context;
  AddHddReamingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddReamingSelectDateEvent extends AddHddReamingEvent {
  final BuildContext context;
  AddHddReamingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddReamingSelectAlignmentEvent extends AddHddReamingEvent {
  final AlignmentModel alignmentData;
  AddHddReamingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHddReamingAddImageEvent extends AddHddReamingEvent {
  final BuildContext context;
  final int mediaType;
  AddHddReamingAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddHddReamingEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class SelectJointTypeDataEvent extends AddHddReamingEvent {
  final JointTypeModel jointTypeDataValue;
  final BuildContext context;
  SelectJointTypeDataEvent({required this.jointTypeDataValue, required this.context});

  @override
  List<Object?> get props => [jointTypeDataValue, context];
}

class SelectFromJointEvent extends AddHddReamingEvent {
  final JointNumberModel fromJointValue;
  SelectFromJointEvent({required this.fromJointValue});
  @override
  List<Object?> get props => [fromJointValue];
}

class SelectToJointEvent extends AddHddReamingEvent {
  final JointNumberModel toJointValue;
  SelectToJointEvent({required this.toJointValue});
  @override
  List<Object?> get props => [toJointValue];
}

class AddHddReamingStartingDateOfPilotHoleEvent extends AddHddReamingEvent {
  final BuildContext context;
  AddHddReamingStartingDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddReamingEndDateOfPilotHoleEvent extends AddHddReamingEvent {
  final BuildContext context;
  AddHddReamingEndDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddReamingSubmitDataEvent extends AddHddReamingEvent {
  final BuildContext context;
  AddHddReamingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
