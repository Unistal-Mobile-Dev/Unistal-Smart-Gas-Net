part of 'add_bending_bloc.dart';

abstract class AddBendingState extends Equatable {
  const AddBendingState();
}

class AddBendingInitial extends AddBendingState {
  @override
  List<Object> get props => [];
}

class AddBendingPageLoadState extends AddBendingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddBendingDataState extends AddBendingInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController bendingNumberController;
  final TextEditingController bendAngleTpNumberController;
  final TextEditingController bendAngleDegreeController;
  final TextEditingController bendAngleMinuteController;
  final TextEditingController bendAngleSecondController;
  final TextEditingController activityRemarkController;
  final TextEditingController chainageController;
  final List<BendingTypeModel> bendingTypeList;
  final BendingTypeModel bendingTypeData;
  final List<VisualChecksModel> visualChecksList;
  final VisualChecksModel visualChecksData;
  final List<VisualChecksModel> gaugingChecksList;
  final VisualChecksModel gaugingChecksData;
  final List<VisualChecksModel> disbomdmentChecksList;
  final VisualChecksModel disbomdmentChecksData;
  final List<HolidayChecksModel> holidayChecksList;
  final HolidayChecksModel holidayChecksData;
  final File file;
  final List<PipeModel> pipeList;
  final PipeModel pipeData;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController bendNumberController;
  final List<dynamic> searchPipeList;
  final bool searchPipeLoader;
  final TextEditingController searchPipeController;

  FetchAddBendingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.bendAngleMinuteController,
    required this.reportNumberController,
    required this.bendAngleSecondController,
    required this.bendingNumberController,
    required this.bendAngleTpNumberController,
    required this.bendAngleDegreeController,
    required this.chainageController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.bendingTypeData,
    required this.bendingTypeList,
    required this.disbomdmentChecksData,
    required this.disbomdmentChecksList,
    required this.gaugingChecksData,
    required this.gaugingChecksList,
    required this.holidayChecksData,
    required this.holidayChecksList,
    required this.visualChecksData,
    required this.visualChecksList,
    required this.pipeData,
    required this.pipeList,
    required this.weatherList,
    required this.weatherData,
    required this.chainageFromController,
    required this.chainageToController,
    required this.bendNumberController,
    required this.searchPipeLoader,
    required this.searchPipeController,
    required this.searchPipeList,
  });

  @override
  List<Object> get props => [
        isLoader,
        alignmentList,
        dateController,
        activityRemarkController,
        bendAngleMinuteController,
        reportNumberController,
        bendAngleSecondController,
        bendingNumberController,
        bendAngleTpNumberController,
        bendAngleDegreeController,
        chainageController,
        alignmentData,
    multipleAlignmentData,
        file,
        bendingTypeData,
        bendingTypeList,
        disbomdmentChecksData,
        disbomdmentChecksList,
        gaugingChecksData,
        gaugingChecksList,
        holidayChecksData,
        holidayChecksList,
        visualChecksData,
        visualChecksList,
        pipeData,
        pipeList,
        weatherList,
        weatherData,
        chainageFromController,
        chainageToController,
        bendNumberController,
        searchPipeController,
        searchPipeLoader,
        searchPipeList,
      ];
}
