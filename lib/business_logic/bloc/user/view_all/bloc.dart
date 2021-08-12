import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());
  final UserRepository userRepository = new UserRepository();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserInitialState) {
      yield UserInitialState();
    } else if (event is UserFetchEvent) {
      yield* _getUsers(event.searchValue, event.searchField, event.pageNum,
          event.fetchNext, event.statusId, event.users);
    }
  }

  Stream<UserState> _getUsers(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId, List<User> usersBefore) async* {
    try {
      yield UserLoading();

      final users = await userRepository.getUsers(
          searchValue, searchField, pageNum, fetchNext, statusId);

      // if (users == null && pageNum > 1) {
      //   yield UserLoaded(users, true);
      // } else {
      //   if (usersBefore != null) {
      //     usersBefore.addAll(users);
      //     yield UserLoadedMore(usersBefore, false);
      //   } else {
      //     yield UserLoaded(users, false);
      //   }
      // }
      yield UserLoaded(users, false);
    } catch (e) {
      yield UserError();
    }
  }
}
