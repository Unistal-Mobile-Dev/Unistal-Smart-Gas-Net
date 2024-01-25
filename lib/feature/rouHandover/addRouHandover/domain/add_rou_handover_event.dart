part of 'add_rou_handover_bloc.dart';

abstract class AddRouHandoverEvent extends Equatable {
  const AddRouHandoverEvent();
}

class AddRouHandoverLoadEvent extends AddRouHandoverEvent {
  final BuildContext context;
  const AddRouHandoverLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRouHandoverSelectDateEvent extends AddRouHandoverEvent {
  final BuildContext context;
  const AddRouHandoverSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRouHandoverSelectAlignmentEvent extends AddRouHandoverEvent {
  final AlignmentModel  alignmentData;
  const AddRouHandoverSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddRouHandoverAddImageEvent extends AddRouHandoverEvent {
  final BuildContext context;
  const AddRouHandoverAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRouHandoverSubmitDataEvent extends AddRouHandoverEvent {
  final BuildContext context;
  const AddRouHandoverSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}