part of 'add_pilot_drill_bloc.dart';

@immutable
abstract class AddPilotDrillEvent extends Equatable{}


class AddPilotDrillPageLoadEvent extends AddPilotDrillEvent {
  final BuildContext context;
  AddPilotDrillPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPilotDrillSelectDateEvent extends AddPilotDrillEvent {
  final BuildContext context;
  AddPilotDrillSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPilotDrillSelectAlignmentEvent extends AddPilotDrillEvent {
   final AlignmentModel alignmentData;
  AddPilotDrillSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddPilotDrillMultipleSelectAlignmentEvent extends AddPilotDrillEvent {
  final List<AlignmentModel> alignmentData;
  AddPilotDrillMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddPilotDrillAddImageEvent extends AddPilotDrillEvent {
  final BuildContext context;
  final int mediaType;
  AddPilotDrillAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddPilotDrillEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class SelectJointTypeDataEvent extends AddPilotDrillEvent {
  final JointTypeModel jointTypeDataValue;
  final BuildContext context;
  SelectJointTypeDataEvent({required this.jointTypeDataValue, required this.context});

  @override
  List<Object?> get props => [jointTypeDataValue, context];
}

class SelectFromJointEvent extends AddPilotDrillEvent {
  final JointNumberModel fromJointValue;
  SelectFromJointEvent({required this.fromJointValue});
  @override
  List<Object?> get props => [fromJointValue];
}

class SelectToJointEvent extends AddPilotDrillEvent {
  final JointNumberModel toJointValue;
  SelectToJointEvent({required this.toJointValue});
  @override
  List<Object?> get props => [toJointValue];
}

class AddPilotDrillStartingDateOfPilotHoleEvent extends AddPilotDrillEvent {
  final BuildContext context;
  AddPilotDrillStartingDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPilotDrillEndDateOfPilotHoleEvent extends AddPilotDrillEvent {
  final BuildContext context;
  AddPilotDrillEndDateOfPilotHoleEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPilotDrillSubmitDataEvent extends AddPilotDrillEvent {
  final BuildContext context;
  AddPilotDrillSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
