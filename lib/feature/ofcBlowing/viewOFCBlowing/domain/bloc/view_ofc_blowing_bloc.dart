import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_ofc_blowing_event.dart';
part 'view_ofc_blowing_state.dart';

class ViewOFCBlowingBloc
    extends Bloc<ViewOFCBlowingEvent, ViewOFCBlowingState> {
  ViewOFCBlowingBloc() : super(ViewOFCBlowingInitial()) {
    on<ViewOFCBlowingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
