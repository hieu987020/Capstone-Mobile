import 'dart:io';

import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class StoreUpdateImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreUpdateImageInitialEvent extends StoreUpdateImageEvent {}

class StoreUpdateImageSubmit extends StoreUpdateImageEvent {
  final Store store;
  final File imageFile;
  StoreUpdateImageSubmit(this.store, this.imageFile);
}
