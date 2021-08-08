import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ShelfUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class ShelfUpdateShowForm extends ShelfUpdateEvent {}

class ShelfUpdateSubmit extends ShelfUpdateEvent {
  final Shelf shelf;
  ShelfUpdateSubmit(this.shelf);
}
