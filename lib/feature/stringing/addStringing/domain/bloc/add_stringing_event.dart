part of 'add_stringing_bloc.dart';

abstract class AddStringingEvent extends Equatable {
  const AddStringingEvent();
}

class AddStringingPageLoadEvent extends AddStringingEvent {
  final BuildContext context;
  const AddStringingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddStringingSelectDateEvent extends AddStringingEvent {
  final BuildContext context;
  const AddStringingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddStringingSelectAlignmentEvent extends AddStringingEvent {
  final AlignmentModel  alignmentData;
  const AddStringingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddStringingSelectPipeDataEvent extends AddStringingEvent {
  final PipeModel pipeData;
  const AddStringingSelectPipeDataEvent({required this.pipeData});
  @override
  List<Object?> get props => [pipeData];
}

class AddStringingSearchPipeDataEvent extends AddStringingEvent {
  final String keyword;
  final BuildContext context;
  const AddStringingSearchPipeDataEvent({required this.keyword, required this.context});
  @override
  List<Object?> get props => [keyword, context];
}

class AddStringingSelectConcreteCoatingEvent extends AddStringingEvent {
  final ConcreteCoatingModel concreteCoatingData;
  const AddStringingSelectConcreteCoatingEvent({required this.concreteCoatingData});
  @override
  List<Object?> get props => [concreteCoatingData];
}

class AddStringingAddImageEvent extends AddStringingEvent {
  final BuildContext context;
  final int mediaType;
  const AddStringingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddStringingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddStringingSubmitDataEvent extends AddStringingEvent {
  final BuildContext context;
  const AddStringingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}