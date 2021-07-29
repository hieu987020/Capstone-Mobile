import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ShelfState extends Equatable {}

class ShelfFetchInitial extends ShelfState {
  @override
  List<Object> get props => [];
}

class ShelfLoading extends ShelfState {
  @override
  List<Object> get props => [];
}

class ShelfLoaded extends ShelfState {
  ShelfLoaded(this.shelves);

  final List<Shelf> shelves;
  @override
  List<Object> get props => [];
}

class ShelfError extends ShelfState {
  @override
  List<Object> get props => [];
}
