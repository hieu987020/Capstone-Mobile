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
    if (event is UserChangeStatus) {
      yield* _userChangeStatus(
          event.userName, event.statusId, event.reasonInactive);
    }
    if (event is UserResetPassword) {
      yield* _userResetPassword(event.userName, event.email);
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
      yield UserUpdateInsideError("System can not finish this action");
    }
  }

  Stream<UserUpdateInsideState> _userChangeStatus(
      String userName, int statusId, String reasonInactive) async* {
    try {
      yield UserUpdateInsideLoading();
      String response = await _userRepository.changeStatus(
          userName, statusId, reasonInactive);
      if (response == 'true') {
        yield UserUpdateInsideLoaded();
      } else {
        yield UserUpdateInsideError(response);
      }
    } catch (e) {
      yield UserUpdateInsideError("System can not finish this action");
    }
  }

  Stream<UserUpdateInsideState> _userResetPassword(
      String userName, String email) async* {
    try {
      yield UserUpdateInsideLoading();
      String response = await _userRepository.resetPassword(userName, email);
      if (response == 'true') {
        yield UserUpdateInsideLoaded();
      } else {
        yield UserUpdateInsideError(response);
      }
    } catch (e) {
      yield UserUpdateInsideError("System can not finish this action");
    }
  }
}
