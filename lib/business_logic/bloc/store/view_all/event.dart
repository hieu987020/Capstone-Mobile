import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class StoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreFetchInitial extends StoreEvent {}

class StoreFetchEvent extends StoreEvent {
  StoreFetchEvent({
    this.searchValue,
    this.searchField,
    this.pageNum,
    this.fetchNext,
    this.statusId,
    this.cityId,
    this.stores,
  });
  final String searchValue;
  final String searchField;
  final int pageNum;
  final int fetchNext;
  final int statusId;
  final int cityId;
  final List<Store> stores;
}

class StoreSearchEvent extends StoreEvent {
  final String storeName;
  StoreSearchEvent(this.storeName);
}

class StoreGetOperationEvent extends StoreEvent {}
