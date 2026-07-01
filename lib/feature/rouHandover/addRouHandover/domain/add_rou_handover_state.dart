part of 'add_rou_handover_bloc.dart';

abstract class AddRouHandoverState extends Equatable {
  const AddRouHandoverState();
}

class AddRouHandoverInitial extends AddRouHandoverState {
  @override
  List<Object> get props => [];
}

class AddRouHandoverLoadState extends AddRouHandoverInitial {
  @override
  List<Object> get props => [];
}

class FetchAddRouHandoverDataState extends AddRouHandoverInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController typeofGroundController;
  final TextEditingController tpChainageNumberController;
  final TextEditingController tpRemarkController;
  final TextEditingController bearingAngleController;
  final TextEditingController terrainController;
  final TextEditingController activityRemarkController;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController lengthController;

  FetchAddRouHandoverDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.bearingAngleController,
    required this.reportNumberController,
    required this.terrainController,
    required this.typeofGroundController,
    required this.tpChainageNumberController,
    required this.tpRemarkController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.chainageFromController,
    required this.chainageToController,
    required this.lengthController,
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
        typeofGroundController,
        tpChainageNumberController,
        tpRemarkController,
        alignmentData,
        multipleAlignmentData,
        file,
        weatherList,
        weatherData,
        chainageFromController,
        chainageToController,
        lengthController,
      ];
}
