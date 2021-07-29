import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ShelfDetailState extends Equatable {}

class ShelfDetailFetchInitial extends ShelfDetailState {
  @override
  List<Object> get props => [];
}

class ShelfDetailLoading extends ShelfDetailState {
  @override
  List<Object> get props => [];
}

class ShelfDetailLoaded extends ShelfDetailState {
  ShelfDetailLoaded(this.shelf);

  final Shelf shelf;
  @override
  List<Object> get props => [];
}

class ShelfDetailError extends ShelfDetailState {
  @override
  List<Object> get props => [];
}
