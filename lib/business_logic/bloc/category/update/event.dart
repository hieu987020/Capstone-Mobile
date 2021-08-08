import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class CategoryUpdateInitialEvent extends CategoryUpdateEvent {}

class CategoryUpdateSubmit extends CategoryUpdateEvent {
  final Category cate;
  CategoryUpdateSubmit(this.cate);
}
