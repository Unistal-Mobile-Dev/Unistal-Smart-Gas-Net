part of 'add_molling_bloc.dart';

abstract class AddMollingEvent extends Equatable {
  const AddMollingEvent();
}

class AddMollingPageLoadEvent extends AddMollingEvent {
  final BuildContext context;
  const AddMollingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddMollingSelectDateEvent extends AddMollingEvent {
  final BuildContext context;
  const AddMollingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
class AddMollingSelectAlignmentEvent extends AddMollingEvent {
  final AlignmentModel  alignmentData;
  const AddMollingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddMollingAddPipeLengthEvent extends AddMollingEvent {
  final BuildContext context;
  const AddMollingAddPipeLengthEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddMollingDeletePipeLengthEvent extends AddMollingEvent {
  final BuildContext context;
  final int index;
  const AddMollingDeletePipeLengthEvent({required this.context, required this.index});
  @override
  List<Object?> get props => [context,index];
}

class AddMollingSelectPipeDataEvent extends AddMollingEvent {
  final PipeModel pipeData;
  const AddMollingSelectPipeDataEvent({required this.pipeData});
  @override
  List<Object?> get props => [pipeData];
}

class AddMollingSearchPipeDataEvent extends AddMollingEvent {
  final String keyword;
  final BuildContext context;
  const AddMollingSearchPipeDataEvent({required this.keyword, required this.context});
  @override
  List<Object?> get props => [keyword, context];
}

class AddMollingSelectConcreteCoatingEvent extends AddMollingEvent {
  final ConcreteCoatingModel concreteCoatingData;
  const AddMollingSelectConcreteCoatingEvent({required this.concreteCoatingData});
  @override
  List<Object?> get props => [concreteCoatingData];
}

class AddMollingAddImageEvent extends AddMollingEvent {
  final BuildContext context;
  final int mediaType;
  const AddMollingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddMollingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddMollingSubmitDataEvent extends AddMollingEvent {
  final BuildContext context;

  const AddMollingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
 }
