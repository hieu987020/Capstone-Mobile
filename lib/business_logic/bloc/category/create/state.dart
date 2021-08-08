import 'package:equatable/equatable.dart';

abstract class CategoryCreateState extends Equatable {
  const CategoryCreateState();

  @override
  List<Object> get props => [];
}

class CategoryCreateInitial extends CategoryCreateState {}

class CategoryCreateLoading extends CategoryCreateState {}

class CategoryCreateLoaded extends CategoryCreateState {}

class CategoryCreateDuplicatedName extends CategoryCreateState {
  final String message;
  CategoryCreateDuplicatedName(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryCreateError extends CategoryCreateState {
  final String message;
  CategoryCreateError(this.message);
  @override
  List<Object> get props => [message];
}
