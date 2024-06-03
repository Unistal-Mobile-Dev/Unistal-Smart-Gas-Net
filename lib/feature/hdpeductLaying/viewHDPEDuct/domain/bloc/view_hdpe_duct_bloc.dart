import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_hdpe_duct_event.dart';
part 'view_hdpe_duct_state.dart';

class ViewHdpeDuctBloc extends Bloc<ViewHdpeDuctEvent, ViewHdpeDuctState> {
  ViewHdpeDuctBloc() : super(ViewHdpeDuctInitial()) {
    on<ViewHdpeDuctEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
