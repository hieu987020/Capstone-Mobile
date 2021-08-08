import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryDetailState extends Equatable {}

class CategoryDetailFetchInitial extends CategoryDetailState {
  @override
  List<Object> get props => [];
}

class CategoryDetailLoading extends CategoryDetailState {
  @override
  List<Object> get props => [];
}

class CategoryDetailLoaded extends CategoryDetailState {
  CategoryDetailLoaded(this.category, this.products);

  final Category category;
  final List<Product> products;
  @override
  List<Object> get props => [];
}

class CategoryDetailError extends CategoryDetailState {
  @override
  List<Object> get props => [];
}
