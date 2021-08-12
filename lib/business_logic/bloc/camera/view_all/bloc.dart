import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitialState());
  final CameraRepository cameraRepository = new CameraRepository();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is CameraFetchInitial) {
      yield CameraInitialState();
    } else if (event is CameraFetchEvent) {
      yield* _getCameras(event.storeId, event.cameraName, event.statusId,
          event.pageNum, event.fetchNext);
    } else if (event is CameraAvailableEvent) {
      yield* _getAvailableCameras(
          event.cameraName, event.pageNum, event.fetchNext, event.typeId);
    }
  }

  Stream<CameraState> _getCameras(String storeId, String cameraName,
      int statusId, int pageNum, int fetchNext) async* {
    try {
      yield CameraLoading();

      final cameras = await cameraRepository.getCameras(
          storeId, cameraName, statusId, pageNum, fetchNext);

      yield CameraLoaded(cameras);
    } catch (e) {
      yield CameraError();
    }
  }

  Stream<CameraState> _getAvailableCameras(
      String cameraName, int pageNum, int fetchNext, int typeId) async* {
    try {
      yield CameraLoading();

      final cameras = await cameraRepository.getAvailableCameras(
          cameraName, pageNum, fetchNext, typeId);

      yield CameraLoaded(cameras);
    } catch (e) {
      yield CameraError();
    }
  }
}
