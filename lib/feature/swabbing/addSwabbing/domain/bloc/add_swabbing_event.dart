part of 'add_swabbing_bloc.dart';

abstract class AddSwabbingEvent extends Equatable {
  const AddSwabbingEvent();
}

class AddSwabbingPageLoadEvent extends AddSwabbingEvent {
  final BuildContext context;
  const AddSwabbingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddSwabbingSelectDateEvent extends AddSwabbingEvent {
  final BuildContext context;
  const AddSwabbingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddSwabbingSelectAlignmentEvent extends AddSwabbingEvent {
  final AlignmentModel  alignmentData;
  const AddSwabbingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddSwabbingSelectFromJointDataEvent extends AddSwabbingEvent {
  final JointNumberModel jointNumberData;
  const AddSwabbingSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddSwabbingSelectJointTypeDataEvent extends AddSwabbingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddSwabbingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddSwabbingSelectToJointDataEvent extends AddSwabbingEvent {
  final JointNumberModel jointNumberData;
  const AddSwabbingSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddSwabbingAddImageEvent extends AddSwabbingEvent {
  final BuildContext context;
  final int mediaType;
  const AddSwabbingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddSwabbingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}

class AddSwabbingSubmitDataEvent extends AddSwabbingEvent {
  final BuildContext context;
  const AddSwabbingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}