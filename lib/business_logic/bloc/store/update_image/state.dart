import 'package:equatable/equatable.dart';

abstract class StoreUpdateImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class StoreUpdateImageInitial extends StoreUpdateImageState {}

class StoreUpdateImageError extends StoreUpdateImageState {
  final String message;

  StoreUpdateImageError(this.message);
}

class StoreUpdateImageLoaded extends StoreUpdateImageState {}

class StoreUpdateImageLoading extends StoreUpdateImageState {}
