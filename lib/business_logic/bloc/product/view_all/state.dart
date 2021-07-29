import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {}

class ProductFetchInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  ProductLoaded(this.products);

  final List<Product> products;
  @override
  List<Object> get props => [];
}

class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}
