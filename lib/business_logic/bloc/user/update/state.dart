import 'package:equatable/equatable.dart';

abstract class UserUpdateState extends Equatable {}

class UserUpdateInitial extends UserUpdateState {
  @override
  List<Object> get props => [];
}

class UserUpdateLoading extends UserUpdateState {
  @override
  List<Object> get props => [];
}

class UserUpdateDuplicatedEmail extends UserUpdateState {
  final String message;
  UserUpdateDuplicatedEmail(this.message);
  @override
  List<Object> get props => [message];
}

class UserUpdateDuplicateIdentifyCard extends UserUpdateState {
  final String message;
  UserUpdateDuplicateIdentifyCard(this.message);
  @override
  List<Object> get props => [message];
}

class UserUpdateError extends UserUpdateState {
  final String message;

  UserUpdateError(this.message);
  @override
  List<Object> get props => [];
}

class UserUpdateLoaded extends UserUpdateState {
  @override
  List<Object> get props => [];
}
