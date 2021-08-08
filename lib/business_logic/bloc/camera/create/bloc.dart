import 'dart:async';
import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraCreateBloc extends Bloc<CameraCreateEvent, CameraCreateState> {
  CameraCreateBloc() : super(CameraCreateInitial());
  final CameraRepository _camerasRepository = new CameraRepository();
  final ImageRepository _imageRepository = new ImageRepository();
  @override
  Stream<CameraCreateState> mapEventToState(CameraCreateEvent event) async* {
    if (event is CameraCreateInitialEvent) {
      yield CameraCreateInitial();
    }
    if (event is CameraCreateSubmitEvent) {
      yield* _createCamera(event.camera, event.imageFile);
    }
  }

  Stream<CameraCreateState> _createCamera(
      Camera camera, File imageFile) async* {
    try {
      yield CameraCreateLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        camera = camera.copyWith(
          cameraName: camera.cameraName,
          imageUrl: imageResult,
          macAddress: camera.macAddress,
          ipAddress: camera.ipAddress,
          rtspString: camera.rtspString,
          typeDetect: camera.typeDetect,
        );
      }
      String result = await _camerasRepository.postCamera(camera);

      if (result == 'true') {
        yield CameraCreateLoaded();
      } else {
        yield CameraCreateError(result);
      }

      // else if (result.contains("MSG-057")) {
      //   yield CameraCreateDuplicatedIPAddress("IP address is existed");
      // } else if (result.contains("MSG-058")) {
      //   yield CameraCreateDuplicatedRTSPString("RTSP String is existed");
      // } else if (result.contains('errorCodeAndMsg')) {
      //   yield CameraCreateError(result);
      // }
    } catch (e) {
      yield CameraCreateError("System can not finish this action");
    }
  }
}
