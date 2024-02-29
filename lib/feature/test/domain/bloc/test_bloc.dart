import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/domain/model/test_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/helper/test_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {

  List<TestModel> _testList = [];
  List<TestModel> get testList => _testList;

  LoginDataModel _userData =  LoginDataModel();
  LoginDataModel get userData => _userData;

  TestBloc() : super(TestInitial()) {
    on<TestPageLoadEvent>(_pageLoad);
    on<TestPageSelectAlignmentData>(_selectAlignment);
  }

  _pageLoad(TestPageLoadEvent event, emit) async {
    emit(TestPageLoadState());
    _testList = [];
    _userData =  UserInfo.instanceInit()!.userData!;
    _testList =  await TestHelper.fetchUIWidgetData(context: event.context);
    _testList =  await TestHelper.widgetBuilder(context: event.context, testList: testList, userData: userData);
    _eventComplete(emit);
  }

  _selectAlignment(TestPageSelectAlignmentData event, emit) async {
    _testList =  await TestHelper.widgetBuilderRefresh(context: event.context, testList: event.testList, userData: userData);
    _eventComplete(emit);
  }

  _eventComplete(Emitter<TestState>emit) {
    emit(FetchTestDataState(testList: testList));
  }
}
