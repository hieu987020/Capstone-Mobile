import 'package:equatable/equatable.dart';

class CategoryUpdateInsideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryUpdateInsideInitialEvent extends CategoryUpdateInsideEvent {}

class CategoryChangeStatus extends CategoryUpdateInsideEvent {
  final int cateId;
  final int statusId;
  CategoryChangeStatus(this.cateId, this.statusId);
}
