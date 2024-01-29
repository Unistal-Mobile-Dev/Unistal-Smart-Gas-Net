part of 'add_stringing_bloc.dart';

abstract class AddStringingState extends Equatable {
  const AddStringingState();
}

class AddStringingInitial extends AddStringingState {
  @override
  List<Object> get props => [];
}


class AddStringingPageLoadState extends AddStringingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddStringingDataState extends AddStringingInitial {
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
  final PipeModel pipeData;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;

  FetchAddStringingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.alignmentData,
    required this.file,
    required this.pipeList,
    required this.pipeData,
    required this.concreteCoatingList,
    required this.concreteCoatingData,
    required this.weatherList,
    required this.weatherData,
    required this.chainageFromController,
    required this.chainageToController,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    dateController,
    activityRemarkController,
    reportNumberController,
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
  ];
}
