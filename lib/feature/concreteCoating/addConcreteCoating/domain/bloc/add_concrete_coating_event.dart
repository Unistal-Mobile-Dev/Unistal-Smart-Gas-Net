part of 'add_concrete_coating_bloc.dart';

abstract class AddConcreteCoatingEvent extends Equatable {
  const AddConcreteCoatingEvent();
}

class AddConcreteCoatingPageLoadEvent extends AddConcreteCoatingEvent {
  final BuildContext context;

  const AddConcreteCoatingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddConcreteCoatingSelectDateEvent extends AddConcreteCoatingEvent {
  final BuildContext context;

  const AddConcreteCoatingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddConcreteCoatingSelectAlignmentEvent extends AddConcreteCoatingEvent {
 final AlignmentModel alignmentData;

  const AddConcreteCoatingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddConcreteCoatingMultipleSelectAlignmentEvent extends AddConcreteCoatingEvent {
  final List<AlignmentModel> alignmentData;

  const AddConcreteCoatingMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddConcreteCoatingSelectSelectPipeDataEvent extends AddConcreteCoatingEvent {
  final PipeModel pipeData;

  const AddConcreteCoatingSelectSelectPipeDataEvent({required this.pipeData});

  @override
  List<Object?> get props => [pipeData];
}

class AddConcreteCoatingSelectSelectThicknessDataEvent
    extends AddConcreteCoatingEvent {
  final ThicknessModel thicknessData;

  const AddConcreteCoatingSelectSelectThicknessDataEvent(
      {required this.thicknessData});

  @override
  List<Object?> get props => [thicknessData];
}

class AddConcreteCoatingAddImageEvent extends AddConcreteCoatingEvent {
  final BuildContext context;
  final int mediaType;

  const AddConcreteCoatingAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class AddConcreteCoatingAddSearchPipeDataEvent extends AddConcreteCoatingEvent {
  final BuildContext context;
  final String keyword;

  const AddConcreteCoatingAddSearchPipeDataEvent(
      {required this.context, required this.keyword});

  @override
  List<Object?> get props => [context, keyword];
}

class SelectWeatherEvent extends AddConcreteCoatingEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddConcreteCoatingSubmitDataEvent extends AddConcreteCoatingEvent {
  final BuildContext context;

  const AddConcreteCoatingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
