import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraFetchInitial());
  final CameraRepository cameraRepository = new CameraRepository();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is CameraFetchInitial) {
      _getCameras(StatusIntBase.All);
    } else if (event is CameraFetchEvent) {
      yield* _getCameras(event.statusId);
    } else if (event is CameraSearchEvent) {
      yield* _searchCameras(event.cameraName);
    } else if (event is CameraAvailableEvent) {
      yield* _getAvailableCameras(event.statusId, event.typeId);
    }
  }

  Stream<CameraState> _getCameras(int statusId) async* {
    try {
      yield CameraLoading();

      final cameras = await cameraRepository.getCameras(
          "", "", statusId, PageNumBase.Default, FetchNextBase.Default);

      yield CameraLoaded(cameras);
    } catch (e) {
      yield CameraError();
    }
  }

  Stream<CameraState> _getAvailableCameras(int statusId, int typeId) async* {
    try {
      yield CameraLoading();

      final cameras = await cameraRepository.getAvailableCameras(
          "", PageNumBase.Default, FetchNextBase.Default, typeId);

      yield CameraLoaded(cameras);
    } catch (e) {
      yield CameraError();
    }
  }

  Stream<CameraState> _searchCameras(String cameraName) async* {
    try {
      yield CameraLoading();
      final cameras = await cameraRepository.getCameras(
          "", cameraName, 0, PageNumBase.Default, FetchNextBase.Default);
      yield CameraLoaded(cameras);
    } catch (e) {
      yield CameraError();
    }
  }
}
