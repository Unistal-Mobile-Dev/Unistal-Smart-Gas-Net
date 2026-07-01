part of 'add_ndt_aut_bloc.dart';

abstract class AddNdtAutState extends Equatable {
  const AddNdtAutState();
}

class AddNdtAutInitial extends AddNdtAutState {
  @override
  List<Object> get props => [];
}

class AddNdtAutPageLoadState extends AddNdtAutInitial {
  @override
  List<Object> get props => [];
}

class FetchAddNdtAutDataState extends AddNdtAutInitial {
  final List<WelderModel> welderList;
  final List<WelderModel> selectedWelderList;
  final List<WPSModel> wpsTypeList;
  final WPSModel wpsTypeData;
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController defectLocationController;
  final TextEditingController reportNumberController;
  final File file;
  final bool isLoader;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final List<JointNumberModel> jointNumberList;
  final JointNumberModel jointNumberData;
  final bool isJointNumberLoader;
  final bool isWelderLoader;
  final List<AutStatusModel> autStatusList;
  final AutStatusModel autStatusData;
  final List<DefectLayerModel> defectLayerList;
  final List<DefectLayerModel> selectedDefectLayerList;
  final List<DefectTypeModel> defectTypeList;
  final List<DefectTypeModel> selectedDefectTypeList;
  final List<AlignmentModel> selectedAlignmentList;
  final List<TerrainTypeModel> ndtAgencyList;
  final TerrainTypeModel ndtAgencyData;
  final List<TerrainTypeModel> contractorList;
  final TerrainTypeModel contractorData;
  final List<TerrainTypeModel> pmcList;
  final TerrainTypeModel pmcData;

  FetchAddNdtAutDataState({
    required this.selectedWelderList,
    required this.welderList,
    required this.wpsTypeData,
    required this.wpsTypeList,
    required this.dateController,
    required this.file,
    required this.activityRemarkController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.alignmentList,
    required this.isLoader,
    required this.weatherData,
    required this.weatherList,
    required this.jointNumberList,
    required this.jointNumberData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.isWelderLoader,
    required this.defectLocationController,
    required this.autStatusData,
    required this.autStatusList,
    required this.defectLayerList,
    required this.defectTypeList,
    required this.selectedDefectLayerList,
    required this.selectedDefectTypeList,
    required this.selectedAlignmentList,
    required this.reportNumberController,
    required this.ndtAgencyList,
    required this.ndtAgencyData,
    required this.contractorList,
    required this.contractorData,
    required this.pmcList,
    required this.pmcData,
  });

  @override
  List<Object> get props => [
        reportNumberController,
        selectedWelderList,
        welderList,
        wpsTypeData,
        wpsTypeList,
        dateController,
        file,
        activityRemarkController,
        alignmentData,
        multipleAlignmentData,
        alignmentList,
        isLoader,
        weatherData,
        weatherList,
        jointNumberList,
        jointNumberData,
        jointTypeData,
        jointTypeList,
        isJointNumberLoader,
        isWelderLoader,
        defectLocationController,
        autStatusList,
        autStatusData,
        defectLayerList,
        defectTypeList,
        selectedDefectLayerList,
        selectedDefectTypeList,
        selectedAlignmentList,
        reportNumberController,
        ndtAgencyList,
        ndtAgencyData,
        contractorList,
        contractorData,
        pmcList,
        pmcData,
      ];
}
