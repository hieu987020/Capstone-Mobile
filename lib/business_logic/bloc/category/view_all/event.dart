import 'package:equatable/equatable.dart';

class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryFetchEvent extends CategoryEvent {
  final int statusId;
  CategoryFetchEvent(this.statusId);
}
