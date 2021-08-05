import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraUpdateInsideBloc
    extends Bloc<CameraUpdateInsideEvent, CameraUpdateInsideState> {
  CameraUpdateInsideBloc() : super(CameraUpdateInsideInitial());
  final CameraRepository _cameraRepository = new CameraRepository();
  @override
  Stream<CameraUpdateInsideState> mapEventToState(
      CameraUpdateInsideEvent event) async* {
    if (event is CameraUpdateInsideEvent) {
      yield CameraUpdateInsideInitial();
    }
    if (event is CameraChangeStatus) {
      yield* _cameraChangeStatus(
          event.cameraId, event.statusId, event.reasonInactive);
    }
  }

  Stream<CameraUpdateInsideState> _cameraChangeStatus(
      String cameraId, int statusId, String reasonInactive) async* {
    try {
      yield CameraUpdateInsideLoading();
      String response = await _cameraRepository.changeStatus(
          cameraId, statusId, reasonInactive);
      if (response == 'true') {
        yield CameraUpdateInsideLoaded();
      } else {
        yield CameraUpdateInsideError(response);
      }
    } catch (e) {
      yield CameraUpdateInsideError(e);
    }
  }
}
