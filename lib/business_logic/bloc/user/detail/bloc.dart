import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc() : super(UserDetailFetchInitial());
  final UserRepository _usersRepository = new UserRepository();
  @override
  Stream<UserDetailState> mapEventToState(UserDetailEvent event) async* {
    if (event is UserDetailInitialEvent) {
      yield UserDetailFetchInitial();
    }
    if (event is UserDetailFetchEvent) {
      yield* _getUsersDetail(event.userName);
    }
  }

  Stream<UserDetailState> _getUsersDetail(String userName) async* {
    try {
      yield UserDetailLoading();
      final user = await _usersRepository.getUser(userName);
      yield UserDetailLoaded(user);
    } catch (e) {
      yield UserDetailError();
    }
  }
}
