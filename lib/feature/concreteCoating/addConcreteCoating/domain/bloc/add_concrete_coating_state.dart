part of 'add_concrete_coating_bloc.dart';

abstract class AddConcreteCoatingState extends Equatable {
  const AddConcreteCoatingState();
}

class AddConcreteCoatingInitial extends AddConcreteCoatingState {
  @override
  List<Object> get props => [];
}

class AddConcreteCoatingPageLoadState extends AddConcreteCoatingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddConcreteCoatingDataState extends AddConcreteCoatingInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController concreteCoatingLengthController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageController;
  final File file;
  final List<PipeModel> pipeList;
  final PipeModel pipeData;
  final List<ThicknessModel> thicknessList;
  final ThicknessModel thicknessData;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<dynamic> searchPipeList;
  final bool searchPipeLoader;
  final TextEditingController searchPipeController;

  FetchAddConcreteCoatingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.reportNumberController,
    required this.activityRemarkController,
    required this.concreteCoatingLengthController,
    required this.chainageController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.pipeData,
    required this.pipeList,
    required this.weatherList,
    required this.weatherData,
    required this.searchPipeLoader,
    required this.searchPipeController,
    required this.searchPipeList,
    required this.thicknessList,
    required this.thicknessData,
  });

  @override
  List<Object> get props => [
        isLoader,
        alignmentList,
        dateController,
        reportNumberController,
        activityRemarkController,
        concreteCoatingLengthController,
        chainageController,
        alignmentData,
        multipleAlignmentData,
        file,
        pipeData,
        pipeList,
        weatherList,
        weatherData,
        searchPipeController,
        searchPipeLoader,
        searchPipeList,
        thicknessData,
        thicknessList,
      ];
}
