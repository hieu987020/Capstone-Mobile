import 'package:equatable/equatable.dart';

class ProductUpdateInsideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductUpdateInsideInitialEvent extends ProductUpdateInsideEvent {}

class ProductChangeStatus extends ProductUpdateInsideEvent {
  final String productId;
  final int statusId;
  final String reasonInactive;
  ProductChangeStatus(this.productId, this.statusId, this.reasonInactive);
}
