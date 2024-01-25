part of 'add_route_survey_bloc.dart';

abstract class AddRouteSurveyState extends Equatable {
  const AddRouteSurveyState();
}

class AddRouteSurveyInitial extends AddRouteSurveyState {
  @override
  List<Object> get props => [];
}

class AddRouteSurveyPageLoadState extends AddRouteSurveyInitial {
  @override
  List<Object> get props => [];
}

class FetchAddRouteSurveyDataState extends AddRouteSurveyInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController tpChainageController;
  final TextEditingController tpChainageNumberController;
  final TextEditingController tpRemarkNumberController;
  final TextEditingController bearingAngleController;
  final TextEditingController terrainController;
  final TextEditingController activityRemarkController;
  final AlignmentModel  alignmentData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;

  FetchAddRouteSurveyDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.bearingAngleController,
    required this.reportNumberController,
    required this.terrainController,
    required this.tpChainageController,
    required this.tpChainageNumberController,
    required this.tpRemarkNumberController,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    dateController,
    activityRemarkController,
    bearingAngleController,
    reportNumberController,
    terrainController,
    tpChainageController,
    tpChainageNumberController,
    tpRemarkNumberController,
    alignmentData,
    file,
    weatherList,
    weatherData,
  ];
}
