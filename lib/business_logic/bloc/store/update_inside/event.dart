import 'package:equatable/equatable.dart';

class StoreUpdateInsideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreUpdateInsideInitialEvent extends StoreUpdateInsideEvent {}

class StoreMapManagerEvent extends StoreUpdateInsideEvent {
  final String storeId;
  final String managerId;
  final int active;
  StoreMapManagerEvent(this.storeId, this.managerId, this.active);
}

class StoreChangeStatus extends StoreUpdateInsideEvent {
  final String userName;
  final int statusId;
  final String reasonInactive;
  StoreChangeStatus(this.userName, this.statusId, this.reasonInactive);
}
