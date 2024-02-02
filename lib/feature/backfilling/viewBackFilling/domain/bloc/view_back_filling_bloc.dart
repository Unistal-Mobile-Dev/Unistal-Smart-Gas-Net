import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_back_filling_event.dart';
part 'view_back_filling_state.dart';

class ViewBackFillingBloc extends Bloc<ViewBackFillingEvent, ViewBackFillingState> {
  ViewBackFillingBloc() : super(ViewBackFillingInitial()) {
    on<ViewBackFillingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
