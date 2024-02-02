import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_clearning_grading_event.dart';
part 'view_clearning_grading_state.dart';

class ViewClearningGradingBloc extends Bloc<ViewClearningGradingEvent, ViewClearningGradingState> {
  ViewClearningGradingBloc() : super(ViewClearningGradingInitial()) {
    on<ViewClearningGradingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
