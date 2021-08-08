import 'package:equatable/equatable.dart';

class ShelfEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShelfFetchInitalEvent extends ShelfEvent {
  ShelfFetchInitalEvent();
}

class ShelfFetchEvent extends ShelfEvent {
  final int statusId;
  ShelfFetchEvent(this.statusId);
}

class ShelfSearchEvent extends ShelfEvent {
  final String shelfName;
  ShelfSearchEvent(this.shelfName);
}

class FetchShelfByStoreIdEvent extends ShelfEvent {
  final String storeId;
  FetchShelfByStoreIdEvent(this.storeId);
}
