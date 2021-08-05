import 'package:equatable/equatable.dart';

class CameraUpdateInsideState extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraUpdateInsideInitial extends CameraUpdateInsideState {}

class CameraUpdateInsideLoading extends CameraUpdateInsideState {}

class CameraUpdateInsideError extends CameraUpdateInsideState {
  final String message;
  CameraUpdateInsideError(this.message);
}

class CameraUpdateInsideLoaded extends CameraUpdateInsideState {}
