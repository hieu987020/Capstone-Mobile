import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ProductUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class ProductUpdateShowForm extends ProductUpdateEvent {}

class ProductUpdateSubmit extends ProductUpdateEvent {
  final Product product;
  ProductUpdateSubmit(this.product);
}
