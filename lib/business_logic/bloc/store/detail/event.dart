import 'package:equatable/equatable.dart';

abstract class StoreDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class StoreDetailInitialEvent extends StoreDetailEvent {}

class StoreDetailFetchEvent extends StoreDetailEvent {
  final String storeId;
  StoreDetailFetchEvent(this.storeId);
}
