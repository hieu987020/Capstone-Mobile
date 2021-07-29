import 'dart:io';

import 'package:capstone/data/models/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraCreateInitialEvent extends CameraCreateEvent {}

class CameraCreateSubmitEvent extends CameraCreateEvent {
  final Camera camera;
  final File imageFile;
  CameraCreateSubmitEvent(this.camera, this.imageFile);
  @override
  List<Object> get props => [];
}
