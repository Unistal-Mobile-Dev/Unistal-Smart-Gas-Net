import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/test/helper/test_helper.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardPageLoadEvent>(_pageLoad);
  }

  _pageLoad(DashboardPageLoadEvent event, emit) async {
    emit(DashboardPageLoadState());
    if(!event.context.mounted) return ;
    await TestHelper.fetchUIWidgetData(context: event.context);
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<DashboardState>emit) {
    emit(FetchDashboardDataState());
  }
}
