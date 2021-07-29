import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class StackBloc extends Bloc<StackEvent, StackState> {
  StackBloc() : super(StackFetchInitial());
  final StackRepository stackRepository = new StackRepository();

  @override
  Stream<StackState> mapEventToState(StackEvent event) async* {
    if (event is StackFetchInitial) {
      yield StackFetchInitial();
    } else if (event is StackFetchEvent) {
      yield* _getStacks(event.shelfId);
    }
  }

  Stream<StackState> _getStacks(String shelfId) async* {
    try {
      yield StackLoading();
      final stacks = await stackRepository.getStacks(shelfId);
      yield StackLoaded(stacks);
    } catch (e) {
      print(e.toString());
      yield StackError();
    }
  }
}
