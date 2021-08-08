import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/camera_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraUpdateBloc extends Bloc<CameraUpdateEvent, CameraUpdateState> {
  CameraUpdateBloc() : super(CameraUpdateInitial());

  final CameraRepository _camerasRepository = new CameraRepository();

  @override
  Stream<CameraUpdateState> mapEventToState(CameraUpdateEvent event) async* {
    if (event is CameraUpdateInitialEvent) {
      yield CameraUpdateInitial();
    }
    if (event is CameraUpdateSubmit) {
      yield* _updateCamera(event.camera);
    }
  }

  Stream<CameraUpdateState> _updateCamera(Camera camera) async* {
    try {
      yield CameraUpdateLoading();
      String result = await _camerasRepository.updateCamera(camera);
      if (result == 'true') {
        yield CameraUpdateLoaded();
      } else {
        yield CameraUpdateError(result);
      }
    } catch (e) {
      yield CameraUpdateError(e);
    }
  }
}
