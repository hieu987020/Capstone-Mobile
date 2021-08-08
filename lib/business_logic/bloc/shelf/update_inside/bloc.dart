import 'package:capstone/business_logic/bloc/shelf/update_inside/event.dart';
import 'package:capstone/business_logic/bloc/shelf/update_inside/state.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShelfUpdateInsideBloc
    extends Bloc<ShelfUpdateInsideEvent, ShelfUpdateInsideState> {
  ShelfUpdateInsideBloc() : super(ShelfUpdateInsideInitial());
  final ShelfRepository shelfRepository = new ShelfRepository();

  @override
  Stream<ShelfUpdateInsideState> mapEventToState(
      ShelfUpdateInsideEvent event) async* {
    if (event is ShelfUpdateInsideInitialEvent) {
      yield ShelfUpdateInsideInitial();
    }
    if (event is ShelfMapCameraEvent) {
      yield* _mapCamera(event.shelfId, event.cameraId, event.action);
    }
    if (event is ShelfChangeStatus) {
      yield* _shelfChangeStatus(
          event.shelfId, event.statusId, event.reasonInactive);
    }
  }

  Stream<ShelfUpdateInsideState> _mapCamera(
      String shelfId, String cameraId, int action) async* {
    try {
      yield ShelfUpdateInsideLoading();
      String response =
          await shelfRepository.changeCamera(shelfId, cameraId, action);
      if (response == 'true') {
        yield ShelfUpdateInsideLoaded();
      } else {
        yield ShelfUpdateInsideError(response);
      }
    } catch (e) {
      yield ShelfUpdateInsideError(null);
    }
  }

  Stream<ShelfUpdateInsideState> _shelfChangeStatus(
      String shelfId, int statusId, String reasonInactive) async* {
    try {
      yield ShelfUpdateInsideLoading();
      String response =
          await shelfRepository.changeStatus(shelfId, statusId, reasonInactive);
      if (response == 'true') {
        yield ShelfUpdateInsideLoaded();
      } else {
        yield ShelfUpdateInsideError(response);
      }
    } catch (e) {
      yield ShelfUpdateInsideError("System can not finish this action");
    }
  }
}
