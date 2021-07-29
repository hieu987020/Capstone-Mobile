import 'package:equatable/equatable.dart';

abstract class ProductUpdateState extends Equatable {}

class ProductUpdateInitial extends ProductUpdateState {
  @override
  List<Object> get props => [];
}

class ProductUpdateLoading extends ProductUpdateState {
  @override
  List<Object> get props => [];
}

class ProductUpdateError extends ProductUpdateState {
  final String message;

  ProductUpdateError(this.message);
  @override
  List<Object> get props => [];
}

class ProductUpdateLoaded extends ProductUpdateState {
  @override
  List<Object> get props => [];
}
