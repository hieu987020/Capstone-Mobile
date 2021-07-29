import 'dart:io';

import 'package:capstone/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserCreateInitialEvent extends UserCreateEvent {}

class UserCreateSubmitEvent extends UserCreateEvent {
  final User user;
  final File imageFile;
  UserCreateSubmitEvent(this.user, this.imageFile);
  @override
  List<Object> get props => [];
}
