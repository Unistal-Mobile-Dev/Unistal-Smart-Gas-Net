part of 'add_route_survey_bloc.dart';

abstract class AddRouteSurveyEvent extends Equatable {
  const AddRouteSurveyEvent();
}

class AddRouteSurveyPageLoadEvent extends AddRouteSurveyEvent {
  final BuildContext context;
  const AddRouteSurveyPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRouteSurveySelectDateEvent extends AddRouteSurveyEvent {
  final BuildContext context;
  const AddRouteSurveySelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRouteSurveySelectAlignmentEvent extends AddRouteSurveyEvent {
  final AlignmentModel  alignmentData;
  const AddRouteSurveySelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddRouteSurveySelectGroundTypeEvent extends AddRouteSurveyEvent {
  final GroundTypeModel  groundTypeData;
  const AddRouteSurveySelectGroundTypeEvent({required this.groundTypeData});
  @override
  List<Object?> get props => [groundTypeData];
}

class AddRouteSurveyAddImageEvent extends AddRouteSurveyEvent {
  final BuildContext context;
  final int mediaType;
  const AddRouteSurveyAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddRouteSurveyEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddRouteSurveySubmitDataEvent extends AddRouteSurveyEvent {
  final BuildContext context;
  const AddRouteSurveySubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}