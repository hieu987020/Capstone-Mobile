import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class VideoState extends Equatable {}

class VideoInitialState extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoCountingLoading extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoEmotionLoading extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoCountingLoaded extends VideoState {
  VideoCountingLoaded(this.stores);

  final List<Store> stores;
  @override
  List<Object> get props => [];
}

class VideoEmotionLoaded extends VideoState {
  VideoEmotionLoaded(this.stores);

  final List<Store> stores;
  @override
  List<Object> get props => [];
}

class VideoError extends VideoState {
  @override
  List<Object> get props => [];
}
