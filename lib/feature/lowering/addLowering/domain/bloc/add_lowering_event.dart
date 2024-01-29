part of 'add_lowering_bloc.dart';

abstract class AddLoweringEvent extends Equatable {
  const AddLoweringEvent();
}

class AddLoweringPageLoadEvent extends AddLoweringEvent {
  final BuildContext context;
  const AddLoweringPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddLoweringSelectDateEvent extends AddLoweringEvent {
  final BuildContext context;
  const AddLoweringSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddLoweringCalibarationDataEvent extends AddLoweringEvent {
  final BuildContext context;
  const AddLoweringCalibarationDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddLoweringSelectAlignmentEvent extends AddLoweringEvent {
  final AlignmentModel  alignmentData;
  const AddLoweringSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddLoweringSelectHolidayDataEvent extends AddLoweringEvent {
  final HolidayChecksModel holidayChecksData;
  const AddLoweringSelectHolidayDataEvent({required this.holidayChecksData});
  @override
  List<Object?> get props => [holidayChecksData];
}


class AddLoweringSelectFromJointDataEvent extends AddLoweringEvent {
  final JointNumberModel jointNumberData;
  const AddLoweringSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddLoweringSelectJointTypeDataEvent extends AddLoweringEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddLoweringSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddLoweringSelectToJointDataEvent extends AddLoweringEvent {
  final JointNumberModel jointNumberData;
  const AddLoweringSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddLoweringAddImageEvent extends AddLoweringEvent {
  final BuildContext context;
  const AddLoweringAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class SelectWeatherEvent extends AddLoweringEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddLoweringSubmitDataEvent extends AddLoweringEvent {
  final BuildContext context;
  const AddLoweringSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}