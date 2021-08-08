import 'package:equatable/equatable.dart';

class ShelfUpdateInsideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShelfUpdateInsideInitialEvent extends ShelfUpdateInsideEvent {}

class ShelfMapCameraEvent extends ShelfUpdateInsideEvent {
  final String shelfId;
  final String cameraId;
  final int action;
  ShelfMapCameraEvent(this.shelfId, this.cameraId, this.action);
}

class ShelfChangeStatus extends ShelfUpdateInsideEvent {
  final String shelfId;
  final int statusId;
  final String reasonInactive;
  ShelfChangeStatus(this.shelfId, this.statusId, this.reasonInactive);
}
