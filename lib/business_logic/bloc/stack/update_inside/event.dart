import 'package:equatable/equatable.dart';

class StackUpdateInsideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StackUpdateInsideInitialEvent extends StackUpdateInsideEvent {}

class StackMapProductEvent extends StackUpdateInsideEvent {
  final String stackId;
  final String productId;
  final int action;
  StackMapProductEvent(this.stackId, this.productId, this.action);
}

class StackMapCameraEvent extends StackUpdateInsideEvent {
  final String stackId;
  final String cameraId;
  final int action;
  StackMapCameraEvent(this.stackId, this.cameraId, this.action);
}
