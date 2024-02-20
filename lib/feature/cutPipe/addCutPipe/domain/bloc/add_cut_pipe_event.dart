part of 'add_cut_pipe_bloc.dart';

abstract class AddCutPipeEvent extends Equatable {
  const AddCutPipeEvent();
}

class AddCutPipePageLoadEvent extends AddCutPipeEvent {
  final BuildContext context;
  const AddCutPipePageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddCutPipeSelectPipeDataEvent extends AddCutPipeEvent {
  final PipeModel pipeData;
  const AddCutPipeSelectPipeDataEvent({required this.pipeData});
  @override
  List<Object?> get props => [pipeData];
}

class AddCutPipeSearchPipeDataEvent extends AddCutPipeEvent {
  final BuildContext context;
  final String keyword;
  const AddCutPipeSearchPipeDataEvent({required this.context, required this.keyword});
  @override
  List<Object?> get props => [context, keyword];
}

class AddCutPipeSubmitEvent extends AddCutPipeEvent {
  final BuildContext context;
  const AddCutPipeSubmitEvent({required this.context});
  @override
  List<Object?> get props => [context];
}