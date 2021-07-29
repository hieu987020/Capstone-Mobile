import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UserSearchState extends Equatable {}

class UserSearchInitial extends UserSearchState {
  @override
  List<Object> get props => [];
}

class UserSearchLoading extends UserSearchState {
  @override
  List<Object> get props => [];
}

class UserSearchLoaded extends UserSearchState {
  UserSearchLoaded(this.users);

  final List<User> users;
  @override
  List<Object> get props => [];
}

class UserSearchError extends UserSearchState {
  @override
  List<Object> get props => [];
}
