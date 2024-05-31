part of 'add_soil_resistivity_bloc.dart';

abstract class AddSoilResistivityState extends Equatable {
  const AddSoilResistivityState();
}

class AddSoilResistivityInitial extends AddSoilResistivityState {
  @override
  List<Object> get props => [];
}

class AddSoilResistivityPageLoadState extends AddSoilResistivityInitial {
  @override
  List<Object> get props => [];
}

class FetchAddSoilResistivityDataState extends AddSoilResistivityInitial {
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
  final AlignmentModel alignmentData;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;

  FetchAddSoilResistivityDataState({
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
    required this.chainageFromController,
    required this.chainageToController,
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
        chainageFromController,
        chainageToController,
      ];
}
