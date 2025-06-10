part of 'add_pre_hydrotest_bloc.dart';

abstract class AddPreHydrotestEvent extends Equatable {
  const AddPreHydrotestEvent();
}

class AddPreHydrotestPageLoadEvent extends AddPreHydrotestEvent {
  final BuildContext context;

  const AddPreHydrotestPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPreHydrotestSelectDateEvent extends AddPreHydrotestEvent {
  final BuildContext context;

  const AddPreHydrotestSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPreHydrotestSelectPressureDateEvent extends AddPreHydrotestEvent {
  final BuildContext context;

  const AddPreHydrotestSelectPressureDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPreHydrotestSelectAlignmentEvent extends AddPreHydrotestEvent {
  final AlignmentModel alignmentData;

  const AddPreHydrotestSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddPreHydrotestSelectFromJointDataEvent extends AddPreHydrotestEvent {
  final JointNumberModel jointNumberData;

  const AddPreHydrotestSelectFromJointDataEvent(
      {required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddPreHydrotestSelectJointTypeDataEvent extends AddPreHydrotestEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddPreHydrotestSelectJointTypeDataEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddPreHydrotestSelectToJointDataEvent extends AddPreHydrotestEvent {
  final JointNumberModel jointNumberData;

  const AddPreHydrotestSelectToJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddPreHydrotestSelectSelectThicknessDataEvent
    extends AddPreHydrotestEvent {
  final ThicknessModel thicknessData;

  const AddPreHydrotestSelectSelectThicknessDataEvent(
      {required this.thicknessData});

  @override
  List<Object?> get props => [thicknessData];
}

class AddPreHydrotestAddImageEvent extends AddPreHydrotestEvent {
  final BuildContext context;
  final int mediaType;

  const AddPreHydrotestAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddPreHydrotestEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddPreHydrotestSubmitDataEvent extends AddPreHydrotestEvent {
  final BuildContext context;

  const AddPreHydrotestSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
class CalculateLengthEvent extends AddPreHydrotestEvent {
  final bool isChainageTo;
  final String value;
  final BuildContext context;
  const CalculateLengthEvent({required this.isChainageTo, required this.value, required this.context});
  @override
  List<Object?> get props => [isChainageTo, value, context];
}
