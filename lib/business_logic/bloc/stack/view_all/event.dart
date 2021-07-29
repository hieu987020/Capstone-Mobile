import 'package:equatable/equatable.dart';

class StackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StackFetchEvent extends StackEvent {
  final String shelfId;
  StackFetchEvent(this.shelfId);
}
