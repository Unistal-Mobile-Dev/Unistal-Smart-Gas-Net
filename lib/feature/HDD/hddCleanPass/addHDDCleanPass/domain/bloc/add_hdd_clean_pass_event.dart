part of 'add_hdd_clean_pass_bloc.dart';

@immutable
abstract class AddHddCleanPassEvent extends Equatable{}


class AddHddCleanPassPageLoadEvent extends AddHddCleanPassEvent {
  final BuildContext context;
  AddHddCleanPassPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCleanPassSelectDateEvent extends AddHddCleanPassEvent {
  final BuildContext context;
  AddHddCleanPassSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCleanPassSelectAlignmentEvent extends AddHddCleanPassEvent {
  final AlignmentModel alignmentData;
  AddHddCleanPassSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHddCleanPassAddImageEvent extends AddHddCleanPassEvent {
  final BuildContext context;
  final int mediaType;
  AddHddCleanPassAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddHddCleanPassEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class SelectJointTypeDataEvent extends AddHddCleanPassEvent {
  final JointTypeModel jointTypeDataValue;
  final BuildContext context;
  SelectJointTypeDataEvent({required this.jointTypeDataValue, required this.context});

  @override
  List<Object?> get props => [jointTypeDataValue, context];
}

class SelectFromJointEvent extends AddHddCleanPassEvent {
  final JointNumberModel fromJointValue;
  SelectFromJointEvent({required this.fromJointValue});
  @override
  List<Object?> get props => [fromJointValue];
}

class SelectToJointEvent extends AddHddCleanPassEvent {
  final JointNumberModel toJointValue;
  SelectToJointEvent({required this.toJointValue});
  @override
  List<Object?> get props => [toJointValue];
}

class AddHddCleanPassStartingDateOfPilotHoleEvent extends AddHddCleanPassEvent {
  final BuildContext context;
  AddHddCleanPassStartingDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCleanPassEndDateOfPilotHoleEvent extends AddHddCleanPassEvent {
  final BuildContext context;
  AddHddCleanPassEndDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddCleanPassSubmitDataEvent extends AddHddCleanPassEvent {
  final BuildContext context;
  AddHddCleanPassSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

