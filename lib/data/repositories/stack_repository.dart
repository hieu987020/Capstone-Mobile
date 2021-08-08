import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class StackRepository {
  final StackApi _api = new StackApi();
  Future<StackModel> getStack(String stackId) async {
    final String rawBody = await _api.getStack(stackId);
    var jsonResponse = json.decode(rawBody);
    return StackModel.fromJson(jsonResponse);
  }

  Future<List<StackModel>> getStacks(String shelfId) async {
    final String rawBody = await _api.getStacks(shelfId);

    var jsonResponse = json.decode(rawBody);
    if (jsonResponse
        .toString()
        .contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    print("======================================\n");
    String total;
    for (var entry in jsonResponse.entries) {
      if (entry.key.toString().contains('totalOfRecord')) {
        total = entry.value.toString();
      }
    }
    print(total);

    return (jsonResponse['stacks'] as List)
        .map((e) => StackModel.fromJson(e))
        .toList();
  }

  Future<String> changeStatus(
      String stackId, int statusId, String reasonInactive) async {
    Map<String, dynamic> jsonChangeStatus;
    if (reasonInactive == null) {
      jsonChangeStatus = {
        "stackId": stackId,
        "statusId": statusId,
      };
    } else {
      jsonChangeStatus = {
        "stackId": stackId,
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

  Future<String> changeProduct(
      String stackId, String productId, int action) async {
    Map<String, dynamic> jsonMapStore = {
      "stackId": stackId,
      "productId": productId,
      "action": action,
    };
    var jsonUpt = jsonEncode(jsonMapStore);
    final String response = await _api.changeProduct(jsonUpt);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return 'true';
  }

  Future<String> changeCamera(
      String stackId, String cameraId, int action) async {
    Map<String, dynamic> jsonMapStore = {
      "stackId": stackId,
      "cameraId": cameraId,
      "action": action,
    };
    var jsonUpt = jsonEncode(jsonMapStore);
    final String response = await _api.changeCamera(jsonUpt);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return 'true';
  }

  // Future<String> updateStack(StackModel stack) async {
  //   var stackCreateJson = jsonEncode(stack.toJson());
  //   final String response = await _api.updateStack(stackCreateJson);
  //   if (response.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
  //     return response;
  //   }
  //   return 'true';
  // }

  // Future<String> postStack(StackModel stack) async {
  //   var stackCreateJson = jsonEncode(stack.toJson());
  //   final String response = await _api.postStack(stackCreateJson);
  //   if (response.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
  //     return response;
  //   }
  //   return 'true';
  // }
}
