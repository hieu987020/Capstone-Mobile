import 'package:equatable/equatable.dart';

class CategoryUpdateInsideState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryUpdateInsideInitial extends CategoryUpdateInsideState {}

class CategoryUpdateInsideLoading extends CategoryUpdateInsideState {}

class CategoryUpdateInsideError extends CategoryUpdateInsideState {
  final String message;
  CategoryUpdateInsideError(this.message);
}

class CategoryUpdateInsideLoaded extends CategoryUpdateInsideState {}
