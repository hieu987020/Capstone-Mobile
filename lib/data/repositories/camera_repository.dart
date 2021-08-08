import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class CameraRepository {
  final CameraApi _api = new CameraApi();

  Future<Camera> getCamera(String cameraId) async {
    final String rawBody = await _api.getCamera(cameraId);
    if (rawBody.contains("MSG-120")) {
      return null;
    }
    var jsonResponse = json.decode(rawBody);
    return Camera.fromJson(jsonResponse);
  }

  Future<List<Camera>> getCameras(String storeId, String cameraName,
      int statusId, int pageNum, int fetchNext) async {
    final String rawBody = await _api.getCameras(
        storeId, cameraName, statusId, pageNum, fetchNext);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['cameras'] as List)
        .map((e) => Camera.fromJsonLst(e))
        .toList();
  }

  Future<List<Camera>> getAvailableCameras(
      String cameraName, int pageNum, int fetchNext, int typeDetect) async {
    final String rawBody = await _api.getAvailableCameras(
        cameraName, pageNum, fetchNext, typeDetect);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['cameras'] as List)
        .map((e) => Camera.fromJsonLst(e))
        .toList();
  }

  Future<String> changeStatus(
      String cameraId, int statusId, String reasonInactive) async {
    Map<String, dynamic> jsonChangeStatus;
    if (reasonInactive == null) {
      jsonChangeStatus = {
        "cameraId": cameraId,
        "statusId": statusId,
      };
    } else {
      jsonChangeStatus = {
        "cameraId": cameraId,
        "statusId": statusId,
        "reasonInactive": reasonInactive,
      };
    }
    var userCreateJson = jsonEncode(jsonChangeStatus);
    final String response = await _api.changeStatus(userCreateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> updateCamera(Camera camera) async {
    var cameraUpdateJson = jsonEncode(camera.toJson());
    final String response = await _api.updateCamera(cameraUpdateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> postCamera(Camera user) async {
    var json = jsonEncode(user.toJson());
    String response = await _api.postCamera(json);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }
}
