part of 'add_welder_repair_bloc.dart';

abstract class AddWelderRepairEvent extends Equatable {
  const AddWelderRepairEvent();
}

class AddWelderRepairLoadEvent extends AddWelderRepairEvent {
  final BuildContext context;

  const AddWelderRepairLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddWelderRepairSelectDateEvent extends AddWelderRepairEvent {
  final BuildContext context;

  const AddWelderRepairSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddWelderRepairSelectAlignmentEvent extends AddWelderRepairEvent {
   final AlignmentModel alignmentData;

  const AddWelderRepairSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddWelderRepairMultipleSelectAlignmentEvent extends AddWelderRepairEvent {
  final List<AlignmentModel> alignmentData;

  const AddWelderRepairMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddWelderRepairSelectWelderEvent extends AddWelderRepairEvent {
  final WelderModel welderData;

  const AddWelderRepairSelectWelderEvent({required this.welderData});

  @override
  List<Object?> get props => [welderData];
}

class AddWelderRepairSelectWPSTypeEvent extends AddWelderRepairEvent {
  final WPSModel wpsTypeData;
  final BuildContext context;

  const AddWelderRepairSelectWPSTypeEvent(
      {required this.wpsTypeData, required this.context});

  @override
  List<Object?> get props => [wpsTypeData, context];
}

class AddWelderRepairSelectSegmentEvent extends AddWelderRepairEvent {
  final List<SegmentModel> selectedSegmentList;

  const AddWelderRepairSelectSegmentEvent({required this.selectedSegmentList});

  @override
  List<Object?> get props => [selectedSegmentList];
}

class AddConcreteCoatingAddSearchPipeDataEvent extends AddWelderRepairEvent {
  final BuildContext context;
  final String keyword;

  const AddConcreteCoatingAddSearchPipeDataEvent(
      {required this.context, required this.keyword});

  @override
  List<Object?> get props => [context, keyword];
}

class AddConcreteCoatingSelectSelectPipeDataEvent extends AddWelderRepairEvent {
  final PipeModel pipeData;

  const AddConcreteCoatingSelectSelectPipeDataEvent({required this.pipeData});

  @override
  List<Object?> get props => [pipeData];
}

class AddWelderRepairSelectWeldVisualEvent extends AddWelderRepairEvent {
  final VisualChecksModel weldVisualData;

  const AddWelderRepairSelectWeldVisualEvent({required this.weldVisualData});

  @override
  List<Object?> get props => [weldVisualData];
}

class AddWelderRepairSelectJointTypeEvent extends AddWelderRepairEvent {
  final JointTypeModel jointTypeModel;
  final BuildContext context;

  const AddWelderRepairSelectJointTypeEvent(
      {required this.jointTypeModel, required this.context});

  @override
  List<Object?> get props => [jointTypeModel, context];
}

class AddWelderRepairSelectJointNumberEvent extends AddWelderRepairEvent {
  final JointNumberModel jointNumberData;

  const AddWelderRepairSelectJointNumberEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddWelderRepairAddImageEvent extends AddWelderRepairEvent {
  final BuildContext context;
  final int mediaType;

  const AddWelderRepairAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddWelderRepairEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddLoweringSelectPipeThicknessEvent extends AddWelderRepairEvent {
  final ThicknessModel pipeThicknessValue;

  const AddLoweringSelectPipeThicknessEvent({required this.pipeThicknessValue});

  @override
  List<Object?> get props => [pipeThicknessValue];
}

class AddWeldingCalculateLengthEvent extends AddWelderRepairEvent {
  final bool isChainageTo;
  final String value;
  const AddWeldingCalculateLengthEvent({required this.isChainageTo, required this.value});
  @override
  List<Object?> get props => [isChainageTo, value];
}

class AddWelderRepairSubmitDataEvent extends AddWelderRepairEvent {
  final BuildContext context;

  const AddWelderRepairSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
