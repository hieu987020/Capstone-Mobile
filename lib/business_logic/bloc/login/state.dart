import 'package:capstone/data/models/login.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginInvalid extends LoginState {
  final String message;
  LoginInvalid(this.message);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginManagerLoaded extends LoginState {
  final LoginModel loginModel;

  LoginManagerLoaded(this.loginModel);
}

class LoginAdminLoaded extends LoginState {
  final LoginModel loginModel;

  LoginAdminLoaded(this.loginModel);
}
