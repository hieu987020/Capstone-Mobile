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

class UserChangeToPending extends UserUpdateInsideEvent {
  final String userName;
  final int statusId;
  UserChangeToPending(this.userName, this.statusId);
}
