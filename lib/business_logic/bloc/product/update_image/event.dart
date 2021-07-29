import 'dart:io';

import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ProductUpdateImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductUpdateImageInitialEvent extends ProductUpdateImageEvent {}

class ProductUpdateImageSubmit extends ProductUpdateImageEvent {
  final Product product;
  final File imageFile;
  ProductUpdateImageSubmit(this.product, this.imageFile);
}
