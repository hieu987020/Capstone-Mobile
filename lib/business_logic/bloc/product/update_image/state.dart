import 'package:equatable/equatable.dart';

abstract class ProductUpdateImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductUpdateImageInitial extends ProductUpdateImageState {}

class ProductUpdateImageError extends ProductUpdateImageState {
  final String message;

  ProductUpdateImageError(this.message);
}

class ProductUpdateImageLoaded extends ProductUpdateImageState {}

class ProductUpdateImageLoading extends ProductUpdateImageState {}
