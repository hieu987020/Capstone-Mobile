import 'package:equatable/equatable.dart';

class StoreInactiveState extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreInactiveInitial extends StoreInactiveState {}

class StoreInactiveLoading extends StoreInactiveState {}

class StoreInactiveError extends StoreInactiveState {
  final String message;
  StoreInactiveError(this.message);
}

class StoreInactiveLoaded extends StoreInactiveState {}
