import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreFetchInitial());
  final StoreRepository storeRepository = new StoreRepository();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is StoreFetchInitial) {
      _getStores(StatusIntBase.All);
    } else if (event is StoreFetchEvent) {
      yield* _getStores(event.statusId);
    } else if (event is StoreSearchEvent) {
      yield* _searchStores(event.storeName);
    }
  }

  Stream<StoreState> _getStores(int statusId) async* {
    try {
      yield StoreLoading();

      final stores = await storeRepository.getStores(
          SearchValueBase.Default,
          SearchFieldBase.Default,
          PageNumBase.Default,
          FetchNextBase.Default,
          statusId);

      yield StoreLoaded(stores);
    } catch (e) {
      yield StoreError();
    }
  }

  Stream<StoreState> _searchStores(String storeName) async* {
    try {
      yield StoreLoading();
      final stores = await storeRepository.getStoresByStoreName(storeName);
      yield StoreLoaded(stores);
    } catch (e) {
      yield StoreError();
    }
  }
}
