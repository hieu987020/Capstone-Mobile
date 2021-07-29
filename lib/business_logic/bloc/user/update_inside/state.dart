import 'package:equatable/equatable.dart';

class UserUpdateInsideState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserUpdateInsideInitial extends UserUpdateInsideState {}

class UserUpdateInsideLoading extends UserUpdateInsideState {}

class UserUpdateInsideError extends UserUpdateInsideState {
  final String message;
  UserUpdateInsideError(this.message);
}

class UserUpdateInsideLoaded extends UserUpdateInsideState {}
