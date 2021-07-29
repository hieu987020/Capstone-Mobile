import 'package:equatable/equatable.dart';

abstract class StackDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class StackDetailInitialEvent extends StackDetailEvent {}

class StackDetailFetchEvent extends StackDetailEvent {
  final String stackId;
  StackDetailFetchEvent(this.stackId);
}
