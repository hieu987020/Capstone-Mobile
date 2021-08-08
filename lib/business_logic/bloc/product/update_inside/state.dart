import 'package:equatable/equatable.dart';

class ProductUpdateInsideState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductUpdateInsideInitial extends ProductUpdateInsideState {}

class ProductUpdateInsideLoading extends ProductUpdateInsideState {}

class ProductUpdateInsideError extends ProductUpdateInsideState {
  final String message;
  ProductUpdateInsideError(this.message);
}

class ProductUpdateInsideLoaded extends ProductUpdateInsideState {}
