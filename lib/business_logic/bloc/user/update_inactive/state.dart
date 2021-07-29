import 'package:equatable/equatable.dart';

class UserInactiveState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInactiveInitial extends UserInactiveState {}

class UserInactiveLoading extends UserInactiveState {}

class UserInactiveError extends UserInactiveState {
  final String message;
  UserInactiveError(this.message);
}

class UserInactiveLoaded extends UserInactiveState {}
