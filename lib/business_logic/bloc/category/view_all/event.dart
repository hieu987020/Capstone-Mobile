import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryFetchInitial extends CategoryEvent {}

class CategoryFetchEvent extends CategoryEvent {
  CategoryFetchEvent({
    this.searchValue,
    this.searchField,
    this.pageNum,
    this.fetchNext,
    this.statusId,
    this.categories,
  });
  final String searchValue;
  final String searchField;
  final int pageNum;
  final int fetchNext;
  final int statusId;
  final List<Category> categories;
}
