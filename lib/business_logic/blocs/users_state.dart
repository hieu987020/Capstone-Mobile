import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {}

class InitialState extends UsersState {
  @override
  List<Object> get props => [];
}

class LoadingState extends UsersState {
  @override
  List<Object> get props => [];
}

class LoadedState extends UsersState {
  LoadedState(this.users);

  final List<Users> users;

  @override
  List<Object> get props => [users];
}

class ErrorState extends UsersState {
  @override
  List<Object> get props => [];
}
