import 'package:equatable/equatable.dart';

class StoreInactiveEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreInactiveInitialEvent extends StoreInactiveEvent {}

class StoreChangeToInactive extends StoreInactiveEvent {
  final String storeId;
  final String reasonInactive;
  StoreChangeToInactive(this.storeId, this.reasonInactive);
}
