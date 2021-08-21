import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShelfDetailBloc extends Bloc<ShelfDetailEvent, ShelfDetailState> {
  ShelfDetailBloc() : super(ShelfDetailFetchInitial());
  final ShelfRepository _shelfRepository = new ShelfRepository();
  @override
  Stream<ShelfDetailState> mapEventToState(ShelfDetailEvent event) async* {
    if (event is ShelfDetailInitialEvent) {
      yield ShelfDetailFetchInitial();
    }
    if (event is ShelfDetailFetchEvent) {
      yield* _getShelfsDetail(event.shelfId);
    }
  }

  Stream<ShelfDetailState> _getShelfsDetail(String shelfId) async* {
    try {
      yield ShelfDetailLoading();
      final shelf = await _shelfRepository.getShelf(shelfId);
      yield ShelfDetailLoaded(shelf);
    } catch (e) {
      yield ShelfDetailError();
    }
  }
}
