import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShelfBloc extends Bloc<ShelfEvent, ShelfState> {
  ShelfBloc() : super(ShelfFetchInitial());
  final ShelfRepository shelfRepository = new ShelfRepository();

  @override
  Stream<ShelfState> mapEventToState(ShelfEvent event) async* {
    if (event is ShelfFetchInitial) {
      yield* _getShelves(StatusIntBase.All);
    } else if (event is ShelfFetchEvent) {
      yield* _getShelves(event.statusId);
    }
    // else if (event is ShelfSearchEvent) {
    //   yield* _searchShelfs(event.storeName);
    // }
  }

  Stream<ShelfState> _getShelves(int statusId) async* {
    try {
      yield ShelfLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String storeId = prefs.getString('storeId');
      final shelves = await shelfRepository.getShelves(
        storeId,
        "",
        statusId,
        PageNumBase.Default,
        FetchNextBase.Default,
      );
      yield ShelfLoaded(shelves);
    } catch (e) {
      print("exception\n");
      print(e.toString());
      yield ShelfError();
    }
  }

  // Stream<ShelfState> _searchShelfs(String storeName) async* {
  //   try {
  //     yield ShelfLoading();
  //     final stores = await storeRepository.getShelfsByShelfName(storeName);
  //     yield ShelfLoaded(stores);
  //   } catch (e) {
  //     yield ShelfError();
  //   }
  // }
}
