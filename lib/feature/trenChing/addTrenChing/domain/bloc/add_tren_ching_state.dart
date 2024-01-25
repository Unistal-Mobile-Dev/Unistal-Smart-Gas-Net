part of 'add_tren_ching_bloc.dart';

abstract class AddTrenChingState extends Equatable {
  const AddTrenChingState();
}

class AddTrenChingInitial extends AddTrenChingState {
  @override
  List<Object> get props => [];
}

class AddTrenChingPageLoadState extends AddTrenChingInitial {
  @override
  List<Object> get props => [];
}

class FetchAddTrenChingDataState extends AddTrenChingInitial {
  final List<AlignmentModel> alignmentList;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController reportNumberController;
  final TextEditingController fromJointIdController;
  final TextEditingController toJointIdController;
  final TextEditingController trenchingDepthController;
  final TextEditingController terrainController;
  final TextEditingController activityRemarkController;
  final AlignmentModel  alignmentData;
  final File file;
  final List<JointNumberModel>  jointNumberList;
  final JointNumberModel jointNumberData;

  FetchAddTrenChingDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.reportNumberController,
    required this.terrainController,
    required this.fromJointIdController,
    required this.toJointIdController,
    required this.trenchingDepthController,
    required this.alignmentData,
    required this.file,
    required this.jointNumberData,
    required this.jointNumberList,
  });

  @override
  List<Object> get props => [
    alignmentList,
    isLoader,
    dateController,
    activityRemarkController,
    reportNumberController,
    terrainController,
    fromJointIdController,
    toJointIdController,
    trenchingDepthController,
    alignmentData,
    file,
    jointNumberData,
    jointNumberList,
  ];
}