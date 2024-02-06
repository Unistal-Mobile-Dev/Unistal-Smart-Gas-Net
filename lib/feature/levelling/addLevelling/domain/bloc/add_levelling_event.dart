part of 'add_levelling_bloc.dart';

abstract class AddLevellingEvent extends Equatable {
  const AddLevellingEvent();
}


class AddLevellingPageLoadEvent extends AddLevellingEvent {
  final BuildContext context;
  const AddLevellingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddLevellingSelectDateEvent extends AddLevellingEvent {
  final BuildContext context;
  const AddLevellingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddLevellingSelectAlignmentEvent extends AddLevellingEvent {
  final AlignmentModel  alignmentData;
  const AddLevellingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddLevellingSelectJointTypeDataEvent extends AddLevellingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddLevellingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddLevellingSelectJointDataEvent extends AddLevellingEvent {
  final JointNumberModel jointNumberData;
  const AddLevellingSelectJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddLevellingAddImageEvent extends AddLevellingEvent {
  final BuildContext context;
  final int mediaType;
  const AddLevellingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddLevellingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddLevellingSubmitDataEvent extends AddLevellingEvent {
  final BuildContext context;
  const AddLevellingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}