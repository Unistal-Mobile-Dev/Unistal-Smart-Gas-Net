import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginState extends Equatable {}

class LoginStateInit extends LoginState {
  @override
  List<Object?> get props => [];
}

class FetchLoginStateData extends LoginStateInit {
  final bool isLoader;
  final bool isPassword;
  final bool appLogoLoader;
  final TextEditingController userNameTextFiledController;
  final TextEditingController passwordTextFieldController;
  final String appLogo;

  FetchLoginStateData({
    required this.isLoader,
    required this.isPassword,
    required this.appLogoLoader,
    required this.appLogo,
    required this.userNameTextFiledController,
    required this.passwordTextFieldController,
  });

  @override
  List<Object?> get props => [
        isLoader,
        isPassword,
        appLogoLoader,
        appLogo,
        userNameTextFiledController,
        passwordTextFieldController,

      ];
}
