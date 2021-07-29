import 'package:equatable/equatable.dart';

abstract class UserCreateState extends Equatable {
  const UserCreateState();

  @override
  List<Object> get props => [];
}

class UserCreateInitial extends UserCreateState {}

class UserCreateLoading extends UserCreateState {}

class UserCreateLoaded extends UserCreateState {}

class UserCreateDuplicatedEmail extends UserCreateState {
  final String message;
  UserCreateDuplicatedEmail(this.message);
  @override
  List<Object> get props => [message];
}

class UserCreateDuplicateIdentifyCard extends UserCreateState {
  final String message;
  UserCreateDuplicateIdentifyCard(this.message);
  @override
  List<Object> get props => [message];
}

class UserCreateError extends UserCreateState {
  final String message;
  UserCreateError(this.message);
  @override
  List<Object> get props => [message];
}
