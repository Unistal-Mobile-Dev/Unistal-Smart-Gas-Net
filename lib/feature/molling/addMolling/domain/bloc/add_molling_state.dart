part of 'add_molling_bloc.dart';

abstract class AddMollingState extends Equatable {
  const AddMollingState();
}

class AddMollingInitial extends AddMollingState {
  @override
  List<Object> get props => [];
}


class AddMollingPageLoadState extends AddMollingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddMollingDataState extends AddMollingInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController activityRemarkController;
  final AlignmentModel  alignmentData;
  final File file;
  final List<ConcreteCoatingModel> concreteCoatingList;
  final ConcreteCoatingModel concreteCoatingData;
  final List<PipeModel> pipeList;
  final List<dynamic> searchPipeList;
  final bool searchPipeLoader;
  final TextEditingController searchPipeController;
  final PipeModel pipeData;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController descriptionController;
  final List<PipeModel> pipeLengthList;


  FetchAddMollingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.searchPipeController,
    required this.alignmentData,
    required this.file,
    required this.pipeList,
    required this.searchPipeList,
    required this.pipeData,
    required this.concreteCoatingList,
    required this.concreteCoatingData,
    required this.weatherList,
    required this.weatherData,
    required this.chainageFromController,
    required this.chainageToController,
    required this.searchPipeLoader,
    required this.descriptionController,
    required this.pipeLengthList,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    dateController,
    activityRemarkController,
    reportNumberController,
    searchPipeController,
    searchPipeLoader,
    searchPipeList,
    alignmentData,
    file,
    pipeList,
    pipeData,
    concreteCoatingList,
    concreteCoatingData,
    weatherList,
    weatherData,
    chainageFromController,
    chainageToController,
    descriptionController,
    pipeLengthList,

  ];
}
