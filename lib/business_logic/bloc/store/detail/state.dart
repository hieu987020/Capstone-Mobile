import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class StoreDetailState extends Equatable {}

class StoreDetailFetchInitial extends StoreDetailState {
  @override
  List<Object> get props => [];
}

class StoreDetailLoading extends StoreDetailState {
  @override
  List<Object> get props => [];
}

class StoreDetailLoaded extends StoreDetailState {
  StoreDetailLoaded(this.store);

  final Store store;
  @override
  List<Object> get props => [];
}

class StoreDetailError extends StoreDetailState {
  @override
  List<Object> get props => [];
}
