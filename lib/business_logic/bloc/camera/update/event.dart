import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CameraUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class CameraUpdateInitialEvent extends CameraUpdateEvent {}

class CameraUpdateSubmit extends CameraUpdateEvent {
  final Camera camera;
  CameraUpdateSubmit(this.camera);
}
