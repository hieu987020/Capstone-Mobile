import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StackDetailBloc extends Bloc<StackDetailEvent, StackDetailState> {
  StackDetailBloc() : super(StackDetailFetchInitial());
  final StackRepository _stackRepository = new StackRepository();
  @override
  Stream<StackDetailState> mapEventToState(StackDetailEvent event) async* {
    if (event is StackDetailInitialEvent) {
      yield StackDetailFetchInitial();
    }
    if (event is StackDetailFetchEvent) {
      yield* _getStacksDetail(event.stackId);
    }
  }

  Stream<StackDetailState> _getStacksDetail(String stackId) async* {
    try {
      yield StackDetailLoading();
      final stack = await _stackRepository.getStack(stackId);
      yield StackDetailLoaded(stack);
    } catch (e) {
      print("error trong stack detail bloc\n");
      print(e.toString());
      yield StackDetailError();
    }
  }
}
