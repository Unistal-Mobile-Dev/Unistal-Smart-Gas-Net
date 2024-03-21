import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_bending_event.dart';
part 'view_bending_state.dart';

class ViewBendingBloc extends Bloc<ViewBendingEvent, ViewBendingState> {
  ViewBendingBloc() : super(ViewBendingInitial()) {
    on<ViewBendingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
