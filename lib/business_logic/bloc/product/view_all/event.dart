import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductFetchEvent extends ProductEvent {
  final int statusId;
  ProductFetchEvent(this.statusId);
}

class ProductSearchEvent extends ProductEvent {
  final String productName;
  ProductSearchEvent(this.productName);
}

class ProductAllEvent extends ProductEvent {}
