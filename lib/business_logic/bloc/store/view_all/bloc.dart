import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitialState());
  final StoreRepository storeRepository = new StoreRepository();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is StoreFetchInitial) {
      yield StoreInitialState();
    } else if (event is StoreFetchEvent) {
      yield* _getStores(event.searchValue, event.searchField, event.pageNum,
          event.fetchNext, event.statusId, event.cityId, event.stores);
    } else if (event is StoreGetOperationEvent) {
      yield* _getOperationStores();
    }
  }

  Stream<StoreState> _getStores(
    String searchValue,
    String searchField,
    int pageNum,
    int fetchNext,
    int statusId,
    int cityId,
    List<Store> stores,
  ) async* {
    try {
      yield StoreLoading();

      final stores = await storeRepository.getStores(
          searchValue, searchField, pageNum, fetchNext, statusId, cityId);

      yield StoreLoaded(stores);
    } catch (e) {
      yield StoreError();
    }
  }

  Stream<StoreState> _getOperationStores() async* {
    try {
      yield StoreLoading();
      final stores = await storeRepository.getOperationStores();
      yield StoreLoaded(stores);
    } catch (e) {
      yield StoreError();
    }
  }
}
