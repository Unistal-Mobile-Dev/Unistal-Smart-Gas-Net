part of 'add_welding_bloc.dart';

abstract class AddWeldingEvent extends Equatable {
  const AddWeldingEvent();
}
class AddWeldingPageLoadEvent extends AddWeldingEvent {
  final BuildContext context;
  const AddWeldingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddWeldingSelectDateEvent extends AddWeldingEvent {
  final BuildContext context;
  const AddWeldingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddWeldingSelectAlignmentEvent extends AddWeldingEvent {
  final AlignmentModel  alignmentData;
  const AddWeldingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddWeldingSelectWPSEvent extends AddWeldingEvent {
  final WPSModel  wpsData;
  final BuildContext context;
  const AddWeldingSelectWPSEvent({required this.wpsData, required this.context});
  @override
  List<Object?> get props => [wpsData, context];
}

class AddWeldingSelectJointTypeEvent extends AddWeldingEvent {
  final JointTypeModel  jointTypeData;
  final BuildContext context;
  const AddWeldingSelectJointTypeEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddWeldingSelectJointNumberEvent extends AddWeldingEvent {
  final JointNumberModel  jointNumberData;
  const AddWeldingSelectJointNumberEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddWeldingSelectFitupDataEvent extends AddWeldingEvent {
  final VisualChecksModel  fitupData;
  const AddWeldingSelectFitupDataEvent({required this.fitupData});
  @override
  List<Object?> get props => [fitupData];
}

class AddWeldingSelectWeldVisualEvent extends AddWeldingEvent {
  final VisualChecksModel  weldVisualData;
  const AddWeldingSelectWeldVisualEvent({required this.weldVisualData});
  @override
  List<Object?> get props => [weldVisualData];
}

class AddWeldingSelectWelderEvent extends AddWeldingEvent {
  final WelderModel  welderData;
  const AddWeldingSelectWelderEvent({required this.welderData,});
  @override
  List<Object?> get props => [welderData];
}

class AddWeldingAddImageEvent extends AddWeldingEvent {
  final BuildContext context;
  const AddWeldingAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddWeldingSelectMultiWelderEvent extends AddWeldingEvent {
  final String name;
  final WelderModel welderData;
  const AddWeldingSelectMultiWelderEvent({required this.welderData, required this.name});
  @override
  List<Object?> get props => [welderData,name];
}

class AddWeldingSubmitDataEvent extends AddWeldingEvent {
  final BuildContext context;
  const AddWeldingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}