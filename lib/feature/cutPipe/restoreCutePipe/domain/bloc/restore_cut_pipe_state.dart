part of 'restore_cut_pipe_bloc.dart';

abstract class RestoreCutPipeState extends Equatable {
  const RestoreCutPipeState();
}

class RestoreCutPipeInitial extends RestoreCutPipeState {
  @override
  List<Object> get props => [];
}

class RestoreCutPipePageLoadState extends RestoreCutPipeInitial {
  @override
  List<Object> get props => [];
}

class FetchRestoreCutPipeDataState extends RestoreCutPipeInitial {
  final List<PipeModel> pipeList;
  final bool isLoader;

  FetchRestoreCutPipeDataState(
      {required this.isLoader, required this.pipeList});

  @override
  List<Object> get props => [pipeList, isLoader];
}
