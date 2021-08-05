import 'package:equatable/equatable.dart';

class StoreUpdateInsideState extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreUpdateInsideInitial extends StoreUpdateInsideState {}

class StoreUpdateInsideLoading extends StoreUpdateInsideState {}

class StoreUpdateInsideError extends StoreUpdateInsideState {
  final String message;
  StoreUpdateInsideError(this.message);
}

class StoreUpdateInsideLoaded extends StoreUpdateInsideState {}
