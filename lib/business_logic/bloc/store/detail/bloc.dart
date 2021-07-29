import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/store_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreDetailBloc extends Bloc<StoreDetailEvent, StoreDetailState> {
  StoreDetailBloc() : super(StoreDetailFetchInitial());
  final StoreRepository _storesRepository = new StoreRepository();
  @override
  Stream<StoreDetailState> mapEventToState(StoreDetailEvent event) async* {
    if (event is StoreDetailInitialEvent) {
      yield StoreDetailFetchInitial();
    }
    if (event is StoreDetailFetchEvent) {
      yield* _getStoresDetail(event.storeId);
    }
  }

  Stream<StoreDetailState> _getStoresDetail(String storeId) async* {
    try {
      yield StoreDetailLoading();
      final store = await _storesRepository.getStore(storeId);
      yield StoreDetailLoaded(store);
    } catch (e) {
      yield StoreDetailError();
    }
  }
}
