part of 'add_drying_bloc.dart';

abstract class AddDryingEvent extends Equatable {
  const AddDryingEvent();
}

class AddDryingPageLoadEvent extends AddDryingEvent {
  final BuildContext context;

  const AddDryingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddDryingSelectDateEvent extends AddDryingEvent {
  final BuildContext context;

  const AddDryingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddDryingSelectAlignmentEvent extends AddDryingEvent {
  final AlignmentModel alignmentData;

  const AddDryingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddDryingSelectFromJointDataEvent extends AddDryingEvent {
  final JointNumberModel jointNumberData;

  const AddDryingSelectFromJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddDryingSelectJointTypeDataEvent extends AddDryingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddDryingSelectJointTypeDataEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddDryingSelectToJointDataEvent extends AddDryingEvent {
  final JointNumberModel jointNumberData;

  const AddDryingSelectToJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddDryingAddImageEvent extends AddDryingEvent {
  final BuildContext context;
  final int mediaType;

  const AddDryingAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddDryingEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddDryingSubmitDataEvent extends AddDryingEvent {
  final BuildContext context;

  const AddDryingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
