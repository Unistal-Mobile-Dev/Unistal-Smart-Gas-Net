part of 'add_post_hydrotest_bloc.dart';

abstract class AddPostHydrotestEvent extends Equatable {
  const AddPostHydrotestEvent();
}

class AddPostHydrotestPageLoadEvent extends AddPostHydrotestEvent {
  final BuildContext context;

  const AddPostHydrotestPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPostHydrotestSelectDateEvent extends AddPostHydrotestEvent {
  final BuildContext context;

  const AddPostHydrotestSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPostHydrotestSelectAlignmentEvent extends AddPostHydrotestEvent {
  final AlignmentModel alignmentData;

  const AddPostHydrotestSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddPostHydrotestSelectFromJointDataEvent extends AddPostHydrotestEvent {
  final JointNumberModel jointNumberData;

  const AddPostHydrotestSelectFromJointDataEvent(
      {required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddPostHydrotestSelectJointTypeDataEvent extends AddPostHydrotestEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddPostHydrotestSelectJointTypeDataEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddPostHydrotestSelectToJointDataEvent extends AddPostHydrotestEvent {
  final JointNumberModel jointNumberData;

  const AddPostHydrotestSelectToJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddPostHydrotestAddImageEvent extends AddPostHydrotestEvent {
  final BuildContext context;
  final int mediaType;

  const AddPostHydrotestAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddPostHydrotestEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddPostHydrotestSubmitDataEvent extends AddPostHydrotestEvent {
  final BuildContext context;

  const AddPostHydrotestSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
