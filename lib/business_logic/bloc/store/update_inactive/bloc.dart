import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreInactiveBloc extends Bloc<StoreInactiveEvent, StoreInactiveState> {
  StoreInactiveBloc() : super(StoreInactiveInitial());
  final StoreRepository _userRepository = new StoreRepository();

  @override
  Stream<StoreInactiveState> mapEventToState(StoreInactiveEvent event) async* {
    if (event is StoreUpdateInsideEvent) {
      yield StoreInactiveInitial();
    }
    if (event is StoreChangeToInactive) {
      yield* _userChangeToInactive(event.storeId, event.reasonInactive);
    }
  }

  Stream<StoreInactiveState> _userChangeToInactive(
      String userName, String reasonInactive) async* {
    try {
      yield StoreInactiveLoading();
      String response = await _userRepository.changeStatus(
          userName, StatusIntBase.Inactive, reasonInactive);
      if (response == 'true') {
        yield StoreInactiveLoaded();
      } else {
        yield StoreInactiveError(response);
      }
    } catch (e) {
      yield StoreInactiveError("System can not finish this action");
    }
  }
}
