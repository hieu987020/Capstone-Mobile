import 'package:equatable/equatable.dart';

class CameraEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraFetchEvent extends CameraEvent {
  final int statusId;
  CameraFetchEvent(this.statusId);
}

class CameraSearchEvent extends CameraEvent {
  final String cameraName;
  CameraSearchEvent(this.cameraName);
}
