import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class UsersRepository {
  final UsersApi userApi = new UsersApi();

  Future<Users> getUser(String userName) async {
    final String rawBody = await userApi.getUser(userName);
    var jsonResponse = json.decode(rawBody);
    return Users.jsonToUser(jsonResponse);
  }

  Future<List<Users>> getUsers() async {
    final String rawBody = await userApi.getUsers();
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['managers'] as List)
        .map((e) => Users.jsonToUsers(e))
        .toList();
  }

  Future<List<Users>> getUsersActive() async {
    final String rawBody = await userApi.getUsers();
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['managers'] as List)
        .map((e) => Users.jsonToUsers(e))
        .toList();
  }

  Future<List<Users>> getUsersPending() async {
    final String rawBody = await userApi.getUsers();
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['managers'] as List)
        .map((e) => Users.jsonToUsers(e))
        .toList();
  }

  Future<List<Users>> getUsersInactive() async {
    final String rawBody = await userApi.getUsers();
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['managers'] as List)
        .map((e) => Users.jsonToUsers(e))
        .toList();
  }
}
