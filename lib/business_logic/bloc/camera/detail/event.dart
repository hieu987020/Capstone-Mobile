import 'package:equatable/equatable.dart';

abstract class CameraDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class CameraDetailInitialEvent extends CameraDetailEvent {}

class CameraDetailFetchEvent extends CameraDetailEvent {
  final String cameraId;
  CameraDetailFetchEvent(this.cameraId);
}
