import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitialState());
  final StoreRepository storeRepository = new StoreRepository();

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is VideoInitialState) {
      yield VideoInitialState();
    } else if (event is VideoFetchEvent) {
      yield* _getVideos(event.dateStart, event.dateEnd, event.videoType,
          event.storeId, event.shelfId, event.productId);
    } else if (event is VideoFetchEventManager) {
      yield* _getVideosManager(event.dateStart, event.dateEnd, event.videoType,
          event.storeId, event.shelfId, event.productId);
    }
  }

  Stream<VideoState> _getVideos(String dateStart, String dateEnd, int videoType,
      String storeId, String shelfId, String productId) async* {
    try {
      if (videoType == 1) {
        yield VideoCountingLoading();
      } else {
        yield VideoEmotionLoading();
      }

      var stores = await storeRepository.getVideos(
          dateStart, dateEnd, videoType, storeId, shelfId, productId);

      if (videoType == 1) {
        yield VideoCountingLoaded(stores);
      } else {
        yield VideoEmotionLoaded(stores);
      }
    } catch (e) {
      yield VideoError();
    }
  }

  Stream<VideoState> _getVideosManager(String dateStart, String dateEnd,
      int videoType, String storeId, String shelfId, String productId) async* {
    try {
      if (videoType == 1) {
        yield VideoCountingLoading();
      } else {
        yield VideoEmotionLoading();
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String storeIdManager = prefs.getString('storeId');
      var stores = await storeRepository.getVideos(
          dateStart, dateEnd, videoType, storeIdManager, shelfId, productId);

      if (videoType == 1) {
        yield VideoCountingLoaded(stores);
      } else {
        yield VideoEmotionLoaded(stores);
      }
    } catch (e) {
      yield VideoError();
    }
  }
}
