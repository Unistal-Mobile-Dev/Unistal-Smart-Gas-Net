part of 'restore_cut_pipe_bloc.dart';

abstract class RestoreCutPipeEvent extends Equatable {
  const RestoreCutPipeEvent();
}

class RestoreCutePipePageLoadEvent extends RestoreCutPipeEvent {
  final BuildContext context;

  const RestoreCutePipePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class RestoreCutePipeSubmitEvent extends RestoreCutPipeEvent {
  final BuildContext context;
  final int index;

  const RestoreCutePipeSubmitEvent(
      {required this.context, required this.index});

  @override
  List<Object?> get props => [context, index];
}
