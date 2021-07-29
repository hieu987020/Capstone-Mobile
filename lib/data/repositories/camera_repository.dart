import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class CameraRepository {
  final CameraApi _api = new CameraApi();

  Future<Camera> getCamera(String cameraId) async {
    final String rawBody = await _api.getCamera(cameraId);
    var jsonResponse = json.decode(rawBody);
    return Camera.fromJson(jsonResponse);
  }

  Future<List<Camera>> getCameras(String storeId, String cameraName,
      int statusId, int pageNum, int fetchNext) async {
    final String rawBody = await _api.getCameras(
        storeId, cameraName, statusId, pageNum, fetchNext);
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['cameras'] as List)
        .map((e) => Camera.fromJsonLst(e))
        .toList();
  }

  Future<String> updateCamera(Camera camera) async {
    var cameraUpdateJson = jsonEncode(camera.toJson());
    final String response = await _api.updateCamera(cameraUpdateJson);
    if (response.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return response;
    }
    return 'true';
  }

  Future<String> postCamera(Camera user) async {
    var json = jsonEncode(user.toJson());
    String response = await _api.postCamera(json);
    if (response.contains('true') == true &&
        response.contains('errorCodeAndMsg') == false) {
      return 'true';
    } else {
      return response;
    }
  }
}
