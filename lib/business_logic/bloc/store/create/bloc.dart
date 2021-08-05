import 'dart:async';
import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreCreateBloc extends Bloc<StoreCreateEvent, StoreCreateState> {
  StoreCreateBloc() : super(StoreCreateInitial());
  final StoreRepository _storesRepository = new StoreRepository();
  final ImageRepository _imageRepository = new ImageRepository();
  @override
  Stream<StoreCreateState> mapEventToState(StoreCreateEvent event) async* {
    if (event is StoreCreateInitialEvent) {
      yield StoreCreateInitial();
    }
    if (event is StoreCreateSubmitEvent) {
      yield* _createStore(event.store, event.imageFile);
    }
  }

  Stream<StoreCreateState> _createStore(Store store, File imageFile) async* {
    try {
      yield StoreCreateLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        store = store.copyWith(
          storeName: store.storeName,
          imageUrl: imageResult,
          address: store.address,
          districtId: store.districtId,
        );
      }
      String result = await _storesRepository.postStore(store);

      if (result == 'true') {
        yield StoreCreateLoaded();
      } else if (result.contains('MSG-062')) {
        yield StoreDuplicatedName('Store Name is existed !');
      } else if (result.contains('MSG-076')) {
        yield StoreCreateError('System can not finish this action');
      } else if (result.contains('errorCodeAndMsg')) {
        yield StoreCreateError(result);
      }
    } catch (e) {
      yield StoreCreateError(e.toString());
    }
  }
}
