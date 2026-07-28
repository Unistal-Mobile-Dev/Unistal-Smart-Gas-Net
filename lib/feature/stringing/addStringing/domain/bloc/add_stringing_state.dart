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
  final TextEditingController corrosionCoatingCtrl;
  final TextEditingController fromCtrl;
  final TextEditingController toCtrl;
  final TextEditingController activityRemarkController;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
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
  final List<TextEditingController> chainageFromController;
  final List<TextEditingController> chainageToController;
  final TextEditingController pipeLengthController;
  final List<PipeModel> pipeLengthList;
  final List<PaddingModel> weightCoatingList;
  final PaddingModel weightCoatingData;
  final List<TerrainTypeModel> manufactureList;
  final TerrainTypeModel manufactureData;

  FetchAddStringingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.searchPipeController,
    required this.alignmentData,
    required this.multipleAlignmentData,
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
    required this.pipeLengthController,
    required this.pipeLengthList,
    required this.weightCoatingData,
    required this.weightCoatingList,
    required this.manufactureList,
    required this.manufactureData,
    required this.corrosionCoatingCtrl,
    required this.fromCtrl,
    required this.toCtrl,
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
        multipleAlignmentData,
        file,
        pipeList,
        pipeData,
        concreteCoatingList,
        concreteCoatingData,
        weatherList,
        weatherData,
        chainageFromController,
        chainageToController,
        pipeLengthController,
        pipeLengthList,
        weightCoatingData,
        weightCoatingList,
        manufactureList,
        manufactureData,
    corrosionCoatingCtrl,
    fromCtrl,
    toCtrl,
      ];
}
