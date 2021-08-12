import 'package:equatable/equatable.dart';

class VideoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoFetchInitial extends VideoEvent {}

class VideoFetchEvent extends VideoEvent {
  final String dateStart;
  final String dateEnd;
  final int videoType;
  final String storeId;
  final String shelfId;
  final String productId;

  VideoFetchEvent({
    this.dateStart,
    this.dateEnd,
    this.videoType,
    this.storeId,
    this.shelfId,
    this.productId,
  });
}

class VideoFetchEventManager extends VideoEvent {
  final String dateStart;
  final String dateEnd;
  final int videoType;
  final String storeId;
  final String shelfId;
  final String productId;

  VideoFetchEventManager({
    this.dateStart,
    this.dateEnd,
    this.videoType,
    this.storeId,
    this.shelfId,
    this.productId,
  });
}
