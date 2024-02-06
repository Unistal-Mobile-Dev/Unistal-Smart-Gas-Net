part of 'add_ofc_splicing_bloc.dart';

abstract class AddOfcSplicingEvent extends Equatable {
  const AddOfcSplicingEvent();
}

class AddOfcSplicingPageLoadEvent extends AddOfcSplicingEvent {
  final BuildContext context;
  const AddOfcSplicingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddOfcSplicingSelectDateEvent extends AddOfcSplicingEvent {
  final BuildContext context;
  const AddOfcSplicingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddOfcSplicingSelectAlignmentEvent extends AddOfcSplicingEvent {
  final AlignmentModel  alignmentData;
  const AddOfcSplicingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddOfcSplicingSelectJointTypeDataEvent extends AddOfcSplicingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddOfcSplicingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddOfcSplicingSelectJointNumberDataEvent extends AddOfcSplicingEvent {
  final JointNumberModel jointNumberData;
  const AddOfcSplicingSelectJointNumberDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddOfcSplicingAddImageEvent extends AddOfcSplicingEvent {
  final BuildContext context;
  final int mediaType;
  const AddOfcSplicingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context,mediaType];
}

class SelectWeatherEvent extends AddOfcSplicingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddOfcSplicingSubmitDataEvent extends AddOfcSplicingEvent {
  final BuildContext context;
  const AddOfcSplicingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}