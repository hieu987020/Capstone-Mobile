import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserFetchEvent extends UserEvent {
  UserFetchEvent({
    this.searchValue,
    this.searchField,
    this.pageNum,
    this.fetchNext,
    this.statusId,
    this.users,
  });

  final String searchValue;
  final String searchField;
  final int pageNum;
  final int fetchNext;
  final int statusId;
  final List<User> users;
}
