part of 'add_tren_ching_bloc.dart';

abstract class AddTrenChingEvent extends Equatable {
  const AddTrenChingEvent();
}

class AddTrenChingPageLoadEvent extends AddTrenChingEvent {
  final BuildContext context;
  const AddTrenChingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddTrenChingSelectDateEvent extends AddTrenChingEvent {
  final BuildContext context;
  const AddTrenChingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddTrenChingSelectAlignmentEvent extends AddTrenChingEvent {
  final AlignmentModel  alignmentData;
  const AddTrenChingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddTrenChingSelectJointEvent extends AddTrenChingEvent {
  final JointNumberModel  jointNumberData;
  const AddTrenChingSelectJointEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddTrenChingAddImageEvent extends AddTrenChingEvent {
  final BuildContext context;
  final int mediaType;
  const AddTrenChingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddTrenChingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}

class AddTrenChingSelectFromJointDataEvent extends AddTrenChingEvent {
  final JointNumberModel jointNumberData;
  const AddTrenChingSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddTrenChingSelectJointTypeDataEvent extends AddTrenChingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddTrenChingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddTrenChingSelectToJointDataEvent extends AddTrenChingEvent {
  final JointNumberModel jointNumberData;
  const AddTrenChingSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}


class AddTrenChingSubmitDataEvent extends AddTrenChingEvent {
  final BuildContext context;
  const AddTrenChingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}