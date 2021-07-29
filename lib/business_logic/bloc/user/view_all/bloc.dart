import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserFetchInitial());
  final UserRepository userRepository = new UserRepository();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetchInitial) {
      _getUsers(StatusIntBase.All);
    } else if (event is UserFetchEvent) {
      yield* _getUsers(event.statusId);
    }
  }

  Stream<UserState> _getUsers(int statusId) async* {
    try {
      yield UserLoading();

      final users = await userRepository.getUsers(
          SearchValueBase.Default,
          SearchFieldBase.Default,
          PageNumBase.Default,
          FetchNextBase.Default,
          statusId);

      yield UserLoaded(users);
    } catch (e) {
      yield UserError();
    }
  }
}
