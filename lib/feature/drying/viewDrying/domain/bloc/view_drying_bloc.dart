import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_drying_event.dart';

part 'view_drying_state.dart';

class ViewDryingBloc extends Bloc<ViewDryingEvent, ViewDryingState> {
  ViewDryingBloc() : super(ViewDryingInitial()) {
    on<ViewDryingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
