import 'dart:convert';
import 'dart:developer';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class UserRepository {
  final UserApi _api = new UserApi();
  Future<User> getUser(String userName) async {
    final String rawBody = await _api.getUser(userName);
    var jsonResponse = json.decode(rawBody);
    return User.fromJson(jsonResponse);
  }

  Future<List<User>> getUsers(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId) async {
    final String rawBody = await _api.getUsers(
        searchValue, searchField, pageNum, fetchNext, statusId);

    var jsonResponse = json.decode(rawBody);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }

    print("======================================\n");
    String total;
    for (var entry in jsonResponse.entries) {
      if (entry.key.toString().contains('totalOfRecord')) {
        total = entry.value.toString();
      }
    }
    log(total);

    return (jsonResponse['managers'] as List)
        .map((e) => User.fromJsonLst(e))
        .toList();
  }

  Future<List<User>> getUsersByUserName(String userName) async {
    final String rawBody = await _api.getUsersByUserName(userName);
    var jsonResponse = json.decode(rawBody);
    if (jsonResponse
        .toString()
        .contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['managers'] as List)
        .map((e) => User.fromJsonLst(e))
        .toList();
  }

  Future<String> resetPassword(String userName, String email) async {
    final String response = await _api.resetPassword(userName, email);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> changeStatus(
      String userName, int statusId, String reasonInactive) async {
    Map<String, dynamic> jsonChangeStatus;
    if (reasonInactive == null) {
      jsonChangeStatus = {
        "userName": userName,
        "statusId": statusId,
      };
    } else {
      jsonChangeStatus = {
        "userName": userName,
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

  Future<String> updateUser(User user) async {
    var userCreateJson = jsonEncode(user.toJson());
    final String response = await _api.updateUser(userCreateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> postUser(User user) async {
    var userCreateJson = jsonEncode(user.toJson());
    final String response = await _api.postUser(userCreateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }
}
