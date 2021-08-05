import 'package:equatable/equatable.dart';

class CameraUpdateInsideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraUpdateInsideInitialEvent extends CameraUpdateInsideEvent {}

class CameraChangeStatus extends CameraUpdateInsideEvent {
  final String cameraId;
  final int statusId;
  final String reasonInactive;
  CameraChangeStatus(this.cameraId, this.statusId, this.reasonInactive);
}
