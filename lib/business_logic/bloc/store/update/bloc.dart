import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/store_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreUpdateBloc extends Bloc<StoreUpdateEvent, StoreUpdateState> {
  StoreUpdateBloc() : super(StoreUpdateInitial());

  final StoreRepository _storesRepository = new StoreRepository();

  @override
  Stream<StoreUpdateState> mapEventToState(StoreUpdateEvent event) async* {
    if (event is StoreUpdateShowForm) {
      yield StoreUpdateInitial();
    }
    if (event is StoreUpdateSubmit) {
      yield* _updateStore(event.store);
    }
  }

  Stream<StoreUpdateState> _updateStore(Store store) async* {
    try {
      yield StoreUpdateLoading();
      String result = await _storesRepository.updateStore(store);
      print(result);
      if (result == 'true') {
        yield StoreUpdateLoaded();
      } else {
        yield StoreUpdateError(result);
      }
    } catch (e) {
      yield StoreUpdateError(e);
    }
  }
}
