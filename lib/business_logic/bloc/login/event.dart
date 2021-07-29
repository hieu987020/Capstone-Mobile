import 'package:capstone/data/models/login.dart';
import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class LoginClickLoginButton extends LoginEvent {
  final LoginModel loginModel;
  LoginClickLoginButton(this.loginModel);
}
