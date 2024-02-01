part of 'add_lpt_bloc.dart';

abstract class AddLptEvent extends Equatable {
  const AddLptEvent();
}


class AddLptPageLoadEvent extends AddLptEvent {
  final BuildContext context;
  const AddLptPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddLptSelectDateEvent extends AddLptEvent {
  final BuildContext context;
  const AddLptSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddLptSelectAlignmentEvent extends AddLptEvent {
  final AlignmentModel  alignmentData;
  const AddLptSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddLptSelectJointTypeDataEvent extends AddLptEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddLptSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddLptSelectJointDataEvent extends AddLptEvent {
  final JointNumberModel jointNumberData;
  const AddLptSelectJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddLptSelectLptStatusDataEvent extends AddLptEvent {
  final LptStatusModel lptStatusData;
  const AddLptSelectLptStatusDataEvent({required this.lptStatusData});
  @override
  List<Object?> get props => [lptStatusData];
}

class AddLptAddImageEvent extends AddLptEvent {
  final BuildContext context;
  const AddLptAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class SelectWeatherEvent extends AddLptEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddLptSubmitDataEvent extends AddLptEvent {
  final BuildContext context;
  const AddLptSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}