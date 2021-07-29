import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserFetchEvent extends UserEvent {
  final int statusId;
  UserFetchEvent(this.statusId);
}
