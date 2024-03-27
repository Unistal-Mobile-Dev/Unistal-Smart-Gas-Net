

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/restoreCutePipe/helper/restore_cut_pipe_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';

part 'restore_cut_pipe_event.dart';
part 'restore_cut_pipe_state.dart';

class RestoreCutPipeBloc extends Bloc<RestoreCutPipeEvent, RestoreCutPipeState> {

  List<PipeModel> _pipeList = [];
  List<PipeModel> get pipeList => _pipeList;

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  RestoreCutPipeBloc() : super(RestoreCutPipeInitial()) {
    on<RestoreCutePipePageLoadEvent>(_pageLoad);
    on<RestoreCutePipeSubmitEvent>(_submit);
  }

  _pageLoad(RestoreCutePipePageLoadEvent event, emit) async {
    emit(RestoreCutPipePageLoadState());
    _pipeList = [];
    var res =  await RestoreCutPipeHelper.fetchCutePipeList();
    if(res != null) {
      _pipeList = res;
    }
    _eventComplete(emit);
  }

  _submit(RestoreCutePipeSubmitEvent event, emit) async {
     _isLoader =  true;
      _pipeList[event.index].isSelected =  true;
      PipeModel pipeData =  pipeList[event.index];
     _eventComplete(emit);
     var res =  await RestoreCutPipeHelper.submitData(context: event.context, pipeData: pipeData);
     if(res != null){
       _pipeList = [];
       var resPipe =  await RestoreCutPipeHelper.fetchCutePipeList();
       if(resPipe != null) {
         _pipeList = resPipe;
       }
     }else{
       _pipeList[event.index].isSelected =  false;
     }
     _isLoader =  false;
     _eventComplete(emit);
  }

  _eventComplete(Emitter<RestoreCutPipeState>emit) {
    emit(FetchRestoreCutPipeDataState(isLoader: isLoader, pipeList: pipeList));
  }
}
