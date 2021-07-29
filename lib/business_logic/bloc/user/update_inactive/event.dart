import 'package:equatable/equatable.dart';

class UserInactiveEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInactiveInitialEvent extends UserInactiveEvent {}

class UserChangeToInactive extends UserInactiveEvent {
  final String userName;
  final String reasonInactive;
  UserChangeToInactive(this.userName, this.reasonInactive);
}
