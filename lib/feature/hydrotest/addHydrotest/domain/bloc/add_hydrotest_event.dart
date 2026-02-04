part of 'add_hydrotest_bloc.dart';

abstract class AddHydrotestEvent extends Equatable {
  const AddHydrotestEvent();
}

class AddHydrotestPageLoadEvent extends AddHydrotestEvent {
  final BuildContext context;

  const AddHydrotestPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHydrotestSelectDateEvent extends AddHydrotestEvent {
  final BuildContext context;

  const AddHydrotestSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHydrotestSelectAlignmentEvent extends AddHydrotestEvent {
 final AlignmentModel alignmentData;

  const AddHydrotestSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHydrotestMultipleSelectAlignmentEvent extends AddHydrotestEvent {
  final List<AlignmentModel> alignmentData;

  const AddHydrotestMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHydrotestSelectFromJointDataEvent extends AddHydrotestEvent {
  final JointNumberModel jointNumberData;

  const AddHydrotestSelectFromJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddHydrotestSelectJointTypeDataEvent extends AddHydrotestEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddHydrotestSelectJointTypeDataEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddHydrotestSelectToJointDataEvent extends AddHydrotestEvent {
  final JointNumberModel jointNumberData;

  const AddHydrotestSelectToJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddHydrotestAddImageEvent extends AddHydrotestEvent {
  final BuildContext context;
  final int mediaType;
  final int index;

  const AddHydrotestAddImageEvent(
      {required this.context, required this.mediaType, required this.index});

  @override
  List<Object?> get props => [context, mediaType, index];
}

class SelectWeatherEvent extends AddHydrotestEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddHydrotestSubmitDataEvent extends AddHydrotestEvent {
  final BuildContext context;

  const AddHydrotestSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
