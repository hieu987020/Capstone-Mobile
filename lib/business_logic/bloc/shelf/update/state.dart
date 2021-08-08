import 'package:equatable/equatable.dart';

abstract class ShelfUpdateState extends Equatable {}

class ShelfUpdateInitial extends ShelfUpdateState {
  @override
  List<Object> get props => [];
}

class ShelfUpdateLoading extends ShelfUpdateState {
  @override
  List<Object> get props => [];
}

class ShelfUpdateError extends ShelfUpdateState {
  final String message;

  ShelfUpdateError(this.message);
  @override
  List<Object> get props => [];
}

class ShelfUpdateLoaded extends ShelfUpdateState {
  @override
  List<Object> get props => [];
}
