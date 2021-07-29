import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailState extends Equatable {}

class ProductDetailFetchInitial extends ProductDetailState {
  @override
  List<Object> get props => [];
}

class ProductDetailLoading extends ProductDetailState {
  @override
  List<Object> get props => [];
}

class ProductDetailLoaded extends ProductDetailState {
  ProductDetailLoaded(this.product);

  final Product product;
  @override
  List<Object> get props => [];
}

class ProductDetailError extends ProductDetailState {
  @override
  List<Object> get props => [];
}
