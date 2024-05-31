part of 'add_cut_pipe_bloc.dart';

abstract class AddCutPipeState extends Equatable {
  const AddCutPipeState();
}

class AddCutPipeInitial extends AddCutPipeState {
  @override
  List<Object> get props => [];
}

class AddCutPipePageLoadState extends AddCutPipeInitial {
  @override
  List<Object> get props => [];
}

class FetchAddCutPipeDataState extends AddCutPipeInitial {
  final bool isLoader;
  final bool searchPipeLoader;
  final List<PipeModel> pipeList;
  final List<dynamic> searchPipeList;
  final PipeModel pipeData;
  final TextEditingController cutPipeLengthController;
  final TextEditingController searchPipeController;

  FetchAddCutPipeDataState({
    required this.pipeData,
    required this.pipeList,
    required this.searchPipeList,
    required this.isLoader,
    required this.searchPipeLoader,
    required this.cutPipeLengthController,
    required this.searchPipeController,
  });

  @override
  List<Object> get props => [
        pipeData,
        pipeList,
        searchPipeList,
        isLoader,
        searchPipeLoader,
        cutPipeLengthController,
        searchPipeController,
      ];
}
