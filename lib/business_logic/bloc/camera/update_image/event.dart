import 'dart:io';

import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CameraUpdateImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraUpdateImageInitialEvent extends CameraUpdateImageEvent {}

class CameraUpdateImageSubmit extends CameraUpdateImageEvent {
  final Camera camera;
  final File imageFile;
  CameraUpdateImageSubmit(this.camera, this.imageFile);
}
