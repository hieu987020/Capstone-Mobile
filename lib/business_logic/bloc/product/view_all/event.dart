import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductFetchInitial extends ProductEvent {}

class ProductFetchEvent extends ProductEvent {
  ProductFetchEvent({
    this.searchValue,
    this.searchField,
    this.pageNum,
    this.fetchNext,
    this.categoryId,
    this.statusId,
    this.products,
  });
  final String searchValue;
  final String searchField;
  final int pageNum;
  final int fetchNext;
  final int categoryId;
  final int statusId;
  final List<Product> products;
}

class ProductSearchEvent extends ProductEvent {
  final String productName;
  ProductSearchEvent(this.productName);
}

class ProductAllEvent extends ProductEvent {}
