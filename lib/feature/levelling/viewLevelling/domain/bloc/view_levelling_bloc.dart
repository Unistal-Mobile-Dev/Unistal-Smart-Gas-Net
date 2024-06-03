import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_levelling_event.dart';

part 'view_levelling_state.dart';

class ViewLevellingBloc extends Bloc<ViewLevellingEvent, ViewLevellingState> {
  ViewLevellingBloc() : super(ViewLevellingInitial()) {
    on<ViewLevellingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
