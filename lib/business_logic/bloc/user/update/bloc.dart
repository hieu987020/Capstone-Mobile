import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  UserUpdateBloc() : super(UserUpdateInitial());

  final UserRepository _usersRepository = new UserRepository();

  @override
  Stream<UserUpdateState> mapEventToState(UserUpdateEvent event) async* {
    if (event is UserUpdateInitialEvent) {
      yield UserUpdateInitial();
    }
    if (event is UserUpdateSubmit) {
      yield* _updateUser(event.user);
    }
    if (event is UserChangePassword) {
      yield* _changePassword(event.userName, event.oldPassword,
          event.oldPassword, event.retypePassword);
    }
  }

  Stream<UserUpdateState> _updateUser(User user) async* {
    try {
      yield UserUpdateLoading();
      String result = await _usersRepository.updateUser(user);
      if (result == 'true') {
        yield UserUpdateLoaded();
      } else {
        yield UserUpdateError(result);
      }
    } catch (e) {
      yield UserUpdateError("System can not finish this action");
    }
  }

  Stream<UserUpdateState> _changePassword(String userName, String oldPassword,
      String newPassword, String reType) async* {
    try {
      yield UserUpdateLoading();
      String result = await _usersRepository.changePassword(
          userName, oldPassword, newPassword, reType);
      if (result == 'true') {
        yield UserUpdateLoaded();
      } else {
        yield UserUpdateError(result);
      }
    } catch (e) {
      yield UserUpdateError("System can not finish this action");
    }
  }
}
