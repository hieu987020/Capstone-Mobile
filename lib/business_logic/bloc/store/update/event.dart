import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class StoreUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return super.toString();
  }
}

class StoreUpdateShowForm extends StoreUpdateEvent {}

class StoreUpdateSubmit extends StoreUpdateEvent {
  final Store store;
  StoreUpdateSubmit(this.store);
}
