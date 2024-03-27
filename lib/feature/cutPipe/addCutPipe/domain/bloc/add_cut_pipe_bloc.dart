

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/cutPipe/addCutPipe/helper/add_cut_pipe_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/helper/add_stringing_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';

part 'add_cut_pipe_event.dart';
part 'add_cut_pipe_state.dart';

class AddCutPipeBloc extends Bloc<AddCutPipeEvent, AddCutPipeState> {

  bool _isLoader =  false;
  bool get isLoader => _isLoader;

  List<PipeModel> _pipeList = [];
  List<PipeModel> get pipeList => _pipeList;

  PipeModel _pipeData =  PipeModel();
  PipeModel get pipeData => _pipeData;

  List<dynamic> _searchPipeList = [];
  List<dynamic> get searchPipeList => _searchPipeList;

  TextEditingController searchPipeController =  TextEditingController();

  bool _searchPipeLoader =  false;
  bool get searchPipeLoader => _searchPipeLoader;

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  TextEditingController cutPipeLengthController =  TextEditingController();

  AddCutPipeBloc() : super(AddCutPipeInitial()) {
    on<AddCutPipePageLoadEvent>(_pageLoader);
    on<AddCutPipeSelectPipeDataEvent>(_selectPipeData);
    on<AddCutPipeSearchPipeDataEvent>(_searchPipeData);
    on<AddCutPipeSubmitEvent>(_submitData);
  }

  _pageLoader(AddCutPipePageLoadEvent event, emit) async {
    emit(AddCutPipePageLoadState());
    _isLoader =  false;
    _searchPipeLoader =  false;
    _pipeList = [];
    _searchPipeList = [];
    _pipeData = PipeModel();
    cutPipeLengthController.text = "";
    searchPipeController.text = "";
    _userData =  UserInfo.instanceInit()!.userData!;
    _eventComplete(emit);
  }

  _selectPipeData(AddCutPipeSelectPipeDataEvent event, emit) {
    _pipeData =  event.pipeData;
    searchPipeController.text =  pipeData.pipeNumber.toString();
    _searchPipeList = [];
    _eventComplete(emit);
  }


  _searchPipeData(AddCutPipeSearchPipeDataEvent event, emit) async {
    _pipeList = [];
    _searchPipeLoader =  true;
    _eventComplete(emit);
    var resPipe =  await AddStringingHelper.fetchPipeData(context: event.context,
        userData: userData, searchKeyword: event.keyword.toString(), type: "bending");
    if(resPipe != null){
      _pipeList =  resPipe;
      _searchPipeList = pipeList;
    }
    _searchPipeLoader =  false;
    _eventComplete(emit);
  }

  _submitData(AddCutPipeSubmitEvent event, emit) async {

    var textFiledValidation =  await AddCutPipeHelper.textFieldValidation(context: event.context,
         cutePipeLength: cutPipeLengthController.text.toString());
    if(textFiledValidation == false){
      return;
    }
    _isLoader =  true;
    _eventComplete(emit);
    var res =  await AddCutPipeHelper.submitData(context: event.context.mounted ? event.context : event.context,
        cutePipeLength: cutPipeLengthController.text.toString(), pipeData: pipeData, userData: userData);
    if(res != null){
      _pipeData = PipeModel();
      cutPipeLengthController.text = "";
      searchPipeController.text = "";
    }
    _isLoader =  false;
    _eventComplete(emit);
  }

  _eventComplete(Emitter<AddCutPipeState>emit) {
    emit(FetchAddCutPipeDataState(pipeData: pipeData,
        pipeList: pipeList,
        isLoader: isLoader,
        cutPipeLengthController: cutPipeLengthController,
        searchPipeController: searchPipeController,
        searchPipeList: searchPipeList,
        searchPipeLoader: searchPipeLoader,
    ));
  }
}
