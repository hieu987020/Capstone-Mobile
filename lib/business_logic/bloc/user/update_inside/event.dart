import 'package:equatable/equatable.dart';

class UserUpdateInsideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserUpdateInsideInitialEvent extends UserUpdateInsideEvent {}

class UserMapStoreEvent extends UserUpdateInsideEvent {
  final String storeId;
  final String managerId;
  final int active;
  UserMapStoreEvent(this.storeId, this.managerId, this.active);
}

class UserChangeStatus extends UserUpdateInsideEvent {
  final String userName;
  final int statusId;
  final String reasonInactive;
  UserChangeStatus(this.userName, this.statusId, this.reasonInactive);
}
