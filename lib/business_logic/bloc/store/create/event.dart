import 'dart:io';

import 'package:capstone/data/models/store.dart';
import 'package:equatable/equatable.dart';

abstract class StoreCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreCreateInitialEvent extends StoreCreateEvent {}

class StoreCreateSubmitEvent extends StoreCreateEvent {
  final Store store;
  final File imageFile;
  StoreCreateSubmitEvent(this.store, this.imageFile);
  @override
  List<Object> get props => [];
}
