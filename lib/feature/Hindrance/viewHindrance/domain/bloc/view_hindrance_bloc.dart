import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/bloc/view_hindrance_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/bloc/view_hindrance_state.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/model/HindranceListModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/helper/view_hindrance_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';

class ViewHindranceBloc extends Bloc<ViewHindranceEvent, ViewHindranceState> {


  bool isLoader = false;
  bool isHindranceSearch = false;

  TextEditingController searchingCtrl = TextEditingController();


  LoginDataModel _userData = LoginDataModel();
  LoginDataModel get userData => _userData;

  List<HindranceListData> listOfHindranceTableData = [];
  List<HindranceListData> listOfFilterHindranceTableData = [];


  ViewHindranceBloc() : super(ViewHindranceInitial()) {
    on<ViewHindrancePageLoadEvent>(_pageLoad);
    on<ViewHindranceSearchingEvent>(_searchReportNumber);
  }

  _pageLoad(ViewHindrancePageLoadEvent event, emit) async {
    emit(ViewHindrancePageLoadState());
    isLoader = false;
    isHindranceSearch = false;
    searchingCtrl = TextEditingController();
    listOfHindranceTableData = [];
    listOfFilterHindranceTableData = [];
    _userData = UserInfo.instanceInit()!.userData!;
  var res = await ViewHindranceHelper.fetchHindranceListData(search: "", userData: userData);
  if(res != null){
    listOfHindranceTableData = res;
    listOfFilterHindranceTableData = listOfHindranceTableData;
  }
    _eventComplete(emit);
  }


   _searchReportNumber(ViewHindranceSearchingEvent event, emit) async {
    final query = event.searching.trim();
    if (query.isEmpty) {
      listOfFilterHindranceTableData = listOfHindranceTableData;
    } else {
      listOfFilterHindranceTableData = listOfHindranceTableData.where((e) {
        final bp = e.reportNo?.toString() ?? '';
        return bp.contains(query) ;
      }).toList();
    }
    _eventComplete(emit);
  }


  _eventComplete(Emitter<ViewHindranceState> emit) {
    emit(FetchViewHindranceDataState(
      isLoader: isLoader,
      isHindranceSearch: isHindranceSearch,
      searchingCtrl: searchingCtrl,
      listOfHindranceTableData: listOfFilterHindranceTableData,
    ));
  }

}
