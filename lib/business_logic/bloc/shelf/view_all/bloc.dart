import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShelfBloc extends Bloc<ShelfEvent, ShelfState> {
  ShelfBloc() : super(ShelfFetchInitial());
  final ShelfRepository shelfRepository = new ShelfRepository();

  @override
  Stream<ShelfState> mapEventToState(ShelfEvent event) async* {
    if (event is ShelfFetchInitalEvent) {
      yield ShelfFetchInitial();
    } else if (event is ShelfFetchEvent) {
      yield* _getShelves(event.storeId, event.shelfName, event.statusId,
          event.pageNum, event.fetchNext);
    } else if (event is FetchShelfByStoreIdEvent) {
      yield* _getShelvesByAdmin(event.storeId);
    }
  }

  Stream<ShelfState> _getShelves(String storeId, String shelfName, int statusId,
      int pageNum, int fetchNext) async* {
    try {
      yield ShelfLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      storeId = prefs.getString('storeId');
      final shelves = await shelfRepository.getShelves(
        storeId,
        shelfName,
        statusId,
        pageNum,
        fetchNext,
      );
      yield ShelfLoaded(shelves);
    } catch (e) {
      yield ShelfError();
    }
  }

  Stream<ShelfState> _getShelvesByAdmin(String storeId) async* {
    try {
      yield ShelfLoading();
      final shelves = await shelfRepository.getShelvesByStoreId(storeId);
      yield ShelfLoaded(shelves);
    } catch (e) {
      yield ShelfError();
    }
  }
}
