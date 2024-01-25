part of 'add_clearing_grading_bloc.dart';

abstract class AddClearingGradingEvent extends Equatable {
  const AddClearingGradingEvent();
}

class AddClearingGradingPageLoadEvent extends AddClearingGradingEvent {
  final BuildContext context;
  const AddClearingGradingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddClearingGradingSelectDateEvent extends AddClearingGradingEvent {
  final BuildContext context;
  const AddClearingGradingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddClearingGradingSelectAlignmentEvent extends AddClearingGradingEvent {
  final AlignmentModel  alignmentData;
  const AddClearingGradingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddClearingGradingAddImageEvent extends AddClearingGradingEvent {
  final BuildContext context;
  const AddClearingGradingAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddClearingGradingSubmitDataEvent extends AddClearingGradingEvent {
  final BuildContext context;
  const AddClearingGradingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}