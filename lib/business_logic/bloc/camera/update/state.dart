import 'package:equatable/equatable.dart';

abstract class CameraUpdateState extends Equatable {}

class CameraUpdateInitial extends CameraUpdateState {
  @override
  List<Object> get props => [];
}

class CameraUpdateLoading extends CameraUpdateState {
  @override
  List<Object> get props => [];
}

class CameraUpdateDuplicatedIPAddress extends CameraUpdateState {
  final String message;
  CameraUpdateDuplicatedIPAddress(this.message);

  @override
  List<Object> get props => [message];
}

class CameraUpdateDuplicatedRTSPString extends CameraUpdateState {
  final String message;
  CameraUpdateDuplicatedRTSPString(this.message);

  @override
  List<Object> get props => [message];
}

class CameraUpdateError extends CameraUpdateState {
  final String message;

  CameraUpdateError(this.message);
  @override
  List<Object> get props => [];
}

class CameraUpdateLoaded extends CameraUpdateState {
  @override
  List<Object> get props => [];
}
