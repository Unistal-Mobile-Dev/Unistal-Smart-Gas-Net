part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {}

class ForgotPasswordPageLoadEvent extends ForgotPasswordEvent {
  final BuildContext context;

  ForgotPasswordPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  final BuildContext context;

  ForgotPasswordSubmitEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
