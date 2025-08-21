part of 'add_hdd_pulling_bloc.dart';

@immutable
abstract class AddHddPullingEvent extends Equatable{}

class AddHddPullingPageLoadEvent extends AddHddPullingEvent {
  final BuildContext context;
  AddHddPullingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddPullingSelectDateEvent extends AddHddPullingEvent {
  final BuildContext context;
  AddHddPullingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddPullingSelectAlignmentEvent extends AddHddPullingEvent {
  final AlignmentModel alignmentData;
  AddHddPullingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHddPullingAddImageEvent extends AddHddPullingEvent {
  final BuildContext context;
  final int mediaType;
  AddHddPullingAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddHddPullingEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class SelectJointTypeDataEvent extends AddHddPullingEvent {
  final JointTypeModel jointTypeDataValue;
  final BuildContext context;
  SelectJointTypeDataEvent({required this.jointTypeDataValue, required this.context});

  @override
  List<Object?> get props => [jointTypeDataValue, context];
}

class SelectFromJointEvent extends AddHddPullingEvent {
  final JointNumberModel fromJointValue;
  SelectFromJointEvent({required this.fromJointValue});
  @override
  List<Object?> get props => [fromJointValue];
}

class SelectToJointEvent extends AddHddPullingEvent {
  final JointNumberModel toJointValue;
  SelectToJointEvent({required this.toJointValue});
  @override
  List<Object?> get props => [toJointValue];
}


class AddHddPullingStartingDateOfPilotHoleEvent extends AddHddPullingEvent {
  final BuildContext context;
  AddHddPullingStartingDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddPullingEndDateOfPilotHoleEvent extends AddHddPullingEvent {
  final BuildContext context;
  AddHddPullingEndDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHddPullingSubmitDataEvent extends AddHddPullingEvent {
  final BuildContext context;
  AddHddPullingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

