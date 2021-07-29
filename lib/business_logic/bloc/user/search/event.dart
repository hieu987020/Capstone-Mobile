import 'package:equatable/equatable.dart';

class UserSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserEnterSearchEvent extends UserSearchEvent {
  final String userName;
  UserEnterSearchEvent(this.userName);
}
