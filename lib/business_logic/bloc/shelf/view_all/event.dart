import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class ShelfEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShelfFetchInitalEvent extends ShelfEvent {
  ShelfFetchInitalEvent();
}

class ShelfFetchEvent extends ShelfEvent {
  ShelfFetchEvent({
    this.storeId,
    this.shelfName,
    this.statusId,
    this.pageNum,
    this.fetchNext,
    this.shelves,
  });
  final String storeId;
  final String shelfName;
  final int statusId;
  final int pageNum;
  final int fetchNext;
  final List<Shelf> shelves;
}

class ShelfSearchEvent extends ShelfEvent {
  final String shelfName;
  ShelfSearchEvent(this.shelfName);
}

class FetchShelfByStoreIdEvent extends ShelfEvent {
  final String storeId;
  FetchShelfByStoreIdEvent(this.storeId);
}
