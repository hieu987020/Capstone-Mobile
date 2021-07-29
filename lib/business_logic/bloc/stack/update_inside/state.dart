import 'package:equatable/equatable.dart';

class StackUpdateInsideState extends Equatable {
  @override
  List<Object> get props => [];
}

class StackUpdateInsideInitial extends StackUpdateInsideState {}

class StackUpdateInsideLoading extends StackUpdateInsideState {}

class StackUpdateInsideError extends StackUpdateInsideState {
  final String message;

  StackUpdateInsideError(this.message);
}

class StackUpdateInsideLoaded extends StackUpdateInsideState {}
