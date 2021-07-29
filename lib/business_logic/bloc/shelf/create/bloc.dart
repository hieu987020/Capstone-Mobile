import 'dart:async';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShelfCreateBloc extends Bloc<ShelfCreateEvent, ShelfCreateState> {
  ShelfCreateBloc() : super(ShelfCreateInitial());
  final ShelfRepository _shelfsRepository = new ShelfRepository();
  @override
  Stream<ShelfCreateState> mapEventToState(ShelfCreateEvent event) async* {
    if (event is ShelfCreateInitialEvent) {
      yield ShelfCreateInitial();
    }
    if (event is ShelfCreateSubmitEvent) {
      yield* _createShelf(event.shelf);
    }
  }

  Stream<ShelfCreateState> _createShelf(Shelf shelf) async* {
    try {
      yield ShelfCreateLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String storeId = prefs.getString('storeId');
      String result = await _shelfsRepository.postShelf(shelf, storeId);

      if (result == 'true') {
        yield ShelfCreateLoaded();
      } else if (result.contains("MSG-061")) {
        yield ShelfCreateDuplicatedName("RTSP String is existed");
      } else if (result.contains('errorCodeAndMsg')) {
        yield ShelfCreateError(result);
      }
    } catch (e) {
      print("error trong create shelf");
      print(e.toString());
      yield ShelfCreateError(e.toString());
    }
  }
}
