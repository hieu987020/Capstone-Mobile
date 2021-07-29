import 'dart:io';

import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UserUpdateImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserUpdateImageInitialEvent extends UserUpdateImageEvent {}

class UserUpdateImageSubmit extends UserUpdateImageEvent {
  final User user;
  final File imageFile;
  UserUpdateImageSubmit(this.user, this.imageFile);
}
