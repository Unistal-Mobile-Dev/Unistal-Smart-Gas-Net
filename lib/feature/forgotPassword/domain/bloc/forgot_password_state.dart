part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable { }

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordPageLoadState extends ForgotPasswordInitial {
  @override
  List<Object> get props => [];
}

class FetchForgotPasswordDataState extends ForgotPasswordInitial {
  final bool isLoader;
  final TextEditingController emailTextFieldController;
  FetchForgotPasswordDataState({required this.isLoader, required this.emailTextFieldController});
  @override
  List<Object> get props => [isLoader, emailTextFieldController];
}
