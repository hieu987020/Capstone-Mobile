import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class StoreRepository {
  final StoreApi _api = new StoreApi();

  Future<Store> getStore(String userName) async {
    final String rawBody = await _api.getStore(userName);
    var jsonResponse = json.decode(rawBody);
    return Store.fromJson(jsonResponse);
  }

  Future<List<Store>> getStores(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId) async {
    final String rawBody = await _api.getStores(
        searchValue, searchField, pageNum, fetchNext, statusId);
    var jsonResponse = json.decode(rawBody);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['stores'] as List)
        .map((e) => Store.fromJsonLst(e))
        .toList();
  }

  Future<List<Store>> getOperationStores() async {
    final String rawBody = await _api.getOperationStores();
    var jsonResponse = json.decode(rawBody);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['stores'] as List)
        .map((e) => Store.fromJsonLst(e))
        .toList();
  }

  Future<List<Store>> getStoresByProduct(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId, String productId) async {
    final String rawBody = await _api.getStoresByProduct(
        searchValue, searchField, pageNum, fetchNext, statusId, productId);
    var jsonResponse = json.decode(rawBody);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['stores'] as List)
        .map((e) => Store.fromJsonLst(e))
        .toList();
  }

  Future<String> changeStatus(
      String storeId, int statusId, String reasonInactive) async {
    Map<String, dynamic> jsonChangeStatus;
    if (reasonInactive == null) {
      jsonChangeStatus = {
        "storeId": storeId,
        "statusId": statusId,
      };
    } else {
      jsonChangeStatus = {
        "storeId": storeId,
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

  Future<List<Store>> getStoresByStoreName(String storeName) async {
    final String rawBody = await _api.getStoresByStoreName(storeName);
    var jsonResponse = json.decode(rawBody);
    if (jsonResponse
        .toString()
        .contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['stores'] as List)
        .map((e) => Store.fromJsonLst(e))
        .toList();
  }

  Future<String> changeManager(
      String userId, String storeId, int active) async {
    Map<String, dynamic> jsonMapStore = {
      "storeId": storeId,
      "userId": userId,
      "active": active,
    };
    var jsonUpt = jsonEncode(jsonMapStore);
    final String response = await _api.changeManager(jsonUpt);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> updateStore(Store store) async {
    var storeCreateJson = jsonEncode(store.toJson());
    final String response = await _api.updateStore(storeCreateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> postStore(Store user) async {
    var json = jsonEncode(user.toJson());
    String response = await _api.postStore(json);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }
}
