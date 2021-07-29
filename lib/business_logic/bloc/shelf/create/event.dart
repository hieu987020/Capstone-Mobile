import 'package:capstone/data/models/shelf.dart';
import 'package:equatable/equatable.dart';

abstract class ShelfCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShelfCreateInitialEvent extends ShelfCreateEvent {}

class ShelfCreateSubmitEvent extends ShelfCreateEvent {
  final Shelf shelf;
  ShelfCreateSubmitEvent(this.shelf);
  @override
  List<Object> get props => [];
}
