import 'dart:io';

import 'package:capstone/data/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductCreateInitialEvent extends ProductCreateEvent {}

class ProductCreateSubmitEvent extends ProductCreateEvent {
  final Product product;
  final File imageFile;
  ProductCreateSubmitEvent(this.product, this.imageFile);
  @override
  List<Object> get props => [];
}
