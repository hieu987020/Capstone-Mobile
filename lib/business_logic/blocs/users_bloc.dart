import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/blocs/blocs.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(LoadingState()) {
    getAllUsers();
  }
  final UsersRepository userRepository = new UsersRepository();
  Stream<UsersState> getAllUsers() async* {
    try {
      yield LoadingState();
      final users = await userRepository.getUsers();
      yield LoadedState(users);
    } catch (e) {
      yield ErrorState();
    }
  }

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is InitEvent) {
      try {
        yield LoadingState();
        final users = await userRepository.getUsers();
        yield LoadedState(users);
      } catch (e) {
        yield ErrorState();
        print(e);
      }
    }
  }
}
