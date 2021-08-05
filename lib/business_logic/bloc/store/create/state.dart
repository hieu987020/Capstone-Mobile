import 'package:equatable/equatable.dart';

abstract class StoreCreateState extends Equatable {
  const StoreCreateState();

  @override
  List<Object> get props => [];
}

class StoreCreateInitial extends StoreCreateState {}

class StoreCreateLoading extends StoreCreateState {}

class StoreCreateLoaded extends StoreCreateState {}

class StoreDuplicatedName extends StoreCreateState {
  final String message;
  StoreDuplicatedName(this.message);
  @override
  List<Object> get props => [message];
}

class StoreCreateError extends StoreCreateState {
  final String message;
  StoreCreateError(this.message);
  @override
  List<Object> get props => [message];
}
