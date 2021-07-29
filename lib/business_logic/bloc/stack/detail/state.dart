import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class StackDetailState extends Equatable {}

class StackDetailFetchInitial extends StackDetailState {
  @override
  List<Object> get props => [];
}

class StackDetailLoading extends StackDetailState {
  @override
  List<Object> get props => [];
}

class StackDetailLoaded extends StackDetailState {
  StackDetailLoaded(this.stack);

  final StackModel stack;
  @override
  List<Object> get props => [stack];
}

class StackDetailError extends StackDetailState {
  @override
  List<Object> get props => [];
}
