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
  final AlignmentModel  alignmentData;
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
    pipeList
  ];
}
