import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UserUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class UserUpdateInitialEvent extends UserUpdateEvent {}

class UserUpdateSubmit extends UserUpdateEvent {
  final User user;
  UserUpdateSubmit(this.user);
}
