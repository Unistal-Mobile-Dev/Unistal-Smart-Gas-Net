part of 'add_bending_bloc.dart';

abstract class AddBendingEvent extends Equatable {
  const AddBendingEvent();
}

class AddBendingPageLoadEvent extends AddBendingEvent {
  final BuildContext context;
  const AddBendingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBendingSelectDateEvent extends AddBendingEvent {
  final BuildContext context;
  const AddBendingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBendingSelectAlignmentEvent extends AddBendingEvent {
  final AlignmentModel  alignmentData;
  const AddBendingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddBendingSelectBendingTypeEvent extends AddBendingEvent {
  final BendingTypeModel bendingTypeData;
  const AddBendingSelectBendingTypeEvent({required this.bendingTypeData});
  @override
  List<Object?> get props => [bendingTypeData];
}

class AddBendingSelectSelectPipeDataEvent extends AddBendingEvent {
  final PipeModel pipeData;
  const AddBendingSelectSelectPipeDataEvent({required this.pipeData});
  @override
  List<Object?> get props => [pipeData];
}

class AddBendingSelectVisualDataEvent extends AddBendingEvent {
  final VisualChecksModel visualChecksData;
  const AddBendingSelectVisualDataEvent({required this.visualChecksData});
  @override
  List<Object?> get props => [visualChecksData];
}

class AddBendingSelectHolidayDataEvent extends AddBendingEvent {
  final HolidayChecksModel holidayChecksData;
  const AddBendingSelectHolidayDataEvent({required this.holidayChecksData});
  @override
  List<Object?> get props => [holidayChecksData];
}

class AddBendingSelectGaugingEvent extends AddBendingEvent {
  final VisualChecksModel gaugingChecksData;
  const AddBendingSelectGaugingEvent({required this.gaugingChecksData});
  @override
  List<Object?> get props => [gaugingChecksData];
}

class AddBendingSelectDisbomdmentEvent extends AddBendingEvent {
  final VisualChecksModel disbomdmentChecksData;
  const AddBendingSelectDisbomdmentEvent({required this.disbomdmentChecksData});
  @override
  List<Object?> get props => [disbomdmentChecksData];
}

class AddBendingAddImageEvent extends AddBendingEvent {
  final BuildContext context;
  final int mediaType;
  const AddBendingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class AddBendingAddSearchPipeDataEvent extends AddBendingEvent {
  final BuildContext context;
  final String keyword;
  const AddBendingAddSearchPipeDataEvent({required this.context, required this.keyword});
  @override
  List<Object?> get props => [context, keyword];
}

class SelectWeatherEvent extends AddBendingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddBendingSubmitDataEvent extends AddBendingEvent {
  final BuildContext context;
  const AddBendingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}