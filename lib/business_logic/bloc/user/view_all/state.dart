import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  UserLoaded(this.users, this.reachMax);

  final List<User> users;
  final bool reachMax;
  @override
  List<Object> get props => [];
}

class UserLoadedMore extends UserState {
  UserLoadedMore(this.users, this.reachMax);

  final List<User> users;
  final bool reachMax;
  @override
  List<Object> get props => [];
}

class UserError extends UserState {
  @override
  List<Object> get props => [];
}
