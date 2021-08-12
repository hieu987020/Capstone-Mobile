import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitialState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  CategoryLoaded(this.categories);

  final List<Category> categories;
  @override
  List<Object> get props => [];
}

class CategoryError extends CategoryState {
  @override
  List<Object> get props => [];
}
