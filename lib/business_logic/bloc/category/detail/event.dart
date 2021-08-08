import 'package:equatable/equatable.dart';

abstract class CategoryDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class CategoryDetailInitialEvent extends CategoryDetailEvent {}

class CategoryDetailFetchEvent extends CategoryDetailEvent {
  final int categoryId;
  CategoryDetailFetchEvent(this.categoryId);
}
