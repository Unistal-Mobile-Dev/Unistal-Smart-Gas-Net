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
  final TextEditingController bearingAngleController;
  final TextEditingController terrainController;
  final TextEditingController activityRemarkController;
  final TextEditingController lengthController;
  final TextEditingController structureController;
  final TextEditingController chainageController;
  final TextEditingController detailController;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final List<GroundTypeModel> groundTypeList;
  final GroundTypeModel groundTypeData;

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
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.chainageFromController,
    required this.chainageToController,
    required this.groundTypeList,
    required this.groundTypeData,
    required this.lengthController,
    required this.structureController,
    required this.chainageController,
    required this.detailController,
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
        alignmentData,
        multipleAlignmentData,
        file,
        weatherList,
        weatherData,
        chainageFromController,
        chainageToController,
        groundTypeList,
        groundTypeData,
        structureController,
        chainageController,
        detailController,
      ];
}
