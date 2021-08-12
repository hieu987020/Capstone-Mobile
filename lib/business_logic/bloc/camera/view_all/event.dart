import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class CameraEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraFetchInitial extends CameraEvent {}

class CameraFetchEvent extends CameraEvent {
  CameraFetchEvent({
    this.storeId,
    this.cameraName,
    this.statusId,
    this.pageNum,
    this.fetchNext,
    this.cameras,
  });
  final String storeId;
  final String cameraName;
  final int statusId;
  final int pageNum;
  final int fetchNext;
  final List<Camera> cameras;
}

class CameraAvailableEvent extends CameraEvent {
  CameraAvailableEvent({
    this.cameraName,
    this.pageNum,
    this.fetchNext,
    this.typeId,
    this.cameras,
  });
  final String cameraName;
  final int pageNum;
  final int fetchNext;
  final int typeId;
  final List<Camera> cameras;
}
