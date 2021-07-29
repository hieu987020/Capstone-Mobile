import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UserDetailState extends Equatable {}

class UserDetailFetchInitial extends UserDetailState {
  @override
  List<Object> get props => [];
}

class UserDetailLoading extends UserDetailState {
  @override
  List<Object> get props => [];
}

class UserDetailLoaded extends UserDetailState {
  UserDetailLoaded(this.user);

  final User user;
  @override
  List<Object> get props => [];
}

class UserDetailError extends UserDetailState {
  @override
  List<Object> get props => [];
}
