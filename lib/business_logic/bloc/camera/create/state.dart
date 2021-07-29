import 'package:equatable/equatable.dart';

abstract class CameraCreateState extends Equatable {
  const CameraCreateState();

  @override
  List<Object> get props => [];
}

class CameraCreateInitial extends CameraCreateState {}

class CameraCreateLoading extends CameraCreateState {}

class CameraCreateLoaded extends CameraCreateState {}

class CameraCreateDuplicatedIPAddress extends CameraCreateState {
  final String message;
  CameraCreateDuplicatedIPAddress(this.message);

  @override
  List<Object> get props => [message];
}

class CameraCreateDuplicatedRTSPString extends CameraCreateState {
  final String message;
  CameraCreateDuplicatedRTSPString(this.message);

  @override
  List<Object> get props => [message];
}

class CameraCreateError extends CameraCreateState {
  final String message;
  CameraCreateError(this.message);
  @override
  List<Object> get props => [message];
}
