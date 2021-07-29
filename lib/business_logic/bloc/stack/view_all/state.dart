import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class StackState extends Equatable {}

class StackFetchInitial extends StackState {
  @override
  List<Object> get props => [];
}

class StackLoading extends StackState {
  @override
  List<Object> get props => [];
}

class StackLoaded extends StackState {
  StackLoaded(this.stacks);

  final List<StackModel> stacks;
  @override
  List<Object> get props => [];
}

class StackError extends StackState {
  @override
  List<Object> get props => [];
}
