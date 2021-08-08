import 'package:equatable/equatable.dart';

abstract class CategoryUpdateState extends Equatable {}

class CategoryUpdateInitial extends CategoryUpdateState {
  @override
  List<Object> get props => [];
}

class CategoryUpdateLoading extends CategoryUpdateState {
  @override
  List<Object> get props => [];
}

class CategoryUpdateDuplicatedName extends CategoryUpdateState {
  final String message;
  CategoryUpdateDuplicatedName(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryUpdateError extends CategoryUpdateState {
  final String message;

  CategoryUpdateError(this.message);
  @override
  List<Object> get props => [];
}

class CategoryUpdateLoaded extends CategoryUpdateState {
  @override
  List<Object> get props => [];
}
