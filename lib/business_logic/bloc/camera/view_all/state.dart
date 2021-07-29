import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {}

class CameraFetchInitial extends CameraState {
  @override
  List<Object> get props => [];
}

class CameraLoading extends CameraState {
  @override
  List<Object> get props => [];
}

class CameraLoaded extends CameraState {
  CameraLoaded(this.cameras);

  final List<Camera> cameras;
  @override
  List<Object> get props => [];
}

class CameraError extends CameraState {
  @override
  List<Object> get props => [];
}
