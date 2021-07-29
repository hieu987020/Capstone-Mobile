import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CameraDetailState extends Equatable {}

class CameraDetailFetchInitial extends CameraDetailState {
  @override
  List<Object> get props => [];
}

class CameraDetailLoading extends CameraDetailState {
  @override
  List<Object> get props => [];
}

class CameraDetailLoaded extends CameraDetailState {
  CameraDetailLoaded(this.camera);

  final Camera camera;
  @override
  List<Object> get props => [];
}

class CameraDetailError extends CameraDetailState {
  @override
  List<Object> get props => [];
}
