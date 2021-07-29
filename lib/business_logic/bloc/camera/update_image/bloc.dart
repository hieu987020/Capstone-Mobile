import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/image_repository.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraUpdateImageBloc
    extends Bloc<CameraUpdateImageEvent, CameraUpdateImageState> {
  CameraUpdateImageBloc() : super(CameraUpdateImageInitial());

  final CameraRepository _cameraRepository = new CameraRepository();
  final ImageRepository _imageRepository = new ImageRepository();

  @override
  Stream<CameraUpdateImageState> mapEventToState(
      CameraUpdateImageEvent event) async* {
    if (event is CameraUpdateImageInitialEvent) {
      yield CameraUpdateImageInitial();
    }
    if (event is CameraUpdateImageSubmit) {
      yield* _updateImage(event.camera, event.imageFile);
    }
  }

  Stream<CameraUpdateImageState> _updateImage(
      Camera camera, File imageFile) async* {
    try {
      yield CameraUpdateImageLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        camera = camera.copyWith(
          cameraName: camera.cameraName,
          imageUrl: imageResult,
          ipAddress: camera.ipAddress,
          rtspString: camera.rtspString,
          typeDetect: camera.typeDetect,
        );
      }
      String result = await _cameraRepository.updateCamera(camera);
      print(result);
      if (result == 'true') {
        yield CameraUpdateImageLoaded();
      } else if (result.contains('errorCodeAndMsg')) {
        yield CameraUpdateImageError(result);
      }
    } catch (e) {
      yield CameraUpdateImageError(e);
    }
  }
}
