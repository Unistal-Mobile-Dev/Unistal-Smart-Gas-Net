part of 'add_tiein_bloc.dart';

abstract class AddTieinState extends Equatable {
  const AddTieinState();
}

class AddTieinInitial extends AddTieinState {
  @override
  List<Object> get props => [];
}

class AddTieinPageLoadState extends AddTieinInitial {
  @override
  List<Object> get props => [];
}

class FetchAddTieinDataState extends AddTieinInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel alignmentData;
  final List<AlignmentModel> multipleAlignmentData;
  final bool isLoader;

  final List<WPSModel> wpsList;
  final WPSModel wpsData;
  final List<WelderModel> welderList;
  final WelderModel welderData;
  final List<JointNumberModel> jointNumberList;
  final JointNumberModel jointNumberData;
  final File file;

  final List<WelderModel> rootWelders1List;
  final List<WelderModel> rootWelders2List;
  final List<WelderModel> hotWelders1List;
  final List<WelderModel> hotWelders2List;
  final List<WelderModel> filler1Welders1List;
  final List<WelderModel> filler1Welders2List;
  final List<WelderModel> filler2Welders1List;
  final List<WelderModel> filler2Welders2List;
  final List<WelderModel> filler3Welders1List;
  final List<WelderModel> filler3Welders2List;
  final List<WelderModel> filler4Welders1List;
  final List<WelderModel> filler4Welders2List;
  final List<WelderModel> filler5Welders1List;
  final List<WelderModel> filler5Welders2List;
  final List<WelderModel> filler6Welders1List;
  final List<WelderModel> filler6Welders2List;
  final List<WelderModel> filler7Welders1List;
  final List<WelderModel> filler7Welders2List;
  final List<WelderModel> filler8Welders1List;
  final List<WelderModel> filler8Welders2List;

  final List<WelderModel> cappingWelder1List;
  final List<WelderModel> cappingWelder2List;
  final List<WelderModel> stripWelder1List;
  final List<WelderModel> stripWelder2List;

  final List<VisualChecksModel> fitupList;
  final VisualChecksModel fitupData;

  final List<VisualChecksModel> weldVisualList;
  final VisualChecksModel weldVisualData;

  final bool isWelderLoader;

  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final bool searchLeftPipeLoader;
  final WelderModel rootWelders1Data;
  final WelderModel rootWelders2Data;
  final WelderModel hotWelders1Data;
  final WelderModel hotWelders2Data;
  final WelderModel filler1Welders1Data;
  final WelderModel filler1Welders2Data;
  final WelderModel filler2Welders1Data;
  final WelderModel filler2Welders2Data;
  final WelderModel filler3Welders1Data;
  final WelderModel filler3Welders2Data;
  final WelderModel filler4Welders1Data;
  final WelderModel filler4Welders2Data;
  final WelderModel filler5Welders1Data;
  final WelderModel filler5Welders2Data;
  final WelderModel filler6Welders1Data;
  final WelderModel filler6Welders2Data;
  final WelderModel filler7Welders1Data;
  final WelderModel filler7Welders2Data;
  final WelderModel filler8Welders1Data;
  final WelderModel filler8Welders2Data;

  final WelderModel cappingWelder1Data;
  final WelderModel cappingWelder2Data;
  final WelderModel stripWelder1Data;
  final WelderModel stripWelder2Data;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;

  final List<PipeModel> leftPipeList;
  final List<PipeModel> rightPipeList;

  final PipeModel leftPipeData;
  final PipeModel rightPipeData;

  final List<dynamic> searchLeftPipeList;

  final TextEditingController searchLeftPipeController;

  final List<dynamic> searchRightPipeList;
  final bool searchRightPipeLoader;
  final TextEditingController searchPipeRightController;
  final TextEditingController reportNumberController;
  final bool isLoaderDiaE6010BatchBatch;
  final bool isLoaderEiaE8010p1BatchBatch;
  final bool isLoaderDiaE9045p2Batch;
  final ElectrodeDiaData electrodeDiaE6010Value;
  final ElectrodeBatchData electrodeDiaE6010BatchValue;
  final ElectrodeDiaData electrodeEiaE8010p1Value;
  final ElectrodeBatchData electrodeEiaE8010p1BatchValue;
  final List<ElectrodeDiaData> electrodeDiaE6010DiaList;
  final List<ElectrodeDiaData> electrodeEiaE8010p1DiaList;
  final List<ElectrodeBatchData> electrodeDiaE6010BatchList;
  final List<ElectrodeBatchData> electrodeEiaE8010p1BatchList;
  final ElectrodeDiaData electrodeDiaE9045p2Value;
  final ElectrodeBatchData electrodeDiaE9045p2BatchValue;
  final List<ElectrodeDiaData> electrodeDiaE9045p2List;
  final List<ElectrodeBatchData> electrodeDiaE9045p2BatchList;
  final TextEditingController chainageFromController;
  final TextEditingController chainageToController;
  final TextEditingController chainageController;
  final TextEditingController electrodeDiaE81t8gBatchController;
  final TextEditingController electrodeDiaE81t8gController;
  final TextEditingController leftPipeNumberController;
  final TextEditingController rightPipeNumberController;
  final TextEditingController internalCleaningPipeController;
  final TextEditingController pigPassController;
  final TextEditingController thicknessCheckController;
  final TextEditingController preheatTempController;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;

  FetchAddTieinDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.preheatTempController,
    required this.activityRemarkController,
    required this.alignmentData,
    required this.multipleAlignmentData,
    required this.file,
    required this.welderData,
    required this.welderList,
    required this.wpsData,
    required this.wpsList,
    required this.jointNumberData,
    required this.jointNumberList,
    required this.rootWelders1List,
    required this.rootWelders2List,
    required this.hotWelders1List,
    required this.hotWelders2List,
    required this.filler1Welders1List,
    required this.filler1Welders2List,
    required this.filler2Welders1List,
    required this.filler2Welders2List,
    required this.filler3Welders1List,
    required this.filler3Welders2List,
    required this.filler4Welders1List,
    required this.filler4Welders2List,
    required this.filler5Welders1List,
    required this.filler5Welders2List,
    required this.filler6Welders1List,
    required this.filler6Welders2List,
    required this.filler7Welders1List,
    required this.filler7Welders2List,
    required this.filler8Welders1List,
    required this.filler8Welders2List,
    required this.cappingWelder1List,
    required this.cappingWelder2List,
    required this.fitupData,
    required this.fitupList,
    required this.stripWelder1List,
    required this.stripWelder2List,
    required this.weldVisualData,
    required this.weldVisualList,
    required this.electrodeDiaE81t8gBatchController,
    required this.electrodeDiaE81t8gController,
    required this.isWelderLoader,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.leftPipeNumberController,
    required this.rightPipeNumberController,
    required this.rootWelders1Data,
    required this.rootWelders2Data,
    required this.hotWelders1Data,
    required this.hotWelders2Data,
    required this.filler1Welders1Data,
    required this.filler1Welders2Data,
    required this.filler2Welders1Data,
    required this.filler2Welders2Data,
    required this.filler3Welders1Data,
    required this.filler3Welders2Data,
    required this.filler4Welders1Data,
    required this.filler4Welders2Data,
    required this.filler5Welders1Data,
    required this.filler5Welders2Data,
    required this.filler6Welders1Data,
    required this.filler6Welders2Data,
    required this.filler7Welders1Data,
    required this.filler7Welders2Data,
    required this.filler8Welders1Data,
    required this.filler8Welders2Data,
    required this.cappingWelder1Data,
    required this.cappingWelder2Data,
    required this.stripWelder1Data,
    required this.stripWelder2Data,
    required this.weatherList,
    required this.weatherData,
    required this.chainageFromController,
    required this.chainageToController,
    required this.chainageController,
    required this.leftPipeData,
    required this.leftPipeList,
    required this.rightPipeData,
    required this.rightPipeList,
    required this.searchLeftPipeController,
    required this.searchLeftPipeList,
    required this.searchLeftPipeLoader,
    required this.searchPipeRightController,
    required this.searchRightPipeList,
    required this.searchRightPipeLoader,
    required this.reportNumberController,
    required this.isLoaderDiaE6010BatchBatch,
    required this.isLoaderEiaE8010p1BatchBatch,
    required this.isLoaderDiaE9045p2Batch,
    required this.electrodeDiaE6010Value,
    required this.electrodeDiaE6010BatchValue,
    required this.electrodeEiaE8010p1Value,
    required this.electrodeEiaE8010p1BatchValue,
    required this.electrodeDiaE6010DiaList,
    required this.electrodeEiaE8010p1DiaList,
    required this.electrodeDiaE6010BatchList,
    required this.electrodeEiaE8010p1BatchList,
    required this.electrodeDiaE9045p2Value,
    required this.electrodeDiaE9045p2BatchValue,
    required this.electrodeDiaE9045p2List,
    required this.electrodeDiaE9045p2BatchList,
    required this.internalCleaningPipeController,
    required this.pigPassController,
    required this.thicknessCheckController,
  });

  @override
  List<Object> get props => [
        isLoader,
        alignmentList,
        dateController,
        preheatTempController,
        activityRemarkController,
        alignmentData,
        multipleAlignmentData,
        file,
        welderData,
        welderList,
        wpsData,
        wpsList,
        jointNumberData,
        jointNumberList,
        rootWelders1List,
        rootWelders2List,
        hotWelders1List,
        hotWelders2List,
        filler1Welders1List,
        filler1Welders2List,
        filler2Welders1List,
        filler2Welders2List,
        filler3Welders1List,
        filler3Welders2List,
        filler4Welders1List,
        filler4Welders2List,
        filler5Welders1List,
        filler5Welders2List,
        filler6Welders1List,
        filler6Welders2List,
        filler7Welders1List,
        filler7Welders2List,
        filler8Welders1List,
        filler8Welders2List,
        cappingWelder1List,
        cappingWelder2List,
        fitupData,
        fitupList,
        stripWelder1List,
        stripWelder2List,
        weldVisualData,
        weldVisualList,
        electrodeDiaE81t8gBatchController,
        electrodeDiaE81t8gController,
        isWelderLoader,
        jointTypeData,
        jointTypeList,
        isJointNumberLoader,
        leftPipeNumberController,
        rightPipeNumberController,
        rootWelders1Data,
        rootWelders2Data,
        hotWelders1Data,
        hotWelders2Data,
        filler1Welders1Data,
        filler1Welders2Data,
        filler2Welders1Data,
        filler2Welders2Data,
        filler3Welders1Data,
        filler3Welders2Data,
        filler4Welders1Data,
        filler4Welders2Data,
        filler5Welders1Data,
        filler5Welders2Data,
        filler6Welders1Data,
        filler6Welders2Data,
        filler7Welders1Data,
        filler7Welders2Data,
        filler8Welders1Data,
        filler8Welders2Data,
        cappingWelder1Data,
        cappingWelder2Data,
        stripWelder1Data,
        stripWelder2Data,
        weatherList,
        weatherData,
        chainageFromController,
        chainageToController,
        chainageController,
        leftPipeData,
        rightPipeData,
        leftPipeList,
        rightPipeList,
        searchLeftPipeController,
        searchLeftPipeList,
        searchLeftPipeLoader,
        searchPipeRightController,
        searchRightPipeList,
        searchRightPipeLoader,
        reportNumberController,
        isLoaderDiaE6010BatchBatch,
        isLoaderEiaE8010p1BatchBatch,
        isLoaderDiaE9045p2Batch,
        electrodeDiaE6010Value,
        electrodeDiaE6010BatchValue,
        electrodeEiaE8010p1Value,
        electrodeEiaE8010p1BatchValue,
        electrodeDiaE6010DiaList,
        electrodeEiaE8010p1DiaList,
        electrodeDiaE6010BatchList,
        electrodeEiaE8010p1BatchList,
        electrodeDiaE9045p2Value,
        electrodeDiaE9045p2BatchValue,
        electrodeDiaE9045p2List,
        electrodeDiaE9045p2BatchList,
        internalCleaningPipeController,
        pigPassController,
        thicknessCheckController,
      ];
}
