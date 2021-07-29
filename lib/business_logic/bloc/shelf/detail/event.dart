import 'package:equatable/equatable.dart';

abstract class ShelfDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class ShelfDetailInitialEvent extends ShelfDetailEvent {}

class ShelfDetailFetchEvent extends ShelfDetailEvent {
  final String shelfId;
  ShelfDetailFetchEvent(this.shelfId);
}
