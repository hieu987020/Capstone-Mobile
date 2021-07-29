import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInactiveBloc extends Bloc<UserInactiveEvent, UserInactiveState> {
  UserInactiveBloc() : super(UserInactiveInitial());
  final UserRepository _userRepository = new UserRepository();

  @override
  Stream<UserInactiveState> mapEventToState(UserInactiveEvent event) async* {
    if (event is UserUpdateInsideEvent) {
      yield UserInactiveInitial();
    }
    if (event is UserChangeToInactive) {
      yield* _userChangeToInactive(event.userName, event.reasonInactive);
    }
  }

  Stream<UserInactiveState> _userChangeToInactive(
      String userName, String reasonInactive) async* {
    try {
      yield UserInactiveLoading();
      String response = await _userRepository.changeStatus(
          userName, StatusIntBase.Inactive, reasonInactive);
      if (response == 'true') {
        yield UserInactiveLoaded();
      } else {
        yield UserInactiveError(response);
      }
    } catch (e) {
      yield UserInactiveError(e);
    }
  }
}
