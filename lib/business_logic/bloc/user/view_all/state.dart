import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserFetchInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  UserLoaded(this.users);

  final List<User> users;
  @override
  List<Object> get props => [];
}

class UserError extends UserState {
  @override
  List<Object> get props => [];
}
