import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc() : super(UserSearchInitial());
  final UserRepository userRepository = new UserRepository();

  @override
  Stream<UserSearchState> mapEventToState(UserSearchEvent event) async* {
    if (event is UserSearchInitial) {
    } else if (event is UserEnterSearchEvent) {
      yield* _searchUsers(event.userName);
    }
  }

  Stream<UserSearchState> _searchUsers(String userName) async* {
    try {
      yield UserSearchLoading();
      final users = await userRepository.getUsers(
          userName,
          SearchFieldBase.UserName,
          PageNumBase.Default,
          FetchNextBase.Default,
          0);
      //final users = await userRepository.getUsersByUserName(userName);
      yield UserSearchLoaded(users);
    } catch (e) {
      yield UserSearchError();
    }
  }
}
