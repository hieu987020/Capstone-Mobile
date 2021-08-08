import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreUpdateInsideBloc
    extends Bloc<StoreUpdateInsideEvent, StoreUpdateInsideState> {
  StoreUpdateInsideBloc() : super(StoreUpdateInsideInitial());
  final StoreRepository _storeRepository = new StoreRepository();
  final StoreRepository _userRepository = new StoreRepository();
  @override
  Stream<StoreUpdateInsideState> mapEventToState(
      StoreUpdateInsideEvent event) async* {
    if (event is StoreUpdateInsideEvent) {
      yield StoreUpdateInsideInitial();
    }
    if (event is StoreMapManagerEvent) {
      yield* _userChooseStore(event.managerId, event.storeId, event.active);
    }
    if (event is StoreChangeStatus) {
      yield* _storeChangeStatus(
          event.userName, event.statusId, event.reasonInactive);
    }
  }

  Stream<StoreUpdateInsideState> _userChooseStore(
      String managerId, String storeId, int active) async* {
    try {
      yield StoreUpdateInsideLoading();
      String response =
          await _storeRepository.changeManager(managerId, storeId, active);
      if (response == 'true') {
        yield StoreUpdateInsideLoaded();
      } else {
        yield StoreUpdateInsideError(response);
      }
    } catch (e) {
      yield StoreUpdateInsideError(e);
    }
  }

  Stream<StoreUpdateInsideState> _storeChangeStatus(
      String userName, int statusId, String reasonInactive) async* {
    try {
      yield StoreUpdateInsideLoading();
      String response = await _userRepository.changeStatus(
          userName, statusId, reasonInactive);
      if (response == 'true') {
        yield StoreUpdateInsideLoaded();
      } else {
        yield StoreUpdateInsideError(response);
      }
    } catch (e) {
      yield StoreUpdateInsideError("System can not finish this action");
    }
  }
}
