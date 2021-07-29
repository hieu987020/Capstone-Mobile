import 'package:equatable/equatable.dart';

abstract class ShelfCreateState extends Equatable {
  const ShelfCreateState();

  @override
  List<Object> get props => [];
}

class ShelfCreateInitial extends ShelfCreateState {}

class ShelfCreateLoading extends ShelfCreateState {}

class ShelfCreateLoaded extends ShelfCreateState {}

class ShelfCreateDuplicatedName extends ShelfCreateState {
  final String message;
  ShelfCreateDuplicatedName(this.message);

  @override
  List<Object> get props => [message];
}

class ShelfCreateError extends ShelfCreateState {
  final String message;
  ShelfCreateError(this.message);
  @override
  List<Object> get props => [message];
}
