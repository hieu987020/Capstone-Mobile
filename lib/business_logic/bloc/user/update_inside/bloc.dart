import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUpdateInsideBloc
    extends Bloc<UserUpdateInsideEvent, UserUpdateInsideState> {
  UserUpdateInsideBloc() : super(UserUpdateInsideInitial());
  final StoreRepository _storeRepository = new StoreRepository();
  final UserRepository _userRepository = new UserRepository();
  @override
  Stream<UserUpdateInsideState> mapEventToState(
      UserUpdateInsideEvent event) async* {
    if (event is UserUpdateInsideEvent) {
      yield UserUpdateInsideInitial();
    }
    if (event is UserMapStoreEvent) {
      yield* _userChooseStore(event.managerId, event.storeId, event.active);
    }
    if (event is UserChangeToPending) {
      yield* _userChangeToPending(event.userName, event.statusId);
    }
  }

  Stream<UserUpdateInsideState> _userChooseStore(
      String managerId, String storeId, int active) async* {
    try {
      yield UserUpdateInsideLoading();
      String response =
          await _storeRepository.changeManager(managerId, storeId, active);
      if (response == 'true') {
        yield UserUpdateInsideLoaded();
      } else {
        yield UserUpdateInsideError(response);
      }
    } catch (e) {
      yield UserUpdateInsideError(e);
    }
  }

  Stream<UserUpdateInsideState> _userChangeToPending(
      String userName, int statusId) async* {
    try {
      yield UserUpdateInsideLoading();
      String response =
          await _userRepository.changeStatus(userName, statusId, null);
      if (response == 'true') {
        yield UserUpdateInsideLoaded();
      } else {
        yield UserUpdateInsideError(response);
      }
    } catch (e) {
      yield UserUpdateInsideError(e);
    }
  }
}
