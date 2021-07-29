import 'package:equatable/equatable.dart';

abstract class StoreUpdateState extends Equatable {}

class StoreUpdateInitial extends StoreUpdateState {
  @override
  List<Object> get props => [];
}

class StoreUpdateLoading extends StoreUpdateState {
  @override
  List<Object> get props => [];
}

class StoreUpdateError extends StoreUpdateState {
  final String message;

  StoreUpdateError(this.message);
  @override
  List<Object> get props => [];
}

class StoreUpdateLoaded extends StoreUpdateState {
  @override
  List<Object> get props => [];
}
