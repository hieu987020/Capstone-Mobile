import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class ProductDetailInitialEvent extends ProductDetailEvent {}

class ProductDetailFetchEvent extends ProductDetailEvent {
  final String productId;
  ProductDetailFetchEvent(this.productId);
}
