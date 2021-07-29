import 'package:equatable/equatable.dart';

class StoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreFetchEvent extends StoreEvent {
  final int statusId;
  StoreFetchEvent(this.statusId);
}

class StoreSearchEvent extends StoreEvent {
  final String storeName;
  StoreSearchEvent(this.storeName);
}
