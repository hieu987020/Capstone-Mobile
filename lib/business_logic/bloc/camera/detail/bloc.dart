import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/camera_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraDetailBloc extends Bloc<CameraDetailEvent, CameraDetailState> {
  CameraDetailBloc() : super(CameraDetailFetchInitial());
  final CameraRepository _camerasRepository = new CameraRepository();
  @override
  Stream<CameraDetailState> mapEventToState(CameraDetailEvent event) async* {
    if (event is CameraDetailInitialEvent) {
      yield CameraDetailFetchInitial();
    }
    if (event is CameraDetailFetchEvent) {
      yield* _getCamerasDetail(event.cameraId);
    }
  }

  Stream<CameraDetailState> _getCamerasDetail(String cameraId) async* {
    try {
      yield CameraDetailLoading();
      final camera = await _camerasRepository.getCamera(cameraId);
      yield CameraDetailLoaded(camera);
    } catch (e) {
      print(e);
      yield CameraDetailError();
    }
  }
}
