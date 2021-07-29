import 'package:equatable/equatable.dart';

class ShelfEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShelfFetchEvent extends ShelfEvent {
  final int statusId;
  ShelfFetchEvent(this.statusId);
}

class ShelfSearchEvent extends ShelfEvent {
  final String shelfName;
  ShelfSearchEvent(this.shelfName);
}
