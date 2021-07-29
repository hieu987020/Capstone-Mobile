import 'package:equatable/equatable.dart';

abstract class ProductCreateState extends Equatable {
  const ProductCreateState();

  @override
  List<Object> get props => [];
}

class ProductCreateInitial extends ProductCreateState {}

class ProductCreateLoading extends ProductCreateState {}

class ProductCreateLoaded extends ProductCreateState {}

class ProductCreateDuplicatedEmail extends ProductCreateState {
  final String message;
  ProductCreateDuplicatedEmail(this.message);
  @override
  List<Object> get props => [message];
}

class ProductCreateDuplicateIdentifyCard extends ProductCreateState {
  final String message;
  ProductCreateDuplicateIdentifyCard(this.message);
  @override
  List<Object> get props => [message];
}

class ProductCreateError extends ProductCreateState {
  final String message;
  ProductCreateError(this.message);
  @override
  List<Object> get props => [message];
}
