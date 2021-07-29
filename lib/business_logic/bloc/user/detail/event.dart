import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class UserDetailInitialEvent extends UserDetailEvent {}

class UserDetailFetchEvent extends UserDetailEvent {
  final String userName;
  UserDetailFetchEvent(this.userName);
}
