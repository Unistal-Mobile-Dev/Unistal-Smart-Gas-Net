import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/forgotPassword/helper/forgot_password_helper.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  bool _isLoader = false;

  bool get isLoader => _isLoader;

  TextEditingController emailTextFieldController = TextEditingController();

  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordPageLoadEvent>(_pageLoad);
    on<ForgotPasswordSubmitEvent>(_submitEvent);
  }

  _pageLoad(ForgotPasswordPageLoadEvent event, emit) {
    _isLoader = false;
    emailTextFieldController.text = "";
    _eventCompleted(emit);
  }

  _submitEvent(ForgotPasswordSubmitEvent event, emit) async {
    _isLoader = true;
    _eventCompleted(emit);
    var res = await ForgotPasswordHelper.submitEmailOnServer(
        email: emailTextFieldController.text.toString(),
        context: event.context);
    _isLoader = false;
    _eventCompleted(emit);
    if (res == true) {
      Navigator.pop(event.context);
    }
  }

  _eventCompleted(Emitter<ForgotPasswordState> emit) {
    emit(FetchForgotPasswordDataState(
        isLoader: isLoader,
        emailTextFieldController: emailTextFieldController));
  }
}
