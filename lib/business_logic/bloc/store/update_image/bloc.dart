import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/image_repository.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreUpdateImageBloc
    extends Bloc<StoreUpdateImageEvent, StoreUpdateImageState> {
  StoreUpdateImageBloc() : super(StoreUpdateImageInitial());

  final StoreRepository _storeRepository = new StoreRepository();
  final ImageRepository _imageRepository = new ImageRepository();

  @override
  Stream<StoreUpdateImageState> mapEventToState(
      StoreUpdateImageEvent event) async* {
    if (event is StoreUpdateImageInitialEvent) {
      yield StoreUpdateImageInitial();
    }
    if (event is StoreUpdateImageSubmit) {
      yield* _updateImage(event.store, event.imageFile);
    }
  }

  Stream<StoreUpdateImageState> _updateImage(
      Store store, File imageFile) async* {
    try {
      yield StoreUpdateImageLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        store = store.copyWith(
          storeName: store.storeName,
          imageUrl: imageResult,
          address: store.address,
          districtId: store.districtId,
        );
      }
      String result = await _storeRepository.updateStore(store);
      if (result == 'true') {
        yield StoreUpdateImageLoaded();
      } else {
        yield StoreUpdateImageError(result);
      }
    } catch (e) {
      yield StoreUpdateImageError("System can not finish this action");
    }
  }
}
