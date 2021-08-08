import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryCreateInitialEvent extends CategoryCreateEvent {}

class CategoryCreateSubmitEvent extends CategoryCreateEvent {
  final Category category;
  CategoryCreateSubmitEvent(this.category);
  @override
  List<Object> get props => [];
}
