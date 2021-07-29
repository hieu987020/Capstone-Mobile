import 'package:equatable/equatable.dart';

class ShelfUpdateInsideState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShelfUpdateInsideInitial extends ShelfUpdateInsideState {}

class ShelfUpdateInsideLoading extends ShelfUpdateInsideState {}

class ShelfUpdateInsideError extends ShelfUpdateInsideState {
  final String message;

  ShelfUpdateInsideError(this.message);
}

class ShelfUpdateInsideLoaded extends ShelfUpdateInsideState {}
