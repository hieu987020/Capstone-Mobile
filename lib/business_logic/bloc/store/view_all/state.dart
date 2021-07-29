import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {}

class StoreFetchInitial extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreLoading extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreLoaded extends StoreState {
  StoreLoaded(this.stores);

  final List<Store> stores;
  @override
  List<Object> get props => [];
}

class StoreError extends StoreState {
  @override
  List<Object> get props => [];
}
