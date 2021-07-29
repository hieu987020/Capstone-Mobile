import 'package:equatable/equatable.dart';

abstract class UserUpdateImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserUpdateImageInitial extends UserUpdateImageState {}

class UserUpdateImageError extends UserUpdateImageState {
  final String message;

  UserUpdateImageError(this.message);
}

class UserUpdateImageLoaded extends UserUpdateImageState {}

class UserUpdateImageLoading extends UserUpdateImageState {}
