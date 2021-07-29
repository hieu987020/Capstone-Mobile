import 'package:equatable/equatable.dart';

abstract class CameraUpdateImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraUpdateImageInitial extends CameraUpdateImageState {}

class CameraUpdateImageError extends CameraUpdateImageState {
  final String message;

  CameraUpdateImageError(this.message);
}

class CameraUpdateImageLoaded extends CameraUpdateImageState {}

class CameraUpdateImageLoading extends CameraUpdateImageState {}
